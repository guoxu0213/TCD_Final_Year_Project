getwd()
dftup1<-read.csv("tup1_vs_wt")
dfcyc8<-read.csv("cyc8_vs_wt")
dftup1_cyc8<-read.csv("tup1_cyc8_vs_wt")


x<-list(A=dftup1$A,
        B=dfcyc8$B,
        C=dftup1_cyc8$C,)
fill.col<-c("#0055AA","#C40003","#00C19B")

library(VennDiagram)

venn.diagram(x=x,
             filename = "vennplot.tiff",
             fill=fill.col)