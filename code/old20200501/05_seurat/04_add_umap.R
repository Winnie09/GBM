setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/')
library(Seurat)
d.integrated <- readRDS('./seurat/integrated.rds') ### 2000 246842
library(cowplot)
# switch to integrated assay. The variable features of this assay are automatically
# set during IntegrateData
DefaultAssay(d.integrated) <- "integrated"
# Run the standard workflow for visualization and clustering
d.integrated <- ScaleData(d.integrated, verbose = FALSE)
d.integrated <- RunPCA(d.integrated, npcs = 30, verbose = FALSE)
pca = d.integrated@reductions$pca@cell.embeddings
dir.create(paste0('./seurat/pca/'),showWarnings = F,recursive = T)
saveRDS(pca,paste0('./seurat/pca/pca.rds'))
print('running umap...')
d.integrated <- RunUMAP(d.integrated, reduction = "pca", dims = 1:30)
u = d.integrated@reductions$umap@cell.embeddings
dir.create(paste0('./seurat/umap/'),showWarnings = F,recursive = T)
saveRDS(u,paste0('./seurat/umap/umap.rds'))

print('saving matrix ....')
mat <- as.matrix(d.integrated@assays$RNA@counts)
saveRDS(mat,paste0('./seurat/matrix.rds'))
