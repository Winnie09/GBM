source('/home-4/whou10@jhu.edu/scratch/Wenpin/raisin/proc/runmnn.R')
sp = as.character(commandArgs(trailingOnly = T)[[1]])
runmnn(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/scranEachSampleWithAtlas/data/',sp),imputation=F,log=T)

