af = list.files("/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/saver/procimpute/")
data = sapply(af, function(f){
  print(f)
  d = readRDS(paste0("/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/saver/procimpute/", f))
})
d = do.call(cbind, data)
saveRDS(d, '/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/matrix/saver.rds')
