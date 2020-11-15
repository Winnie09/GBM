transfunc <- function(d) {
  log2(t(t(d) / colSums(d) *1e6)+1)
}
atlas <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/proc/matrix/count.rds')
atlas <- transfunc(atlas)
gbm <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/matrix/count.rds')
gbm <- transfunc(gbm)
sampid <- as.numeric(commandArgs(trailingOnly = T))
gbmid <- sub('_.*','',colnames(gbm))
sgbmid <- unique(gbmid)[sampid]
gbm <- gbm[,gbmid==sgbmid]
g = intersect(rownames(atlas),rownames(gbm))
atlas = atlas[g,]
gbm = gbm[g,]

samp <- read.csv('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/raw/sample_annotations.csv',as.is=T)
colnames(atlas) <- paste0(samp$external_donor_name_label[match(colnames(atlas),samp$sample_name)],'_',colnames(atlas))

data <- cbind(atlas,gbm)
rm('gbm')
rm('atlas')
batch <- sub('_.*','',colnames(data))

suppressMessages(library(scran))

cn <- colnames(data)
data <- data[rowMeans(data > 1) > 0.01,]
fit <- trendVar(data)
decomp <- decomposeVar(data,fit)
gs <- row.names(decomp)[decomp[,2] > decomp[,4]]
data <- data[gs,]
scmd <- sapply(1:length(unique(batch)),function(sp) {
  paste0("data[gs,batch==unique(batch)[",sp,"]]")
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

saveRDS(d[,1:dim],file=paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/database/res/each/mnn/',sgbmid,'.rds'))

