require(Seurat)
require(dplyr)
require(future)
plan(multiprocess)
options(future.globals.maxSize = Inf)
setwd('~/work/christina_gbm')

subset_de = function(ser, idents){
    ss = subset(ser, idents = idents)
    marks = FindAllMarkers(ss)
    dir = paste(idents, collapse = '-')
    dir = paste0('2_de/', dir)
    dir.create(dir)
    top10 = marks %>% group_by(cluster) %>% top_n(10, avg_logFC)
    pdf(paste0(dir, '/plots.pdf'))
    print(DoHeatmap(ss, features = top10$gene))
    print(DoHeatmap(subset(ss, downsample = 100), features = top10$gene))
    for(id in idents){
        genes = top10$gene[which(top10$cluster == id)]
        print(VlnPlot(ss, genes, pt.size = 0, ncol = 3, assay = 'RNA'))
        write.table(marks[which(marks$cluster == id),], 
            paste0(dir, '/', id, '.csv'), col.names = NA, sep = ',')
    }
    dev.off()
}

ser = readRDS('T_ser.RDS')
subset_de(ser, c(9, 14, 19))
subset_de(ser, c(2, 17, 20))

