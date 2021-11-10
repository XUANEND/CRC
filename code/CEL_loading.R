# 包安装
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("affy")
BiocManager::install("hgu133plus2cdf")

library(affy)

data_dir = ""

CEL_dir1 = "data/GSE17536_RAW/"
CEL_dir2 = "data/GSE38832_RAW/"

CEL_file1 = list.celfiles(CEL_dir1)

Data1 = ReadAffy(celfile.path = CEL_dir1)
Data2 = ReadAffy(celfile.path = CEL_dir2)
Data3 = ReadAffy(celfile.path = )

eset1 = mas5(Data1)
