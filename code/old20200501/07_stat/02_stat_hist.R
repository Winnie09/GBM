data = as.character(commandArgs(trailingOnly = T)[[1]])
setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM')
pdf(paste0('./stat/',data,'/stat.pdf'),height=2,width=5)
library(ggplot2)
library(gridExtra)
d <- readRDS(paste0('./data/proc/',data,'/qc/expressedgenenumber.rds'))
p1 <- ggplot(data=data.frame(num=d)) + geom_histogram(aes(x=num),col='black',fill='steelblue',alpha=.2,binwidth = 250) + 
  theme_classic() + xlab('num.expressed.gene') + ylab('num.cell') +
  geom_vline(xintercept = c(500,1e4),col='red')

d2 <- readRDS(paste0('./data/proc/',data,'/qc/mitoproportion.rds'))
p2 <- ggplot(data=data.frame(num=d2)) + geom_histogram(aes(x=num),col='black',fill='steelblue',alpha=.2,breaks=seq(0,1,by=0.025)) + 
  theme_classic() + xlab('prop.mito') + ylab('num.cell')+
  geom_vline(xintercept = 0.2,col='red')
grid.arrange(p1,p2,nrow=1)
dev.off()
