sp = as.character(commandArgs(trailingOnly = T)[[1]])
setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/')
d.integrated = readRDS('./seurat/addUMAP.rds')
library(Seurat)
library(ggplot2)
library(cowplot)
u = d.integrated@reductions$umap@cell.embeddings
meta = d.integrated@meta.data
clu = readRDS('./seurat/cluster/cluster.rds')
id = setdiff(1:nrow(u),which(meta$cell=='GBM' & meta$sample!=sp))
u = u[id,]
meta = meta[id,]
clu = clu[rownames(u)]
# clu = readRDS(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/scranEachSampleWithAtlas/data/',sp,'/cluster/cluster.rds'))
# u <- readRDS(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/scranEachSampleWithAtlas/data/',sp,'/umap/umap.rds'))

# ## cells celltype colors
# p = sub('_.*','',rownames(u))
# v = rownames(u)[p=='allen']
# v = sub('allen_','',v)
# meta = read.csv('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/raw/sample_annotations.csv')
# meta = meta[match(v,meta$sample_name),]
# ct = readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/proc/matrix/celltype.rds')
# ct = c(ct, rep(sp, (length(p)-length(ct))))
# names(ct) = rownames(u)
# 
# ## remove Donor
# id = which(ct!='Donor') ####
# ct = ct[id]
# ct = factor(ct,levels=c(sp, setdiff(unique(ct),sp))) ##
# u = u[id,]
# clu = clu[id]

## ct
ct = as.character(meta$cell)
names(ct) = rownames(u)
ct[ct=='GBM'] <- sp
ct = factor(ct,levels=c(sp, setdiff(unique(ct),sp))) 

## color
colv = readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/resource/colors2.rds')
colv = colv[1:length(unique(meta$cell))]
names(colv) = c(sp,setdiff(unique(ct),sp))

## clu center

cm = aggregate(u,list(clu),mean)
colnames(cm) <- c('cluster','x','y')
cluct <- sapply(unique(clu),function(i){
  ss = table(ct[names(ct)%in%names(clu[clu==i])])
  ss = ss/sum(ss)
})
colnames(cluct) = unique(clu)
library(reshape2)
pdcluct <- melt(cluct)
colnames(pdcluct) = c('ct','cluster','prop')

##

ctclu <- sapply(unique(ct),function(i){
  ss = table(clu[ct==i])
  v = rep(0,max(clu))
  names(v) <- seq(1,max(clu))
  ss = ss/sum(ss)
  v[names(ss)] = ss
  v
})
colnames(ctclu) = unique(ct)
pdctclu = melt(ctclu)
colnames(pdctclu) = c('cluster','ct','prop')
pdctclu$ct = factor(as.character(pdctclu$ct),levels = levels(pdcluct$ct))
###############################
library(ggplot2)
library(gridExtra)
dir.create('./plot/seurat/plot/umap_cluster',showWarnings = F,recursive = T)
pdf(paste0('./plot/seurat/plot/umap_cluster/',sp,'.pdf'),width=8,height=7.5)
p1 <- ggplot() + geom_point(data=data.frame(umap1=u[,1],umap2=u[,2],ct=ct),aes(x=umap1,y=umap2,col=ct),alpha=0.5,size=0.2) + 
  theme_classic() + xlab('UMAP1')+ylab('UMAP2')+
  theme(legend.position = 'right',legend.title = element_blank()) + scale_color_manual(values=colv)+
  guides(color = guide_legend(override.aes = list(size = 4,alpha=1)))
p2 <- ggplot() + geom_point(data=data.frame(umap1=u[,1],umap2=u[,2],cluster=as.factor(clu)),aes(x=umap1,y=umap2,col=cluster),alpha=0.5,size=0.2) + 
  geom_text(data=cm,aes(x=x,y=y,label=cluster),size=3) + theme_classic() + xlab('UMAP1')+ylab('UMAP2')+
  theme(legend.position = 'none')
p3 <- ggplot(pdcluct,aes(x=ct,y=cluster,fill=prop)) +
  geom_tile(aes(fill = prop), colour = "black") +
  scale_fill_gradient(low = "white",high = "steelblue")+
  theme_classic() + 
  theme(axis.text.x = element_text(angle=45,hjust=1)) + xlab('') + ylab('cluster') + ggtitle('cluster composition(rowSum=1)')
p4 <- ggplot(pdctclu,aes(x=ct,y=cluster,fill=prop))+
  geom_tile(aes(fill = prop), colour = "black") +
  scale_fill_gradient(low = "white",high = "steelblue")+
  theme_classic() + 
  theme(axis.text.x = element_text(angle=45,hjust=1)) + xlab('') + ylab('cluster') + ggtitle('celltype distribution(colSum=1)')
grid.arrange(p1,p2,p3,p4,nrow=2)
dev.off()
