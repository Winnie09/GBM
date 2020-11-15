setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/')
d.integrated = readRDS('./seurat/addUMAP.rds')
library(Seurat)
library(ggplot2)
library(cowplot)
u = d.integrated@reductions$umap@cell.embeddings
meta = d.integrated@meta.data
source('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/resource/function.R')
png(paste0('./plot/seurat/plot/umap_sample_allenTogether.png'),width=800,height=450)
ggplot(data.frame(umap1=u[,1],umap2=u[,2],sample=meta$sample),aes(x=umap1,y=umap2,col=sample)) + geom_point(size=0.1,alpha=0.3) + theme_scatter + theme_scatter +
  guides(color=guide_legend(override.aes = list(size = 5,alpha=1)))
dev.off()


png(paste0('./plot/seurat/plot/umap_celltype_facetDataset.png'),width=800,height=450)
ggplot(data.frame(umap1=u[,1],umap2=u[,2],dataset=meta$dataset,sample=meta$cell),aes(x=umap1,y=umap2,col=sample)) + geom_point(size=0.1,alpha=0.3) + theme_scatter + facet_wrap(~dataset)+
  guides(color=guide_legend(override.aes = list(size = 5,alpha=1))) +
  labs(color='celltype')
dev.off()

png(paste0('./plot/seurat/plot/umap_celltype.png'),width=800,height=450)
ggplot(data.frame(umap1=u[,1],umap2=u[,2],sample=meta$cell),aes(x=umap1,y=umap2,col=sample)) + geom_point(size=0.1,alpha=0.3) + theme_scatter + 
  guides(color=guide_legend(override.aes = list(size = 5,alpha=1))) +
  labs(color='celltype')
dev.off()

png(paste0('./plot/seurat/plot/umap_sample_facetDataset.png'),width=1000,height=500)
v = as.character(meta$cell)
v[v=='GBM'] = as.character(meta$sample)[v=='GBM']
ggplot(data.frame(umap1=u[,1],umap2=u[,2],dataset=meta$dataset,sample=as.factor(v)),aes(x=umap1,y=umap2,col=sample)) + geom_point(size=0.1) + theme_classic() + facet_wrap(~dataset)+
  guides(color=guide_legend(override.aes = list(size = 5,alpha=1)))
dev.off()


for (i in colnames(meta)[5:7]){
  print(i)
  library(RColorBrewer) 
  v = as.character(meta$cell)
  tmp= meta[,i]
  v[v=='GBM'] = as.character(tmp)[v=='GBM']
  tab = table(v)
  for (j in names(tab)){
    print(j)
    v[which(v==j)] <- paste0(v[which(v==j)],'(',tab[j],')')
  }
  colourCount = length(unique(v))
  getPalette = colorRampPalette(brewer.pal(9, "Set1"))
  pd = data.frame(umap1=u[,1],umap2=u[,2],dataset=meta$dataset,sample=as.factor(v))
  pd = pd[complete.cases(pd),]
  png(paste0('./plot/seurat/plot/umap_facetDataset_',i,'.png'),width=1000,height=500)
  print(ggplot(data=pd,aes(x=umap1,y=umap2,col=sample)) + geom_point(size=0.1,alpha=0.2) + theme_classic() + facet_wrap(~dataset)+
    guides(color=guide_legend(override.aes = list(size = 5,alpha=1)))+
    scale_color_manual(values=getPalette(colourCount))+
    labs(color=i))
  dev.off()
}

