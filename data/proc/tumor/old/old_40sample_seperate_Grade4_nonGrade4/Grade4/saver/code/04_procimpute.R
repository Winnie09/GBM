allf <- sub('.rds','',list.files('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/saver/impute/'))
res <- lapply(allf,function(f) {
  print(f)
  sexpr <- readRDS(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/saver/impute/',f,'.rds'))$estimate
  sexpr <- log2(sexpr + 1)
  saveRDS(sexpr,file=paste0("/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/saver/procimpute/",f,'.rds'))
})

