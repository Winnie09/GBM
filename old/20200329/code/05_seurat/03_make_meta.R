setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/')
library(Seurat)
d.integrated <- readRDS('./seurat/integrated.rds') ### 2000 246842
cn <- d.integrated@assays$RNA@counts@Dimnames[[2]]
am <- read.csv('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/raw/sample_annotations.csv',as.is=T)
sample <- donor <- cell <- rep(NA,length(cn))
sample[grep('GBM',cn)] <- sub('_.*','',cn[grep('GBM',cn)])
sample[is.na(sample)] <- 'allen'
donor[!grepl('GBM',cn)] <- am[match(cn[!grepl('GBM',cn)],am[,1]),'external_donor_name_label']
donor[is.na(donor)] <- 'GBM'
cell[!grepl('GBM',cn)] <- sub(' .*','',am[match(cn[!grepl('GBM',cn)],am[,1]),'cell_type_alias_label'])
cell[is.na(cell)] <- 'GBM'
dataset = ifelse(grepl('GBM',cn),'GBM','allen')

batchf = read.csv('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/doc/GBM_scRNA_Sample_submission_Datasheet_Jason.csv',as.is=T)
batchf <- batchf[grep('Tumor',batchf[,3]),]

batchdata <- batchf[match(sample,batchf[,2]),c('Fresh.Frozen','Sort.processing.batch','Sequencing.batch')]
meta <- data.frame(sample,donor,cell,dataset,batchdata)
rownames(meta) = cn
## add region
setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/doc/')
a=read.csv('./sample_annotations.csv', as.is=T)
ct=sapply(a[,'cell_type_alias_label'],function(i) strsplit(i,' ')[[1]][2],USE.NAMES=F)
names(ct) = a$sample_name
region = c(rep('GBM', sum(grepl('GBM',rownames(meta)))), ct[rownames(meta)[rownames(meta)%in%names(ct)]])
meta = cbind(meta, region=region)
saveRDS(meta,'/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/res/seurat/meta.rds')

