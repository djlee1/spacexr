
solveOLS<-function(S,B, solution, constrain = T){
  D<-t(S)%*%S
  d<-t(S)%*%B
  norm_factor <- norm(D,"2")
  D <- D / norm_factor
  d <- d / norm_factor
  epsilon <- 1e-7; D <- D + epsilon * diag(length(d))
  A<-cbind(diag(dim(S)[2]))
  bzero<-c(rep(0,dim(S)[2]))
  if(constrain) {
    A_const = t(rbind(1,A))
    b_const <-c(1 - sum(solution),bzero)
    solution <- quadprog::solve.QP(D,d,A_const,b_const,meq=1)$solution
  } else {
    solution <- quadprog::solve.QP(D,d,A,bzero,meq=0)$solution
  }
  names(solution)<-colnames(S)
  return(solution)
}

#solve using WLS with weights dampened by a certain dampening constant
#if constrain, constrain the weights to sum up to 1
solveIRWLS.weights <-function(S,B,nUMI, OLS=FALSE, constrain = TRUE, verbose = FALSE,
                              n.iter = 50, MIN_CHANGE = .001, bulk_mode = F, solution = NULL){
  if(!bulk_mode)
    B[B > K_val] <- K_val
  solution <- numeric(dim(S)[2])
  solution[] <- 1/length(solution)
  if(OLS) {
    solution<-solveOLS(S,B, solution, constrain = constrain) #first solve OLS, use this solution to find a starting point for the weights
    return(list(weights = solution, converged = T))
  }
  #solution <- runif(length(solution))*2 / length(solution) # random initialization
  names(solution) <- colnames(S)

  numCols <- ncol(S)
  Index <- which(upper.tri(matrix(0, ncol = numCols, nrow = numCols), diag = TRUE), arr.ind = TRUE)
  Index <- Index[order(Index[, 1], Index[, 2]), ,drop=F]
  S_mat <<- S[, Index[, 1]] * S[, Index[, 2]]


  iterations<-0 #now use dampened WLS, iterate weights until convergence
  changes<-c()
  change<-1;
  while(change > MIN_CHANGE && iterations<n.iter){
    new_solution<-solveWLS(S,B,solution, nUMI,constrain=constrain, bulk_mode = bulk_mode)
    change<-norm(as.matrix(new_solution-solution))
    if(verbose) {
      print(paste("Change:",change))
      print(solution)
    }
    solution <- new_solution
    iterations<-iterations+1
  }
  return(list(weights = solution, converged = (change <= MIN_CHANGE)))
}

#solve WLS given a dampening constant
#for ..., think of alpha, lambda, constrain = TRUE
#either bead_mode is true and nUMI is scalar
#or bead_mode is false and nUMI is vector

# scratch
#calc_log_l_vec(prediction, B)
#d_all <- calc_Q_all(B, prediction)
#eps <- 1e-12
#calc_log_l_vec(abs(S%*%(solution)), B)
#changer <- c(1,0,0,0,0,0,0,0,0,0,0,0,0,0)
#changer <- c(0,1,0,0,0,0,0,0,0,0,0,0,0,0)
#(calc_log_l_vec(abs(S%*%(c(solution + eps*changer))), B) - calc_log_l_vec(abs(S%*%(solution)), B) )/ eps

#inv <- which.max(d_all$d2_vec)
#prediction[inv]
#B[inv]
#plot(X_vals, Q_mat[2,])

solveWLS<-function(S,B,initialSol, nUMI, bulk_mode = F, constrain = F){
  solution<-pmax(initialSol,0)
  prediction = abs(S%*%solution)
  threshold = max(1e-4, nUMI * 1e-7)
  prediction[prediction < threshold] <- threshold
  gene_list = rownames(S)
  derivatives <- get_der_fast(S, B, gene_list, prediction[,1], bulk_mode = bulk_mode)
  d_vec <- -derivatives$grad
  D_mat <- psd(derivatives$hess)
  norm_factor <- norm(D_mat,"2")
  D_mat <- D_mat / norm_factor
  d_vec <- d_vec / norm_factor
  epsilon <- 1e-7; D_mat <- D_mat + epsilon * diag(length(d_vec))
  A<-cbind(diag(dim(S)[2]))
  bzero<- (-solution)
  alpha = 0.3
  if(constrain) {
    A_const = t(rbind(1,A))
    b_const <-c(1 - sum(solution),bzero)
    solution <- solution + alpha*quadprog::solve.QP(D_mat,d_vec,A_const,b_const,meq=1)$solution
  } else {
    solution <- solution + alpha*quadprog::solve.QP(D_mat,d_vec,A,bzero,meq=0)$solution
  }
  names(solution)<-colnames(S)
  return(solution)
}
#derivativeso <- get_der_fast(S, B, gene_list, prediction, bulk_mode = bulk_mode)
