source('/home-4/whou10@jhu.edu/scratch/Wenpin/raisin/proc/read10x.R')
af <- list.files('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/raw/dge/tumor_nonGBM/',pattern = '^GBM')
read10x(paste0('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/raw/dge/tumor_nonGBM/',af),'/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor_nonGBM/',list.files('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/raw/dge/tumor_nonGBM/'),verbose = T)
