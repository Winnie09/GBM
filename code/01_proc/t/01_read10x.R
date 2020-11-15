source('/home-4/whou10@jhu.edu/scratch/Wenpin/raisin/proc/read10x.R')
af <- list.files('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/raw/dge/t/',pattern = '^GBM')
read10x(list.files('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/raw/dge/t',full.names = T),'/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/t',list.files('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/raw/dge/t/'),verbose = T)
