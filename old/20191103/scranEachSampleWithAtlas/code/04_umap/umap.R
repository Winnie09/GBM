source('/home-4/whou10@jhu.edu/scratch/Wenpin/raisin/proc/runumap.R')
sp = as.character(commandArgs(trailingOnly = T)[[1]])
runumap(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/scranEachSampleWithAtlas/data/',sp))
