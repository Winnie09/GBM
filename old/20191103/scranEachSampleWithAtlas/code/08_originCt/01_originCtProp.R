sp = as.character(commandArgs(trailingOnly = T)[[1]])
setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/scranEachSampleWithAtlas/data')
clu = readRDS(paste0('./',sp,'/cluster/cluster.rds'))
u <- readRDS(paste0('./',sp,'/umap/umap.rds'))
ct = readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/proc/matrix/celltype.rds')
#ct = ct[!ct%in%'Donor'] ## remove "Donor'
p = sub('_.*','',rownames(u))
gbmu <- u[p!='allen',]
allu <- t(u[p=='allen',])
colnames(allu) = sub('allen_','',colnames(allu))
allu = allu[, names(ct)]
### dist to cluster center 
cm = aggregate(u,list(clu),mean)
colnames(cm) <- c('cluster','x','y')
cluct <- ct[sub('allen_','',names(clu))]
cluct[grep('^GBM',names(clu))] <- 'GBM'

cm[,1] <- sapply(cm[,1],function(i){
  ss = table(cluct[clu==i])
  names(ss)[which.max(ss)]
})
cm <- cm[cm[,1]!='GBM',]
## 
nc <- sapply(1:nrow(gbmu),function(i) {
  id <- which.min(colSums((t(cm[,2:3])-gbmu[i,])^2))
  cm[id,1]
})
prop <-  table(nc)/length(nc)
dir.create(paste0('./',sp,'/originCtProp/'),showWarnings = F)
saveRDS(prop,paste0('./',sp,'/originCtProp/originCtProp.rds'))



