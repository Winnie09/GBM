library(umap)
d <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/database/res/mnn/mnn.rds')
dim <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/database/res/mnn/dim.rds')
d <- d[,1:dim]
umap <- umap(d)$layout
saveRDS(umap,file='/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/database/res/umap/umap.rds')
