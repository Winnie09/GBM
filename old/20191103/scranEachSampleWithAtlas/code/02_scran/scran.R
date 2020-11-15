source('/home-4/whou10@jhu.edu/scratch/Wenpin/raisin/proc/runscran.R')
sp = as.character(commandArgs(trailingOnly = T)[[1]])
runscran(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/scranEachSampleWithAtlas/data/',sp),normmat=T)
