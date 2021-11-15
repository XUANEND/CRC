library(maftools)
library(xlsx)
library(tidyverse)

#coad_maf = "D:\\Documents\\data\\TCGA\\COAD+READ\\mutation\\COAD\\TCGA.COAD.muse.70cb1255-ec99-4c08-b482-415f8375be3f.DR-10.0.somatic.maf.gz"
#coad_maf = "D:\\Documents\\data\\TCGA\\COAD+READ\\mutation\\COAD\\TCGA.COAD.mutect.03652df4-6090-4f5a-a2ff-ee28a37f9301.DR-10.0.somatic.maf.gz"
#coad_maf = "D:\\Documents\\data\\TCGA\\COAD+READ\\mutation\\COAD\\TCGA.COAD.somaticsniper.70835251-ddd5-4c0d-968e-1791bf6379f6.DR-10.0.somatic.maf.gz"
coad_maf = "D:\\Documents\\data\\TCGA\\COAD+READ\\mutation\\COAD\\TCGA.COAD.varscan.8177ce4f-02d8-4d75-a0d6-1c5450ee08b0.DR-10.0.somatic.maf.gz"

coad_clin = "D:\\Documents\\data\\TCGA\\COAD+READ\\clinical\\COAD\\clinical.tsv"

pryo.genes = "D:\\Documents\\R\\data\\CRC\\koni_a_1987636_sm8674\\Supplementary_Tables.xlsx"

data = read.table(coad_maf, sep = "\t", quote = "",header = TRUE)

clin = read.table(coad_clin, sep = "\t", quote = "", na.strings = "'--", header = TRUE)
clin[,"Tumor_Sample_Barcode"] = NA
clin = clin[,c("case_submitter_id","Tumor_Sample_Barcode","vital_status","days_to_last_follow_up")]

genes = read.xlsx(pryo.genes,sheetName = "S2")
genes = na.omit(genes)
colnames(genes) = genes[1,]
genes = genes[-1,]
genes = genes[,"Gene"]

tumor.barcode = as.data.frame(strsplit(data[,"Tumor_Sample_Barcode"],"-"))
tumor.barcode = t(tumor.barcode)
tumor.barcode = as.data.frame(tumor.barcode)
tumor.barcode[,8] = paste(tumor.barcode[,1],tumor.barcode[,2],tumor.barcode[,3],sep = "-")
tumor.barcode = tumor.barcode[,8]
tumor.barcode = as.data.frame(tumor.barcode)
colnames(tumor.barcode) = "case_submitter_id"
tumor.barcode[,"Tumor_Sample_Barcode"] = data[,"Tumor_Sample_Barcode"]

barcode = levels(factor(tumor.barcode[,1]))
barcode = as.data.frame(barcode)
colnames(barcode) = "case_submitter_id"
barcode[,"Tumor_Sample_Barcode"] = levels(factor(tumor.barcode[,2]))


#maf = data[grepl(paste("^",genes[1],"$",sep=""),data[,"Hugo_Symbol"]),]

#for (num in 2:length(genes)){
#  if (genes[num] %in% data[,"Hugo_Symbol"]){
#    maf = rbind(maf,data[grepl(paste("^",genes[num],"$",sep=""),data[,"Hugo_Symbol"]),])
#  }
#}

#for (case in 1:nrow(barcode)) {
#  if(barcode[case,"case_submitter_id"] %in% clin[,"case_submitter_id"]){
#    clin[grepl(barcode[case,"case_submitter_id"],clin[,"case_submitter_id"]),][,"Tumor_Sample_Barcode"] = barcode[case,"Tumor_Sample_Barcode"]
#  }
#}

# maf文件需要哪些突变信息即可读取、作图
maf = data[,c("Hugo_Symbol","Chromosome","Start_Position","End_Position","Variant_Classification","Reference_Allele","Tumor_Seq_Allele2","Variant_Type","Tumor_Sample_Barcode")]

coad = read.maf(maf = maf,
                clinicalData = clin,
                verbose = FALSE)

oncoplot(maf = coad,
         genes = genes,
         draw_titv = TRUE)
