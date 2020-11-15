library(Matrix)
library(parallel)
library(ggplot2)
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
  res[,1] <- sub('_.*','',sub('-.*','',res[,1]))
  
  # treat <- read.csv(paste0('/home-4/whou10@jhu.edu/data2/whou10/GBM/singleObject/', act, '/treatment_info.csv'), as.is = TRUE)
  # selectsp <- treat[treat[,2] == 'Untreated', 1]
  # selectsp <- selectsp[grepl('GBM', selectsp)]
  # res <- res[res[,1] %in% selectsp, ]
  
  tab <- table(res[,1])
  
  library(RColorBrewer)
  getPalette = colorRampPalette(brewer.pal(9, "Set1"))
  pdf(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/qcplot/plot/',act,'_cellnum.pdf'), width = 5, height = 5.5)
  print(ggplot(data.frame(sample=names(tab),Freq=as.vector(tab)), aes(x = sample, y = Freq, fill = sample)) + geom_bar(stat = "identity") + xlab('Patient') + ylab('Number of Cells') + theme_classic() + theme(axis.title = element_text(size = 8), axis.text = element_text(size = 8)) + theme(legend.position = "none") + scale_fill_manual(values = getPalette(length(tab))) + coord_flip())
  dev.off()
  #ggsave('Sample_Cells.pdf', p1, width = 7, height = 5)
  
  pdf(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/qcplot/plot/',act,'_numreads.pdf'), width = 7, height = 4.3)
  print(ggplot(data.frame(num.expressed.gene = res[,2]), aes(x = num.expressed.gene)) +
    geom_histogram(col='black',fill='steelblue',alpha=.2,binwidth = (diff(range(res[,2])))/100) + 
    theme_classic() +
    xlab('Number of Reads') + 
    ylab('Number of Cells') +
      theme(axis.title = element_text(size = 12), axis.text = element_text(size = 12)))
  dev.off()
  
  
  pdf(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/qcplot/plot/',act,'_numexpressedgenes.pdf'), width = 7, height = 4.3)
  print(ggplot(data.frame(num.expressed.gene = res[,3]), aes(x = num.expressed.gene)) +
    geom_histogram(col='black',fill='steelblue',alpha=.2,binwidth = (diff(range(res[,3])))/100) + 
    theme_classic() +
    xlab('Number of Expressed Genes') + 
    ylab('Number of Cells') +
    theme(axis.title = element_text(size = 12), axis.text = element_text(size = 12)))
  dev.off()
  
  pdf(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/qcplot/plot/',act,'_propmito.pdf'), width = 7, height = 4.3)
  print(ggplot(data.frame(prop.mito = res[,4]), aes(x = prop.mito)) +
    geom_histogram(col='black',fill='steelblue',alpha=.2,binwidth = (diff(range(res[,4])))/20) + 
    theme_classic() +
    xlab('Proportion of Mitochondrial Counts') + 
    ylab('Number of Cells') +
      theme(axis.title = element_text(size = 12), axis.text = element_text(size = 12)))
  dev.off()
  
}


