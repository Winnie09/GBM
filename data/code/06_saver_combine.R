setwd('/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/imp/saver/eachSample/')
af = list.files(getwd())
am <- sapply(af, function(f){
  tmp <- readRDS(f)$estimate
  tmp <- log2(tmp + 1)
})
saveRDS(am, '/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/imp/saver/combine/log2norm_list.rds')

saver = do.call(cbind, am)
saveRDS(saver, '/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/imp/saver/combine/log2norm_matrix.rds')

count <- readRDS('/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/proc/tumor/matrix/count.rds')
rn <- rownames(count)
cn <- colnames(count)
saver2 = saver[rn, cn]
saveRDS(saver2, '/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/imp/saver/combine/log2norm_matrix_qc.rds')

