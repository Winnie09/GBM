sp = as.character(commandArgs(trailingOnly = T)[[1]])
u <- readRDS(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/scranEachSampleWithAtlas/data/',sp,'/umap/umap.rds'))
p = sub('_.*','',rownames(u))
v = rownames(u)[p=='allen']
v = sub('allen_','',v)
meta = read.csv('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/raw/sample_annotations.csv')
meta = meta[match(v,meta$sample_name),]
ct = readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/proc/matrix/celltype.rds')
ct = c(ct, rep(sp, (length(p)-length(ct))))
ct = factor(ct,levels=c(sp, setdiff(unique(ct),sp)))
colv = readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/resource/colors2.rds')
colv = colv[1:length(unique(ct))]
names(colv) = c(sp,setdiff(unique(ct),sp))
library(ggplot2)
library(gridExtra)
pdf(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/scranEachSampleWithAtlas/plot/umap/',sp,'.pdf'),width=4.5,height=4.5)
ggplot() + geom_point(data=data.frame(umap1=u[,1],umap2=u[,2],ct=ct),aes(x=umap1,y=umap2,col=ct),alpha=0.5,size=0.2) + 
  theme_classic() + xlab('UMAP1')+ylab('UMAP2')+
  theme(legend.position = 'bottom') + scale_color_manual(values=colv)+
  guides(color = guide_legend(override.aes = list(size = 5,alpha=1)))
dev.off()
