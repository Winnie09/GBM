meta = readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/seurat/meta.rds')
setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/')
d.integrated = readRDS('./seurat/addUMAP.rds')
library(Seurat)
library(ggplot2)
library(cowplot)
library(gridExtra)
u = d.integrated@reductions$umap@cell.embeddings
meta = d.integrated@meta.data
source('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/resource/function.R')
id = rownames(meta)[meta$donor != 'GBM']
u = u[id,]
meta = meta[id,]
library(RColorBrewer)
mypalette <- brewer.pal(11,"Set1")
morecols <- colorRampPalette(mypalette)

png(paste0('./plot/seurat/plot/umap_allen_celltype_location_donor.png'),width=1400,height=400)
p1 <- ggplot(data.frame(umap1=u[,1],umap2=u[,2],sample=meta$cell),aes(x=umap1,y=umap2,col=sample)) + geom_point(size=0.1,alpha=0.3) + theme_scatter + theme_scatter +
  guides(color=guide_legend(override.aes = list(size = 5,alpha=1))) +
  labs(color='celltype')+
  scale_color_manual(values=rev(morecols(length(unique(meta$cell)))))

p2 <- ggplot(data.frame(umap1=u[,1],umap2=u[,2],sample=meta$region),aes(x=umap1,y=umap2,col=sample)) + geom_point(size=0.1,alpha=0.3) + theme_scatter + theme_scatter +
  guides(color=guide_legend(override.aes = list(size = 5,alpha=1))) +
  labs(color='region')+
  scale_color_manual(values=rev(morecols(length(unique(meta$region)))))
p3 <- ggplot(data.frame(umap1=u[,1],umap2=u[,2],sample=meta$donor),aes(x=umap1,y=umap2,col=sample)) + geom_point(size=0.1,alpha=0.3) + theme_scatter + theme_scatter +
  guides(color=guide_legend(override.aes = list(size = 5,alpha=1))) +
  labs(color='donor')
grid.arrange(p1,p2,p3,nrow=1)
dev.off()



