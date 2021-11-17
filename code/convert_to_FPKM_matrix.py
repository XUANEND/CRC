import numpy as np
import pandas as pd
import time
#import os
#import re

path = "D:\\Documents\\data\\TCGA\\COAD+READ\\"

samples = pd.read_csv(path+"gdc_sample_sheet.2021-11-12.tsv",sep = "\t")

samples = samples[["File ID","File Name","Case ID","Sample ID","Sample Type"]]
Files = samples["File ID"]+"\\"+samples["File Name"]
Cases = samples["Case ID"]

t0 =time.time()
FPKM = pd.DataFrame()
for num in range(len(Files)):
    if FPKM.empty:
        FPKM = pd.read_csv(path+Files[num], sep = "\t", header = None, names = ["gene",Cases[num]])
    else:
        new_FPKM = pd.read_csv(path+Files[num], sep = "\t", header = None, names = ["gene",Cases[num]])
        FPKM = pd.merge(FPKM, new_FPKM, on = "gene", how = "outer")
print(time.time()-t0)

FPKM.to_csv(path+"FPKM.txt",sep = "\t", index = 0)