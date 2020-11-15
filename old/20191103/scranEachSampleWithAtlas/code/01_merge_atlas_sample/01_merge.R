atlas <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/proc/matrix/count.rds')
colnames(atlas) = paste0('allen_',colnames(atlas))
gbm <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/matrix/count.rds')
g = intersect(rownames(atlas),rownames(gbm))
atlas = atlas[g,]
gbm = gbm[g,]
p = sub('_.*','',colnames(gbm))
id = as.numeric(commandArgs(trailingOnly = T)[[1]])
sp = unique(p)[id]
print(sp)
dir.create(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/scranEachSampleWithAtlas/data/',sp,'/matrix/'),recursive = T,showWarnings = F)
dir.create(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/scranEachSampleWithAtlas/data/',sp,'/scran/'),recursive = T,showWarnings = F)
tmp = cbind(atlas,gbm[,p==sp])
saveRDS(tmp,paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/scranEachSampleWithAtlas/data/',sp,'/matrix/count.rds'))



