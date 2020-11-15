library(umap)
d <- readRDS('/scratch/users/whou10@jhu.edu/Wenpin/GBM/res/mnn/mnn_1e4.rds')
dim <- readRDS('/scratch/users/whou10@jhu.edu/Wenpin/GBM/res/mnn/dim_1e4.rds')
d <- d[,1:dim]
d <- umap(d)$layout
saveRDS(d,file='/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/umap/umap_1e4.rds')
