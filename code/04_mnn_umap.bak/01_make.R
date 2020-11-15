library(umap)
d <- readRDS('/scratch/users/whou10@jhu.edu/Wenpin/GBM/res/mnn/mnn.rds')
dim <- readRDS('/scratch/users/whou10@jhu.edu/Wenpin/GBM/res/mnn/dim.rds')
d <- d[,1:dim]
d <- umap(d)$layout
saveRDS(d,file='/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/umap/umap.rds')

