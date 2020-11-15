setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/scenicSample')
mat <- readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/allenBrain/data/proc/matrix/scran.rds')
set.seed(12345)
mat = mat[,sample(1:ncol(mat),round(0.1*ncol(mat)))]
dir.create('./data/sample0.1/', showWarnings = F, recursive = T)
saveRDS(mat,'./data/sample0.1/mat.rds')
