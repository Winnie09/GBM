setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/')
d.integrated = readRDS('./res/seurat/addUMAP.rds')
u = d.integrated@reductions$umap@cell.embeddings
meta = d.integrated@meta.data
clu = readRDS('./res/seurat/cluster/cluster.rds')
ct = as.character(meta$cell)
sample = as.character(meta$sample)
clu = clu[rownames(u)]
allenct <- sapply(1:max(clu),function(i) {
  names(which.max(table(ct[clu==i & ct!='GBM'])))
})
gbmenrich <- sapply(1:max(clu),function(i) {
  round(mean(ct[clu==i]=='GBM')/mean(ct=='GBM'),4)
})
percent <- sapply(unique(sample),function(i) {
  sapply(1:max(clu),function(j) {
    round(sum(clu==j & sample==i)/sum(sample==i),4)
  })
})
res <- data.frame(cluster=1:max(clu),allen_celltype=allenct,gbm_enrichment=gbmenrich,percent)
write.csv(res,'./originCt/result/originCt_prop.csv',row.names = F)
saveRDS(res,'./originCt/result/originCt_prop.rds')
