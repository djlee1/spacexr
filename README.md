---
title: "Vignettes"
author: "Dylan Cable"
data: December 22, 2021
#output: github_document
output:
  html_document:
    keep_md: yes
  pdf_document: default
  rmarkdown::html_vignette:
    keep_md: yes
vignette: |
  %\VignetteIndexEntry{vignette-readme} 
  %\VignetteEncoding{UTF-8} 
  %\VignetteEngine{knitr::rmarkdown}
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



# Vignettes: cell type identification and cell type-specific differential expression in spatial transcriptomics

<!-- badges: start -->
<!-- badges: end -->

Here, we will present examples and tutorials for how to run our computational methods for cell type identification (RCTD) and differential expression (C-SIDE) on spatial transcriptomics datasets. You may access RCTD and C-SIDE within our open-source R package [here](https://github.com/dmcable/spacexr). 

In total, we currently have 9 vignettes demonstrating the various applications of our software. These vignettes will be organized and referenced below, including applications to Slide-seq, Visium, and MERFISH data. In general, you can either view the html files (as linked to here) to view the vignette output, or you can run the raw R-markdown files on your own machine.

## Cell type identification with RCTD

The best vignette for getting started with RCTD is [spatial transcriptomics vignette](https://raw.githack.com/dmcable/spacexr/master/vignettes/spatial-transcriptomics.html).

RCTD can assign single cell types or cell type mixtures to spatial transcriptomics spots. RCTD has three modes: `doublet mode`, which assigns 1-2 cell types per spot and is recommended for technologies with high spatial resolution such as Slide-seq and MERFISH; `full mode`, which assigns any number of cell types per spot and is recommended for technologies with poor spatial resolution such as 100-micron resolution Visium; `multi mode`, an extension of `doublet mode` that can discover more than two cell types per spot as an alternative option to `full mode`. We demonstrate each mode in the following figures:

* Doublet mode: [spatial transcriptomics vignette](https://raw.githack.com/dmcable/spacexr/master/vignettes/spatial-transcriptomics.html). Also, most other vignettes use doublet mode.
* Doublet mode on MERFISH: [MERFISH nonparametric vignette](https://raw.githack.com/dmcable/spacexr/master/vignettes/merfish_nonparametric.html). 
* Full mode: [full mode on Visium hippocampus](https://raw.githack.com/dmcable/spacexr/master/vignettes/visium_full_regions.html) 
* Multi mode: [multi mode on Visium hippocampus](https://raw.githack.com/dmcable/spacexr/master/vignettes/visium_multi.html) 

## Cell type-specific differential expression with C-SIDE

The best vignette for getting started with C-SIDE is [differential expression vignette](https://raw.githack.com/dmcable/spacexr/master/vignettes/differential-expression.html).

C-SIDE can detect differential expression (DE) along one or multiple user-defined axes, termed *explanatory variables*. Although the possibilities are not limited to what is presented here, we present the following examples:

* DE across two regions: [C-SIDE across two regions in Slide-seq cerebellum](https://raw.githack.com/dmcable/spacexr/master/vignettes/CSIDE_two_regions.html).
* DE across more than two regions: [Categorical C-SIDE on Visium hippocampus](https://raw.githack.com/dmcable/spacexr/master/vignettes/visium_full_regions.html) 
* DE from cell-to-cell interactions: [C-SIDE for cell-to-cell interactions](https://raw.githack.com/dmcable/spacexr/master/vignettes/CSIDE_celltocell_interactions.html).
* DE from interactions with pathology: [C-SIDE for pathology interactions](https://raw.githack.com/dmcable/spacexr/master/vignettes/CSIDE_pathology_interactions.html).
* Nonparametric smooth spatial patterns on MERFISH: [MERFISH hypothalamus nonparametric vignette](https://raw.githack.com/dmcable/spacexr/master/vignettes/merfish_nonparametric.html). 

## Batch processing of multiple experimental replicates + population-level DE inference

Finally, when multiple experimental replicates are available, RCTD and C-SIDE can be run in batch across replicates as shown in [Population-level RCTD and C-SIDE](https://raw.githack.com/dmcable/spacexr/master/vignettes/replicates.html). This approach also allows for population-level differential expression statistical inference.
