# 包安装
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("affy")
BiocManager::install("hgu133plus2cdf")

library(affy)

data_dir = "D:\\Documents\\R\\data\\CRC\\"

CEL_dir1 = paste0(data_dir,"GSE17536_RAW",sep = "")
CEL_dir2 = paste0(data_dir,"GSE38832_RAW",sep = "")

CEL_file1 = list.celfiles(CEL_dir1)

Data1 = ReadAffy(celfile.path = CEL_dir1)
Data2 = ReadAffy(celfile.path = CEL_dir2)
Data3 = ReadAffy(celfile.path = )

eset1 = mas5(Data1)
eset = rma(Data2)


CEL_file = list.files("D:\\Documents\\R\\data\\CRC\\GSE17536_RAW")
d1 = ReadAffy(fielnames = "D:\\Documents\\R\\data\\CRC\\GSE38832_RAW\\GSM950411_197RDB0002.CEL.gz")
f = paste0("D:\\Documents\\R\\data\\CRC\\GSE17536_RAW\\",CEL_file[1:10],sep = "")
d2 = read.affybatch(fielnames = f)
eset1 = rma(d1)

expr1 = exprs(eset)
expr2 = exprs(eset1)
expr1[,colnames(expr1)[1]]
View(expr1[,grepl("GSM950411",colnames(expr1))])

grepl("GSM437093",colnames(expr1))
length(colnames(expr1))
colnames(expr1)
