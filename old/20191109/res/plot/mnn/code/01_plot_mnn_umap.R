flag.subsample <- as.character(commandArgs(trailingOnly = T)[[1]])
setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/')
if (flag.subsample){
  u = readRDS('./res/mnn/mnn_1e4.rds')
  plotfn <- './res/plot/plot/mnn_umap_1e4.png'
} else {
  u = readRDS('./res/mnn/mnn.rds')  
  plotfn <- './res/plot/plot/mnn_umap.png'
}
u <- u[!grepl('GBM',row.names(u)),]
pallen = sapply(row.names(u), function(i) sub(paste0(strsplit(i,'_')[[1]][1],'_'),'',i))
ct = readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/proc/matrix/celltype.rds')
ct = ct[pallen]
pd1 = data.frame(umap1=u[,1],umap2=u[,2],ct=ct)

p = ifelse(grepl('GBM',rownames(u)),'GBM','Allen')

p.bak = p
ct = readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/proc/matrix/celltype.rds')
pallen = rownames(u)[p=='Allen']
pallen = sapply(pallen, function(i) sub(paste0(strsplit(i,'_')[[1]][1],'_'),'',i))
ct = ct[match(pallen, names(ct))]
pd1 = data.frame(umap1=u[p=='Allen',1],umap2=u[p=='Allen',2],ct=ct)


p[p=='Allen'] = ct
pd3 = data.frame(umap1=u[,1],umap2=u[,2],ct=as.factor(p))

p = p.bak
p[p=='GBM'] <- sub('_.*','',rownames(u)[p=='GBM'])
pd2 <- data.frame(umap1=u[p!='Allen',1],umap2=u[p!='Allen',2],sample=p[p!='Allen'])
pd4 <- data.frame(umap1=u[,1],umap2=u[,2],ct=as.factor(p))

library(ggplot2)

png(plotfn,width=2100,height=2000)
p1 <- ggplot() + geom_point(data=pd1,aes(x=umap1,y=umap2,col=ct),alpha=0.5,size=0.2) +
  theme_classic() + xlab('UMAP1')+ylab('UMAP2')+
  theme(legend.position = 'right') +
  guides(color=guide_legend(override.aes = list(size = 5,alpha=1)))

p2 <- ggplot() + geom_point(data=pd2,aes(x=umap1,y=umap2,col=sample),alpha=0.5,size=0.2) +
  theme_classic() + xlab('UMAP1')+ylab('UMAP2')+
  theme(legend.position = 'right') +
  guides(color=guide_legend(override.aes = list(size = 5,alpha=1)))


p3 <- ggplot() + geom_point(data=pd3,aes(x=umap1,y=umap2,col=ct),alpha=0.5,size=0.2) +
  theme_classic() + xlab('UMAP1')+ylab('UMAP2')+
  theme(legend.position = 'right') +
  guides(color=guide_legend(override.aes = list(size = 5,alpha=1)))

p4 <- ggplot() + geom_point(data=pd4,aes(x=umap1,y=umap2,col=ct),alpha=0.5,size=0.2) +
  theme_classic() + xlab('UMAP1')+ylab('UMAP2')+
  theme(legend.position = 'right') +
  guides(color=guide_legend(override.aes = list(size = 5,alpha=1)))
library(gridExtra)
grid.arrange(p1,p2,p3,p4,nrow=2)
dev.off()
