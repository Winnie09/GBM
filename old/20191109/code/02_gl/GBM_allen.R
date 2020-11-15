suppressMessages(library(DESeq2))
d <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/matrix/count.rds')
p <- sub('_.*','',colnames(d))
dmean <- sapply(unique(p),function(i) rowSums(d[,p==i]))
rm('d')
a <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/proc/matrix/rawcount.rds')
am <- read.csv('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/raw/sample_annotations.csv',as.is=T)
id <- which(am[,'class_label']!='Exclude')
a <- a[,id]
am <- am[id,]
p <- am[,'external_donor_name_label']
amean <- sapply(unique(p),function(i) rowSums(a[,p==i]))

intg <- intersect(row.names(dmean),row.names(amean))
expr <- cbind(dmean[intg,],amean[intg,])
des <- (colnames(expr) %in% colnames(dmean)) + 0
dds <- DESeqDataSetFromMatrix(countData = expr,colData = data.frame(condition=factor(des)),design= ~ condition)
dds <- DESeq(dds)
res <- DESeq2::results(dds, name="condition_1_vs_0")
res <- data.frame(res)
pval <- res$pvalue
pval[is.na(pval)] <- 1
fdr <- p.adjust(pval,method='fdr')
res$fdr <- fdr
saveRDS(res,file='/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/gl/GBM_allen.rds')
