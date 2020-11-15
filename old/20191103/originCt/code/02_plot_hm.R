setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/originCt/')
m = read.csv('./result/01_originCtProp.csv',header = T)
rownames(m) = m[,1]
m = as.matrix(m[,-1])
m = m[rowSums(m)!=0,]
set.seed(12345)
hclu <- hclust(dist(m))
library(gplots)
library(RColorBrewer)
mypalette <- brewer.pal(11,"RdYlBu")
morecols <- colorRampPalette(mypalette)
pdf('./plot/hm.pdf',width=6,height=8)
heatmap.2(m,col=rev(morecols(50)),trace="none")
dev.off()
