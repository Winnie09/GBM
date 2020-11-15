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

gbm <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/matrix/count.rds')
lib <- colSums(gbm) / 1e6
gbm = gbm[gl,]
gbm <- log2(t(t(gbm) / lib)+1)

colnames(atlas) <- paste0(am$external_donor_name_label[match(colnames(atlas),am$sample_name)],'_',colnames(atlas))

data <- cbind(atlas,gbm)
rm('gbm')
rm('atlas')
batch <- sub('_.*','',colnames(data))

suppressMessages(library(scran))

cn <- colnames(data)
#data <- data[rowMeans(data > 1) > 0.01,]
#fit <- trendVar(data)
#decomp <- decomposeVar(data,fit)
#gs <- row.names(decomp)[decomp[,2] > decomp[,4]]
#data <- data[gs,]
scmd <- sapply(1:length(unique(batch)),function(sp) {
  paste0("data[,batch==unique(batch)[",sp,"]]")
})
d <- min(50,nrow(data))
ncores <- 5
cmd <- paste0("res <- fastMNN(",paste0(scmd,collapse = ","),",BPPARAM=MulticoreParam(ncores),d=",d,')')

eval(parse(text=cmd))
d <- res$corrected
row.names(d) <- cn

v <- apply(d,2,sd)
id <- 1:length(v)

x <- 1:50
optpoint <- which.min(sapply(2:50, function(i) {
  x2 <- pmax(0, x - i)
  sum(lm(v ~ x + x2)$residuals^2)
}))
dim = optpoint + 1

saveRDS(d,file='/scratch/users/whou10@jhu.edu/Wenpin/GBM/res/mnn/mnn.rds')
saveRDS(dim,file='/scratch/users/whou10@jhu.edu/Wenpin/GBM/res/mnn/dim.rds')


