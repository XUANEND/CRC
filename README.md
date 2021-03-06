# Identification of pyroptosis-related subtypes, the development of a prognosis model, and characterization of tumor microenvironment infiltration in colorectal cancer

doi: 10.1080/2162402X.2021.1987636

---

R包：

```
GEOquery
ConsensusClusterPlus
survival
survminer
limma
clusterFilter
ggplot2
maftools
pRRophetic
rms
```

本文里面共收集了1109例CRC样本，其中GSE17536有145例，GSE38832有92例，GSE39582有557例，TCGA有315例。而原始数据中，GSE17536有177例病人，GSE38832有122例病人，GSE39582有585例病人，TCGA有633例病人。作者删去了各数据集里的部分数据。所以，我们就需要搞清楚作者采取了什么样的纳入排除标准。作者排除了没有RFS（DFS）信息的病人。那么就需要明白如何获得病人的RFS信息。接下来就是要收集各个数据集的临床信息。

首先来看如何从GEO数据库中获取病人的临床信息：

以GSE17536为例，这个数据集中包含了177例病人，其中只有145人有RFS信息。这些信息可以从哪里获取？

```R
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

data1 = getGEO('GSE17536', destdir="D:\\Documents\\R\\data\\CRC\\GSE17536_RAW\\",
               AnnotGPL = FALSE,
               getGPL = FALSE)
data2 = getGEO('GSE38832', destdir="D:\\Documents\\R\\data\\CRC\\GSE38832_RAW\\",
               AnnotGPL = FALSE,
               getGPL = FALSE)
data2 = getGEO('GSE39582', destdir="D:\\Documents\\R\\data\\CRC\\GSE17536_RAW\\",
               AnnotGPL = FALSE,
               getGPL = FALSE)


data1 = getGEO(filename = 'D:\\Documents\\R\\data\\CRC\\GSE17536_RAW\\family\\GSE17536_series_matrix.txt.gz', 
               #destdir="D:\\Documents\\R\\data\\CRC\\GSE17536_RAW\\",
               AnnotGPL = FALSE,
               getGPL = FALSE)

s = pData(data1)
head(exprs(data1))

colnames(s)
dfs = s$`dfs_event (disease free survival; cancer recurrence):ch1`
dfs = data.frame(dfs)
nrow(s[!grepl("NA",dfs[,"dfs"]),])
```



## Figure 1：

**原图**

<img src="img/koni_a_1987636_f0001_oc.jpeg" alt="Figure 1" style="zoom:67%;" />

Figure 1的a，b两个图都是直接使用TCGA的原始数据简单预处理后即可进行分析，不用对样本进行挑选。

### 1a:

[代码](code/maftool_COAD_oncoplot.R)

<img src="result/img/Figure_1a.png" alt="Figure 1a" style="zoom: 50%;" align = "left" />

### 1b:

[代码](code/maftool_READ_oncoplot.R)

<img src="result/img/Figure_1b.png" alt="Figure 1b" style="zoom:50%;" align="left"/>

## Figure 2：

**原图**

<img src="img/koni_a_1987636_f0002_oc.jpeg" alt="Figure 2" style="zoom:67%;" />

## Figure 3：

**原图**

<img src="img/koni_a_1987636_f0003_oc.jpeg" alt="Figure 3" style="zoom:67%;" />

## Figure 4：

**原图**

<img src="img/koni_a_1987636_f0004_oc.jpeg" alt="Figure 4" style="zoom:67%;" />

## Figure 5：

**原图**

<img src="img/koni_a_1987636_f0005_oc.jpeg" alt="Figure 5" style="zoom:67%;" />

## Figure 6：

**原图**

<img src="img/koni_a_1987636_f0006_oc.jpeg" alt="Figure 6" style="zoom:67%;" />

## Figure 7：

**原图**

<img src="img/koni_a_1987636_f0007_oc.jpeg" alt="Figure 7" style="zoom:67%;" />

## Figure 8：

**原图**

<img src="img/koni_a_1987636_f0008_oc.jpeg" alt="Figure 8" style="zoom:67%;" />
