u = readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/database/res/combine/umap/umap.rds')
p = sub('_.*','',rownames(u))
library(ggplot2)
type <- ifelse(grepl('GBM',p),'GBM','allen')
pdf('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/database/plot/combine/mnn.pdf',width=6,height=5)
ggplot(data.frame(x=u[,1],y=u[,2],type=type),aes(x=x,y=y,col=type)) + geom_point(size=0.1,alpha=0.3) + theme_classic()+
  theme(legend.title=element_blank()) +
  xlab('UMAP1') + ylab('UMAP2') + 
  guides(color = guide_legend(override.aes = list(size = 4,alpha=1)))
dev.off()
