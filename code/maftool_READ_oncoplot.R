rm(list = ls())

library(maftools)
library(xlsx)
library(tidyverse)

read_maf = "D:\\Documents\\data\\TCGA\\COAD+READ\\mutation\\READ\\TCGA.READ.varscan.b2689e8f-3b64-4214-8a87-dc7e7cf6fe5e.DR-10.0.somatic.maf.gz"

read_clin = "D:\\Documents\\data\\TCGA\\COAD+READ\\clinical\\READ\\clinical.tsv"

pryo.genes = "D:\\Documents\\R\\data\\CRC\\koni_a_1987636_sm8674\\Supplementary_Tables.xlsx"

data = read.table(read_maf, sep = "\t", quote = "", header = TRUE)

clin = read.table(read_clin, sep = "\t", quote = "", header = TRUE, na.strings = "'--")
clin[,"Tumor_Sample_Barcode"] = NA
clin = clin[,c("case_submitter_id","Tumor_Sample_Barcode","vital_status","days_to_last_follow_up")]

genes = read.xlsx(pryo.genes,sheetName = "S2")
genes = na.omit(genes)
genes = genes[-1,]
genes = genes[,1]


Barcode = strsplit(data[,"Tumor_Sample_Barcode"],"-")
Barcode = data.frame(Barcode)
Barcode = t(Barcode)
Barcode = data.frame(Barcode)
Barcode[,8] = paste(Barcode[,1],Barcode[,2],Barcode[,3],sep="-")

Barcode = Barcode[,8]
#colnames(Barcode) = "case_submitter_id"

Barcode = cbind(Barcode,data.frame(data[,"Tumor_Sample_Barcode"]))

Tumor.barcode = data.frame(levels(factor(Barcode[,1])))
Tumor.barcode = cbind(Tumor.barcode,data.frame(levels(factor(Barcode[,2]))))

for (case.num in 1:nrow(Tumor.barcode)){
  if (Tumor.barcode[case.num,1] %in% clin[,"case_submitter_id"]){
    clin[grepl(Tumor.barcode[case.num,1],clin[,"case_submitter_id"]),][,"Tumor_Sample_Barcode"] = Tumor.barcode[case.num,2]
  }
}
maf = data[,c("Hugo_Symbol","Chromosome","Start_Position","End_Position","Variant_Classification","Reference_Allele","Tumor_Seq_Allele2","Variant_Type","Tumor_Sample_Barcode")]

Read = read.maf(maf = maf,
                clinicalData = clin,
                verbose = FALSE)

p = oncoplot(maf = Read,
         genes = genes,
         draw_titv = TRUE)

png(filename = "result/img/Figure_1b.png", width = 981, height = 812)
oncoplot(maf = Read,
         genes = genes,
         draw_titv = TRUE)
dev.off()
