setwd('/home-4/whou10@jhu.edu/scratch/Wenpin')
pca = readRDS('./GBM/res/pca.rds')
ct = readRDS('./allenBrain/data/proc/matrix/celltype.rds')
pd = data.frame(pc1 = pca[,1], pc2 = pca[,2], ct = as.factor(ct[rownames(pca)]))
library(ggplot2)
png('./GBM/res/plot/plot/allen_gl_pca.png',width=800,height=800)
ggplot() + geom_point(data=pd,aes(x=pc1,y=pc2,col=ct)) +
  theme_classic() + xlab('Principal component 1') + ylab('Principal component 2')
dev.off()
