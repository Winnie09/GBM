type = c('Tumor', 'Lymph', 'M')
cnt <- readRDS(paste0('/home-4/whou10@jhu.edu/data2/whou10/GBM/singleObject/', type, '/count.rds'))
meta <- readRDS(paste0('/home-4/whou10@jhu.edu/data2/whou10/GBM/singleObject/', type, '/meta.rds'))
plotdir <- paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/qcplot/plot/', type)
dir.create(plotdir, showWarnings = FALSE, recursive = TRUE)
setwd(plotdir)

sp <- gsub('.*-', '', colnames(cnt))
length(unique(sp))
num.expressed.gene <- colSums(cnt>0)
prop.mito <- colSums(cnt[grepl('^MT-', rownames(cnt)), ])/colSums(cnt)
library(ggplot2)
library(RColorBrewer)

spdata <- data.frame(table(sp))
getPalette = colorRampPalette(brewer.pal(9, "Set1"))
p1 <- ggplot(spdata, aes(x = sp, y = Freq, fill = sp)) +
  geom_bar(stat = "identity") +
  xlab('Patient') + ylab('Number of Cells') +
  theme_classic() +
  theme(axis.title = element_text(size = 7), axis.text = element_text(size = 6)) +
  theme(legend.position = "none") +
  scale_fill_manual(values = getPalette(length(unique(sp)))) + 
  coord_flip() 
ggsave('Sample_Cells.pdf', p1, width = 7, height = 5)

nedata <- data.frame(num.expressed.gene = num.expressed.gene)

p2 <- ggplot(nedata, aes(x = num.expressed.gene)) +
  geom_histogram(col='black',fill='steelblue',alpha=.2,binwidth = (diff(range(num.expressed.gene)))/100) + 
  theme_classic() +
  xlab('Number of Expressed Genes') + 
  ylab('Number of Cells') +
  theme(axis.title = element_text(size = 7), axis.text = element_text(size = 6)) 
ggsave('num_expressed_genes.pdf', p2, width = 7, height = 4.3)

pmdata <- data.frame(prop.mito = prop.mito)
p3 <- ggplot(pmdata, aes(x = prop.mito)) +
  geom_histogram(col='black',fill='steelblue',alpha=.2,binwidth = (diff(range(prop.mito)))/20) + 
  theme_classic() +
  xlab('Proportion of Mitochondrial Counts') + 
  ylab('Number of Cells') +
  theme(axis.title = element_text(size = 7), axis.text = element_text(size = 6)) 
ggsave('prop_mito.pdf', p3, width = 7, height = 4.3)


