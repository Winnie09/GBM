source('/home-4/whou10@jhu.edu/scratch/Wenpin/raisin/proc/cluster.R')
sp = as.character(commandArgs(trailingOnly = T)[[1]])
cluster(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/scranEachSampleWithAtlas/data/',sp),hclu=F,useMNN=T,useUMAP=F)
