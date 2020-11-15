cnt = readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/matrix/count.rds')
ap = gsub('_.*','',colnames(cnt))
res <- sapply(unique(ap), function(p){
  print(p)
  tmp = cnt[, ap==p]
  dir.create(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/saver/data/',p), showWarnings = F)
  saveRDS(tmp,paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/saver/data/',p,'/genebycell.rds'))
  return(0)
})
