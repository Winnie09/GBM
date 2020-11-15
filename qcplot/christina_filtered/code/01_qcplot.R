library(here)
here()
for (type in c('Tumor', 'Lymph', 'Myeloid')){
  print(type)
  cnt <- readRDS(here('data','singleObject', type, 'count.rds'))
  meta <- readRDS(here('data', 'singleObject', type, 'meta.rds'))
  
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
    xlab('Sample') + ylab('Number of Cells') +
    theme_classic() +
    theme(axis.title = element_text(size = 7), axis.text = element_text(size = 6)) +
    theme(legend.position = "none") +
    scale_fill_manual(values = getPalette(length(unique(spdata[,1])))) + 
    coord_flip() 
  ggsave(here('qcplot','christina_filtered','plot', type,'num_cells_per_sample.pdf'), p1, width = 4.5, height = 0.1*length(unique(sp)))
  
  spdata <- data.frame(table(sp))
  spdata[,1] <- sub('_.*', '', spdata[,1])
  p1.2 <- ggplot(spdata, aes(x = sp, y = Freq, fill = sp)) +
    geom_bar(stat = "identity") +
    xlab('Patient') + ylab('Number of Cells') +
    theme_classic() +
    theme(axis.title = element_text(size = 7), axis.text = element_text(size = 6)) +
    theme(legend.position = "none") +
    scale_fill_manual(values = getPalette(length(unique(sp)))) + 
    coord_flip() 
  ggsave(here('qcplot','christina_filtered','plot', type,'num_cells_per_patient.pdf'), p1.2, width = 4.5, height = 0.1*length(unique(spdata[,1])))
  
  ##### Number of Expressed Genes (histogram, boxplots)
  nedata <- data.frame(num.expressed.gene = num.expressed.gene, sample = sp, patient = sub('_.*', '', sp))
  p2 <- ggplot(nedata, aes(x = num.expressed.gene)) +
    geom_histogram(col='black',fill='steelblue',alpha=.2,binwidth = (diff(range(num.expressed.gene)))/50) + 
    theme_classic() +
    xlab('Number of Expressed Genes') + 
    ylab('Number of Cells') +
    xlim(c(0, NA))
  ggsave(here('qcplot','christina_filtered', 'plot', type,'num_expressed_genes.pdf'), p2, width = 4.5, height = 3)
  
  p2.2 <- ggplot(nedata, aes(x = sample, y = num.expressed.gene, fill = sample, alpha = 0.3)) +
    geom_boxplot(outlier.size = 0.1) + 
    theme_classic() +
    ylab('Number of Expressed Genes') + 
    xlab('Sample') +
    ylim(c(0, NA)) +
    scale_fill_manual(values = getPalette(length(unique(nedata$sample)))) +
    theme(legend.position = 'none', axis.text.x = element_text(angle = 45,hjust = 1, size = 9, color = 'black'))
  ggsave(here('qcplot','christina_filtered', 'plot', type,'num_expressed_genes_boxplot_sample.pdf'), p2.2, width =  0.2*length(unique(nedata$sample)), height = 3)
  
  p2.3 <- ggplot(nedata, aes(x = patient, y = num.expressed.gene, fill = patient, alpha = 0.3)) +
    geom_boxplot(outlier.size = 0.1) + 
    theme_classic() +
    ylab('Number of Expressed Genes') + 
    xlab('Patient') +
    ylim(c(0, NA)) +
    scale_fill_manual(values = getPalette(length(unique(nedata$sample)))) +
    theme(legend.position = 'none', axis.text.x = element_text(angle = 45,hjust = 1, size = 9, color = 'black'))
  ggsave(here('qcplot','christina_filtered', 'plot', type,'num_expressed_genes_boxplot_patient.pdf'), p2.3, width = 0.2*length(unique(nedata$sample)), height = 3)
  
  ###### Proportion of Mitochondrial Counts (histogram, boxplots)
  pmdata <- data.frame(prop.mito = prop.mito, sample = sp, patient = sub('_.*', '', sp))
  p3 <- ggplot(pmdata, aes(x = prop.mito)) +
    geom_histogram(col='black',fill='steelblue',alpha=.2,binwidth = (diff(range(prop.mito)))/20) + 
    theme_classic() +
    xlab('Proportion of Mitochondrial Counts') + 
    ylab('Number of Cells')
  ggsave(here('qcplot','christina_filtered', 'plot',type, 'prop_mito.pdf'), p3, width = 4.5, height = 3)
  
  p3.2 <- ggplot(nedata, aes(x = sample, y = prop.mito, fill = sample, alpha = 0.3)) +
    geom_boxplot(outlier.size = 0.1) + 
    theme_classic() +
    ylab('Proportion of Mitochondrial Counts') + 
    xlab('Sample') +
    ylim(c(0, NA)) +
    scale_fill_manual(values = getPalette(length(unique(pmdata$sample)))) +
    theme(legend.position = 'none', axis.text.x = element_text(angle = 45,hjust = 1, size = 9, color = 'black'))
  ggsave(here('qcplot','christina_filtered', 'plot', type,'prop_mito_boxplot_sample.pdf'), p3.2, width =  0.2*length(unique(pmdata$sample)), height = 3.2)
  
  p3.3 <- ggplot(nedata, aes(x = patient, y = prop.mito, fill = patient, alpha = 0.3)) +
    geom_boxplot(outlier.size = 0.1) + 
    theme_classic() +
    ylab('Proportion of Mitochondrial Counts') + 
    xlab('Patient') +
    ylim(c(0, NA)) +
    scale_fill_manual(values = getPalette(length(unique(pmdata$patient)))) +
    theme(legend.position = 'none', axis.text.x = element_text(angle = 45,hjust = 1, size = 9, color = 'black'))
  ggsave(here('qcplot','christina_filtered', 'plot', type,'prop_mito_boxplot_patient.pdf'), p3.3, width = 0.2*length(unique(pmdata$patient)), height = 3.2)
  
}


