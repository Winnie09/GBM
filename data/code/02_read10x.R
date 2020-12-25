source('/home-4/whou10@jhu.edu/scratch/Wenpin/raisin/proc/read10x.R')
read10x(list.files('/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/raw/dge/Tumor/',full.names = T),'/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/proc/tumor/all',list.files('/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/raw/dge/Tumor/'),verbose = T)

source('/home-4/whou10@jhu.edu/scratch/Wenpin/raisin/proc/read10x.R')
read10x(list.files('/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/raw/dge/myeloid/',full.names = T),'/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/proc/myeloid',list.files('/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/raw/dge/myeloid'),verbose = T)

source('/home-4/whou10@jhu.edu/scratch/Wenpin/raisin/proc/read10x.R')
read10x(list.files('/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/raw/dge/lymph/',full.names = T),'/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/proc/lymph',list.files('/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/raw/dge/lymph'),verbose = T)
