gbm <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/matrix/count.rds')
gbm = log2(t(t(gbm)/colSums(gbm)*1e6)+1)
saveRDS(gbm,'/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/matrix/log2CPM.rds')
