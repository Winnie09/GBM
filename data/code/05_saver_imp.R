# ---------
# SAVER impute 
# ---------
library(SAVER)
library(Matrix)
library(parallel)
packageVersion('SAVER')
setwd('/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/proc/tumor/norm/')
rdir <- '/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/imp/saver/eachSample/'
f <- as.character(commandArgs(trailingOnly = T)[[1]])
print(f)
d <- readRDS(f)
d.saver <- saver(d, ncores = detectCores(), size.factor = 1)
saveRDS(d.saver, paste0(rdir, f))
