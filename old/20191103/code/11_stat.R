setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/')
af = list.files(getwd())

m = readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/matrix/rawcount.rds') #[1:31078, 1:205442]
p = sub('_.*','',colnames(m))
num.cell.bef.fil = table(p)

m2= readRDS('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/data/proc/tumor/matrix/count.rds') #[1:20429, 1:107305]
p = sub('_.*','',colnames(m2))
num.cell.af.fil = table(p)
ap = names(num.cell.af.fil)
res <- data.frame(sample=ap,num.cell.before.filter = as.vector(num.cell.bef.fil[ap]), num.cell.after.filter = as.vector(num.cell.af.fil))
write.csv(res,'/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/stat/num.cell.bef.af.filter.csv')

