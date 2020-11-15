setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/')
d.integrated = readRDS('./seurat/addUMAP.rds')
library(Seurat)
library(ggplot2)
library(cowplot)
u = d.integrated@reductions$umap@cell.embeddings
meta = d.integrated@meta.data
dir.create(paste0('./seurat/umap/'), recursive = T, showWarnings = F)
saveRDS(u,paste0('./seurat/umap/umap.rds'))
source('/home-4/whou10@jhu.edu/scratch/Wenpin/raisin/proc/cluster.R')
cluster('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/seurat',hclu=F,useMNN=F,useUMAP=T)
