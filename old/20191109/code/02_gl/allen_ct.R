suppressMessages(library(DESeq2))
a <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/proc/matrix/rawcount.rds')
am <- read.csv('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/raw/sample_annotations.csv',as.is=T)
id <- which(am[,'class_label']!='Exclude')
a <- a[,id]
am <- am[id,]
p <- am[,'external_donor_name_label']
ct <- sub(' .*','',am[,'cell_type_alias_label'])
samp <- paste0(p,'_',ct)

bexpr <- sapply(unique(samp),function(i) rowSums(a[,samp==i]))
bexprct <- sub('.*_','',colnames(bexpr))
uct <- unique(ct)
cid <- expand.grid(1:length(uct),1:length(uct))
cid <- cid[cid[,1] < cid[,2],]

allres <- list()
for (i in 1:nrow(cid)) {
  ct1 <- uct[cid[i,1]]
  ct2 <- uct[cid[i,2]]
  expr <- bexpr[,c(which(bexprct==ct1),which(bexprct==ct2))]
  expr <- expr[rowSums(expr) > 0,]
  des <- c(rep(1,sum(bexprct==ct1)),rep(0,sum(bexprct==ct2)))
  dds <- DESeqDataSetFromMatrix(countData = expr,colData = data.frame(condition=factor(des)),design= ~ condition)
  dds <- DESeq(dds)
  res <- DESeq2::results(dds, name="condition_1_vs_0")
  res <- data.frame(res)
  pval <- res$pvalue
  pval[is.na(pval)] <- 1
  fdr <- p.adjust(pval,method='fdr')
  res$fdr <- fdr
  allres[[paste0(ct1,'_',ct2)]] <- res
}
saveRDS(allres,file='/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/gl/allen_ct.rds')  
