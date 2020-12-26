reslist <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/qcplot/pd/all_stat.rds')
## untreated and NA samples
  treat <- read.csv(paste0('/home-4/whou10@jhu.edu/data2/whou10/GBM/singleObject/', act, '/treatment_info.csv'), as.is = TRUE)
  selectsp <- treat[!grepl('immunotherapy', treat[,2]), 1]
  selectsp <- selectsp[grepl('GBM', selectsp)]
  untreatedsp <- treat[grepl('Untreated', treat[,2]), 1]
  untreatedsp <- untreatedsp[grepl('GBM', untreatedsp)]

stat <- lapply(1:length(reslist), function(i){
  res = reslist[[i]]
  v <- c(length(unique(res[,1])), nrow(res), mean(res[,2]), mean(res[,3]), mean(res[,4]))
  res <- res[res[,1] %in% selectsp, ]
  u <- c(length(unique(res[,1])), nrow(res), mean(res[,2]), mean(res[,3]), mean(res[,4]))
  res <- res[res[,1] %in% untreatedsp, ]
  w <- c(length(unique(res[,1])), nrow(res), mean(res[,2]), mean(res[,3]), mean(res[,4]))
  m <- rbind(v, u, w)
  rownames(m) <- paste0(names(reslist)[i], '_', c('all_samples', 'untreated_and_NA', 'untreated_only'))
  colnames(m) <- c('num.samples', 'num.cell', 'ave.num.read.count', 'ave.num.gene.expressed', 'ave.mito.prop')
  m
})
  
stat = do.call(rbind, stat)
write.csv(stat, '/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/qcplot/pd/all_stat_summary.csv', row.names = TRUE)
  
