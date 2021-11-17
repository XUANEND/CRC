# Identification of pyroptosis-related subtypes, the development of a prognosis model, and characterization of tumor microenvironment infiltration in colorectal cancer

doi: 10.1080/2162402X.2021.1987636

---

R包：

```
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

文章里面共收集了1109例CRC样本，其中GSE39582有557例，GSE17536有145例，GSE38832有92例，TCGA有315例。而原始数据中，GSE17536有177例病人，GSE38832有122例病人，GSE39582有585例病人，TCGA有633例病人。很明显，作者删去了数据库里的部分数据。所以，我们就需要搞清楚作者采取了什么样的纳入排除标准。作者排除了没有RFS（DFS，信息的病人。



## Figure 1:

Figure 1的a，b两个图都是直接使用TCGA的原始数据预处理后分析即可，不用对样本进行挑选。

1a:

[代码](code/maftool_COAD_oncoplot.R)

![Figure 1a](result/img/Figure_1a.png)

1b:

![Figure 1b](result/img/Figure_1b.png)

## Figure 2：



## Figure 3：



## Figure 4：



## Figure 5：



## Figure 6：



## Figure 7：



## Figure 8：
