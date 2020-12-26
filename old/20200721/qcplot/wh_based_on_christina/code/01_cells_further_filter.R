library(Matrix)
library(parallel)
library(ggplot2)
reslist = list()
for (act in c('Lymph', 'M', 'Tumor')) {
  af <- list.files(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/raw/dge/',act))
  res <- mclapply(af,function(f) {
    print(f)
    if (length(list.files(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/raw/dge/',act,'/',f)))==1) {
      mf <- list.files(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/raw/dge/',act,'/',f,'/filtered_feature_bc_matrix/'),pattern = 'matrix',full.names = T)[1]
      df <- list.files(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/raw/dge/',act,'/',f,'/filtered_feature_bc_matrix/'),pattern = 'feature',full.names = T)[1]
      if (is.na(df)) {
        df <- list.files(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/raw/dge/',act,'/',f,'/filtered_feature_bc_matrix/'),pattern = 'gene',full.names = T)[1]
      }
      m <- readMM(mf)
      d <- read.table(df,as.is=T,sep='\t')
    } else {
      mf <- list.files(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/raw/dge/',act,'/',f,'/'),pattern = 'matrix',full.names = T)[1]
      df <- list.files(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/raw/dge/',act,'/',f,'/'),pattern = 'feature',full.names = T)[1]
      if (is.na(df)) {
        df <- list.files(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/raw/dge/',act,'/',f,'/'),pattern = 'gene',full.names = T)[1]
      }
      m <- readMM(mf)
      d <- read.table(df,as.is=T,sep='\t')
    }
    
    rc <- colSums(m)
    data.frame(sample=f,rc=rc,gn=colSums(m > 0),prop=colSums(m[grep('MT-',d[,2]),])/rc,stringsAsFactors = F)
  },mc.cores=20)
  
  res <- do.call(rbind,res)
  
  summary <- do.call(rbind,sapply(c(200,250,500,1000),function(rccut) {
    do.call(rbind,sapply(c(200,250,500),function(gncut) {
      tmp <- tapply(res[res[,'rc']>=rccut,'gn'] < gncut,list(res$sample[res[,'rc']>=rccut]),mean)
      data.frame(rccut=rccut,gncut=gncut,remove=tmp,stringsAsFactors = F)
    },simplify = F))
  },simplify = F))
  summary$x <- 1
  summary$rccut <- paste0('rccut_',summary$rccut)
  summary$gncut <- paste0('gncut_',summary$gncut)
  pdf(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/qcplot/wh_based_on_christina/plot/',act,'_cells_further_filter.pdf'), width = 5, height = 7)
  ggplot(summary,aes(x=x,y=remove)) + geom_violin() + geom_point() + facet_grid(rccut~gncut,scale='free') + theme_classic()
  dev.off()
}

