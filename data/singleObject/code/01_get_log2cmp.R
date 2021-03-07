library(Seurat)
source('/home-4/whou10@jhu.edu/scratch/Wenpin/resource/myfunc/01_function.R')
expr <- readRDS('/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/singleObject/Lymph/count.rds')
rc <- colSums(expr)
rc <- rc/median(rc)
expr <- t(t(expr)/rc)
expr@x <- log2(expr@x + 1)
saveRDS(expr, '/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/singleObject/Lymph/log2cpm.rds')

