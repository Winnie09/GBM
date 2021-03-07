mat <- readRDS('/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/proc/tumor/matrix/count.rds')
str(mat)
ap <- sub('_.*', '', colnames(mat))
table(ap)
rdir <- '/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/proc/tumor/norm/'

libsize <- colSums(mat)
libsize <- libsize/median(libsize)

nn <- sapply(unique(ap), function(p){
  print(p)
  tmp <- mat[, ap == p, drop = FALSE]
  tmp <- sweep(tmp, 2, libsize[ap == p], '/')
  saveRDS(tmp, paste0(rdir, p, '.rds'))
  return(0)
})

