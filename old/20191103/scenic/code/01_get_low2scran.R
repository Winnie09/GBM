setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/scenic')
mat <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/proc/matrix/scran.rds')
expr = log2(mat+1)
dir.create('./data/log2scran/', showWarnings = F, recursive = T)
saveRDS(expr,'./data/log2scran/mat.rds')

