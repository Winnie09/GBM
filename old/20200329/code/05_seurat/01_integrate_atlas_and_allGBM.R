## select genes
gl <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/gl/GBM_allen.rds')
gl <- row.names(gl)[gl[,'fdr'] > 0.1]
ctgl <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/gl/allen_ct.rds')
ctgl <- unique(unlist(sapply(ctgl,function(i) {
  row.names(i)[i[,'fdr'] < 0.05 & abs(i[,'log2FoldChange']) > 1]
})))
gl <- intersect(gl,ctgl)

## load atlas
atlas <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/proc/matrix/rawcount.rds')
am <- read.csv('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/raw/sample_annotations.csv',as.is=T)
id <- which(am[,'class_label']!='Exclude')
atlas <- atlas[,id]
am <- am[id,]
# lib <- colSums(atlas) / 1e6
atlas = atlas[gl,]
# atlas <- log2(t(t(atlas) / lib)+1)

## load GBM tumors
gbm <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/matrix/count.rds')
gbm = gbm[gl,]

library(Seurat)
p = sub('_.*','',colnames(gbm))
dlist = list()
for (i in c(unique(p),'allen')){
  if (i != 'allen'){
    sgbm = gbm[,p==i]
    d <- CreateSeuratObject(counts = sgbm, project = "gbm")  
  } else {
    d <- CreateSeuratObject(counts = atlas, project = "allen")  
  }
  d <- NormalizeData(d, normalization.method = "LogNormalize", scale.factor = 10000)
  dlist[[i]] <- d <- FindVariableFeatures(d, selection.method = "vst", nfeatures = 2000)
  
  # Identify the 10 most highly variable genes
  top10 <- head(VariableFeatures(d), 10)
  
  # plot variable features with and without labels
  plot1 <- VariableFeaturePlot(d)
  plot2 <- LabelPoints(plot = plot1, points = top10, repel = TRUE)
  pdf(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/seurat/plot/plot/highlyVariableGenes_',i,'.pdf'),width=12,height=6)
  CombinePlots(plots = list(plot1, plot2))
  dev.off()
}


reference.list <- dlist[c("allen")]
d.anchors <- FindIntegrationAnchors(object.list = dlist, reference=27, dims = 1:30)
saveRDS(d.anchors,'/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/seurat/anchors.rds')
  
d.integrated <- IntegrateData(anchorset = d.anchors, dims = 1:30)
saveRDS(d.integrated,'/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/seurat/integrated.rds')





