u <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/umap/umap.rds')
clu <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/cluster/cluster.rds')
cm <- aggregate(u,list(clu),mean)
colnames(cm) <- c('cluster','x','y')
library(ggplot2)
pdf('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/plot/mnn_umap_cluster.pdf',width=6,height=4.5)
ggplot() + geom_point(data=data.frame(umap1=u[,1],umap2=u[,2],cluster=as.factor(clu)),aes(x=umap1,y=umap2,col=cluster),alpha=0.5,size=0.3) + 
  geom_text(data=cm,aes(x=x,y=y,label=cluster)) + theme_classic() + xlab('UMAP1')+ylab('UMAP2')+
  theme(legend.position = 'none')
dev.off()
