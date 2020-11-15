gl <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/gl/GBM_allen.rds')
gl <- row.names(gl)[gl[,'fdr'] > 0.1]
ctgl <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/gl/allen_ct.rds')
ctgl <- unique(unlist(sapply(ctgl,function(i) {
  row.names(i)[i[,'fdr'] < 0.05 & abs(i[,'log2FoldChange']) > 1]
})))
gl <- intersect(gl,ctgl)

transfunc <- function(d) {
  log2(t(t(d) / colSums(d) *1e6)+1)
}
atlas <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/proc/matrix/rawcount.rds')
am <- read.csv('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/raw/sample_annotations.csv',as.is=T)
id <- which(am[,'class_label']!='Exclude')
atlas <- atlas[,id]
am <- am[id,]

lib <- colSums(atlas) / 1e6
atlas = atlas[gl,]
atlas <- log2(t(t(atlas) / lib)+1)

pca = prcomp(t(atlas),scale.=T)$x[,1:10]
saveRDS(pca,'/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/pca.rds')
