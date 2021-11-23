# 包安装
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("affy")
BiocManager::install("hgu133plus2cdf")

library(affy)

data_dir = "D:\\Documents\\R\\data\\CRC\\"

CEL_dir = paste0(data_dir,"GSE17536_RAW\\CEL",sep = "")

Data = ReadAffy(celfile.path = CEL_dir)

eset = rma(Data)
expr = exprs(eset1)
expr = as.data.frame(expr)