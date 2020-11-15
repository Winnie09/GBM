sp = as.character(commandArgs(trailingOnly = T)[[1]])
setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/scranEachSampleWithAtlas/data')
clu = readRDS(paste0('./',sp,'/cluster/cluster.rds'))
u <- readRDS(paste0('./',sp,'/umap/umap.rds'))
ct = readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/proc/matrix/celltype.rds')
ct = ct[!ct%in%'Donor'] ## remove "Donor'
p = sub('_.*','',rownames(u))
gbmu <- u[p!='allen',]
allu <- t(u[p=='allen',])
colnames(allu) = sub('allen_','',colnames(allu))
allu = allu[, names(ct)]
nc <- sapply(1:nrow(gbmu),function(i) {
  names(which.min(colSums((allu-gbmu[i,])^2)))
})
nct <- table(ct[match(nc,names(ct))])
prop <- nct/sum(nct)
dir.create(paste0('./',sp,'/originCtProp/'),showWarnings = F)
saveRDS(prop,paste0('./',sp,'/originCtProp/originCtProp.rds'))


