library(GEOquery)

GSEs = c("GSE17536","GSE38832","GSE39582")

for (GSE in GSEs) {
  assign(paste("data",GSE,sep = "_"),
         getGEO(GSE, 
                destdir=paste("D:\\Documents\\R\\data\\CRC\\",GSE,"_RAW\\",sep = ""),
                AnnotGPL = FALSE,
                getGPL = FALSE)
         )
}

get()

data1 = getGEO('GSE17536', destdir="D:\\Documents\\R\\data\\CRC\\GSE17536_RAW\\",
               AnnotGPL = FALSE,
               getGPL = FALSE)
data2 = getGEO('GSE38832', destdir="D:\\Documents\\R\\data\\CRC\\GSE38832_RAW\\",
               AnnotGPL = FALSE,
               getGPL = FALSE)
data2 = getGEO('GSE39582', destdir="D:\\Documents\\R\\data\\CRC\\GSE17536_RAW\\",
               AnnotGPL = FALSE,
               getGPL = FALSE)


data1 = getGEO(
  filename = 'D:\\Documents\\R\\data\\CRC\\GSE17536_RAW\\family\\GSE17536_series_matrix.txt.gz',
  AnnotGPL = FALSE,
  getGPL = FALSE)

s = pData(data1)
head(exprs(data1))

colnames(s)
dfs = s$`dfs_event (disease free survival; cancer recurrence):ch1`
dfs = data.frame(dfs)
nrow(s[!grepl("NA",dfs[,"dfs"]),])

fpkmToTpm <- function(fpkm)
{
  exp(log(fpkm) - log(sum(fpkm)) + log(1e6))
}


a = apply(exprs(data1), 2, sum)
View(a)

TPM = apply(exprs(data1),2,fpkmToTpm)

TPM[1:3,]

View(colSums(TPM[1:3,]))

View(exprs(data1[1:3,1:4]))
