getwd()
setwd(" ")
df<-read.csv("wt_vs_cyc8.csv",header=T,
         stringsAsFactors = F)
head(df)
dim(df)
df$group<-ifelse(df$log2FoldChange>=1&df$padj<=0.01,"Upregulated",
                  ifelse(df$log2FoldChange<=-1&df$padj<=0.01,
                         "Downregulated","Not significant"))
table(df$group)
library(ggplot2)
#install.packages("ggrepel")
library(ggrepel)

ggplot(df, aes(x=log2FoldChange, y=-log10(padj))) +
  theme(axis.title.x = element_text(size = 14, family = "Arial"),  
        axis.title.y = element_text(size = 14, family = "Arial"),
        legend.text = element_text(family = "Arial"))+
  geom_point(aes(color=group))+
  scale_color_manual(values=c("dodgerblue","gray","firebrick"))

### annotation
df$padj_log10<-(-log10(df$padj))
df1<-df[df$padj_log10>=10,]
dim(df1)
ggplot(df,aes(x=log2FoldChange,y=-log10(padj)))+
  geom_point(aes(color=group))+
  scale_color_manual(values=c("dodgerblue","gray","firebrick"))+
  geom_label_repel(data=df1,aes(x=log2FoldChange,y=-log10(padj),
                          label=ID))+
  theme_bw()+
  labs(y="-log10(pvalue)",x="log(Fold Change)")

