library(tidyverse)
library(hgu133plus2.db)
library(org.Hs.eg.db)
library(xlsx)
library(clusterProfiler)

path = "D:\\Documents\\data\\TCGA\\COAD+READ\\CNV\\COAD_CNV_Gene_Level_Copy_Number_Scores\\COAD.focal_score_by_genes.txt"
pryo.genes = "D:\\Documents\\R\\data\\CRC\\koni_a_1987636_sm8674\\Supplementary_Tables.xlsx"

data = read.table(path,sep = "\t",quote = "",header = TRUE)
rm(path)

genes = read.xlsx(pryo.genes, sheetName = "S2")
genes = na.omit(genes)
colnames(genes) = genes[1,]
genes = genes[-1,]
genes = genes[,1]
genes = as.data.frame(genes)
genes[,"ENSEMBL"] = NA

ref = select(org.Hs.eg.db,keys = keys(org.Hs.eg.db), columns = c("ENSEMBL","SYMBOL"))

gene = data$Gene.Symbol
#rbind(gene,strsplit(gene,"\\.")) 

gene = strsplit(data$Gene.Symbol,"\\.")
gene = as.data.frame(gene)
gene = t(gene)
gene = as.data.frame(gene)
data[,"ENSEMBL"] = gene$V1
data[,"SYMBOL"] = NA
Gene_id = bitr(data$ENSEMBL,fromType = "ENSEMBL", toType = "SYMBOL", OrgDb = "org.Hs.eg.db", drop = TRUE)
data = merge(data,Gene_id,by = "ENSEMBL",all = F)

for (num in 1:nrow(data)){
  if (data[num,"ENSEMBL"] %in% ref[,"ENSEMBL"]){
    if (length(ref[grepl(data[num,"ENSEMBL"],ref[,"ENSEMBL"]),"SYMBOL"])>1){
      data[num,"SYMBOL"]=paste(ref[grepl(data[num,"ENSEMBL"],ref[,"ENSEMBL"]),"SYMBOL"],collapse=",")
    }
    else{
      data[num,"SYMBOL"] = ref[grepl(data[num,"ENSEMBL"],ref[,"ENSEMBL"]),"SYMBOL"]
    }
  }
}
  
View(data[grepl(data[1,"ENSEMBL"],gene$V1),])
