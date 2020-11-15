for (f in c('M_subser.RDS', 'T_subser.RDS','L_subser.RDS')){
  print(f)
  obj <- readRDS(paste0('/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/seuratObject/', f))
  type <- sub('_.*', '', f)
  savedir <- paste0('/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/singleObject/', type,'/')
  dir.create(savedir, recursive = TRUE, showWarnings = FALSE)
  saveRDS(obj@assays$RNA@counts, paste0(savedir,'count.rds'))
  saveRDS(obj@assays$integrated@counts, paste0(savedir,'integrated_count.rds'))
  saveRDS(obj@meta.data, paste0(savedir,'meta.rds'))
}


