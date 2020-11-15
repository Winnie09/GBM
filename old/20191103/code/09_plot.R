u <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/umap/umap.rds')
p <- sub('_.*','',rownames(u))
library(ggplot2)
pdf('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/plot/mnn_umap.pdf',width=6,height=4.5)
ggplot() + geom_point(data=data.frame(umap1=u[,1],umap2=u[,2],batch=as.factor(p)),aes(x=umap1,y=umap2,col=batch),alpha=0.5) + theme_classic()
dev.off()

