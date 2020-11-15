setwd('/home-4/whou10@jhu.edu/scratch/Wenpin/GBM/scenicSample')
library(SCENIC)
scenicOptions <- initializeScenic(org="hgnc", dbDir="./data/cistarget/db/human", nCores=10,datasetTitle="allen")
# scenicOptions@inputDatasetInfo$cellInfo <- "int/cellInfo.Rds"
dir.create('./data/int/',showWarnings = F, recursive = T)
saveRDS(scenicOptions, file="./data/int/scenicOptions.Rds") 


