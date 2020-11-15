setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/')
d.integrated = readRDS('./res/seurat/addUMAP.rds')
meta = d.integrated@meta.data
res = readRDS('./originCt/result/originCt_prop.rds')
m = t(res[,grepl('GBM',colnames(res))])
colnames(m) = paste0('clu',res[,'cluster'],'(',res[,'allen_celltype'],')')
meta[,5] = as.factor(meta[,5])
meta[,6] = as.factor(meta[,6])
meta[,7] = as.factor(meta[,7])
meta1 = meta[match(rownames(m),meta$sample), 5:7]
row.names(meta1) <- row.names(m)
meta2 = read.csv('./doc/Meta_Wenpin_10292019.csv')  
meta2$Sample.ID = sapply(meta2$Sample.ID, function(i) sub(' ','',i))
meta2 = meta2[match(rownames(m), meta2$Sample.ID),]
meta2 = meta2[,!colnames(meta2)%in%c('Progression.date')]
metadata = cbind(meta[match(rownames(m),meta$sample), 5:7], meta2[,2:16])
rownames(meta1) <- rownames(meta2) <- row.names(metadata) <- row.names(m)
rownames(res) <- colnames(m)
set.seed(12345)
library(gplots)
library(RColorBrewer)
mypalette <- brewer.pal(11,"RdYlBu")
morecols <- colorRampPalette(mypalette)
morecols2 <- colorRampPalette(brewer.pal(6,"Set3"))
breaksList = seq(0, 1, by = 0.05)

my_color = sapply(colnames(meta2)[2:ncol(meta2)], function(i) {
   if (is.factor(meta2[,i])){
     n = length(levels(meta2[,i]))
     col = morecols2(n)
     names(col) = levels(meta2[,i])
   } else {
     n = length(unique(meta2[,i])) 
     col = morecols2(n)
     names(col) = unique(meta2[,i])
   }
    col  
})
pdf('./originCt/plot/hm_batch.pdf',width=10,height=10)
library(pheatmap)
pheatmap(m, show_rownames=T, cluster_cols=T, cluster_rows=T, scale="row",
         cex=1, border_color=FALSE,annotation_row=meta1,
         color = rev(morecols(20)),breaks=breaksList,
         annotation_col=res[,c('gbm_enrichment','allen')])
dev.off()

pdf('./originCt/plot/hm_clinical.pdf',width=12,height=8)
library(pheatmap)
pheatmap(m, show_rownames=T, cluster_cols=T, cluster_rows=T, scale="row",
         annotation_colors=my_color[2:14],
         cex=1, border_color=FALSE,annotation_row=meta2[,2:9],
         color = rev(morecols(20)),breaks=breaksList)
dev.off()


pdf('./originCt/plot/hm_clinical2.pdf',width=12,height=8)
library(pheatmap)
pheatmap(m, show_rownames=T, cluster_cols=T, cluster_rows=T, scale="row",
         annotation_colors=my_color[2:14],
         cex=1, border_color=FALSE,annotation_row=meta2[,10:16],
         color = rev(morecols(20)),breaks=breaksList)
dev.off()
