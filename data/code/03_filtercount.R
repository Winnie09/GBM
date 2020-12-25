source('/home-4/whou10@jhu.edu/scratch/Wenpin/raisin/proc/filtercount.R')
filtercount('/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/proc/tumor/all',mingn=500,maxgn=10000,minrc=NULL,maxrc=NULL,maxmito=0.2, mingeneprop = 0)

filtercount('/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/proc/myeloid',mingn=500,maxgn=10000,minrc=NULL,maxrc=NULL,maxmito=0.2, mingeneprop = 0)

filtercount('/home-4/whou10@jhu.edu/work-zfs/whou10/GBM/data/proc/lymph',mingn=500,maxgn=10000,minrc=NULL,maxrc=NULL,maxmito=0.2, mingeneprop = 0)
