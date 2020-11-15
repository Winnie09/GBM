setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/scranEachSampleWithAtlas/data')
ct = readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/proc/matrix/celltype.rds')
ct = ct[!ct%in%'Donor'] ## remove "Donor'
ap = list.files(getwd())
m = matrix(0,nrow=26,ncol=length(unique(ct)))
dimnames(m) = list(ap, sort(unique(ct)))
for (sp in ap){
  if (file.exists(paste0('./',sp,'/originCtProp/originCtProp.rds'))){
    prop<-readRDS(paste0('./',sp,'/originCtProp/originCtProp.rds'))  
    m[sp,names(prop)] <- prop
  } else {
    print(paste0(sp,' cannot found'))
  }
}
write.csv(m,'/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/originCt/result/01_originCtProp.csv',row.names = T)

