source('/home-4/whou10@jhu.edu/scratch/Wenpin/raisin/proc/read10x.R')
af <- list.files('/home-4/whou10@jhu.edu/work-zfs/whou10/data/GBM/data/dge/Tumor/',pattern = '^GBM')
read10x(list.files('/home-4/whou10@jhu.edu/work-zfs/whou10/data/GBM/raw/dge/Tumor',full.names = T),'/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor',list.files('/home-4/whou10@jhu.edu/work-zfs/whou10/data/GBM/raw/dge/Tumor/'),verbose = T)
