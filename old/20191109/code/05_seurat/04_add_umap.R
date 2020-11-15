setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/')
library(Seurat)
d.integrated <- readRDS('./seurat/integrated.rds') ### 2000 246842
meta = readRDS('./seurat/meta.rds')
d.integrated@meta.data = meta
library(ggplot2)
library(cowplot)
# switch to integrated assay. The variable features of this assay are automatically
# set during IntegrateData
DefaultAssay(d.integrated) <- "integrated"
# Run the standard workflow for visualization and clustering
d.integrated <- ScaleData(d.integrated, verbose = FALSE)
d.integrated <- RunPCA(d.integrated, npcs = 30, verbose = FALSE)
d.integrated <- RunUMAP(d.integrated, reduction = "pca", dims = 1:30)
saveRDS(d.integrated,'./seurat/addUMAP.rds')

