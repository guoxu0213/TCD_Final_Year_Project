library(pheatmap)
getwd()
setwd("/Users/shawnrain/Desktop/Final_year_project/Sequence of retrotransposon")
df<-read.csv("sequence_similarity.csv",
              row.names = 1)


head(df)


pheatmap(df)
pheatmap(df1,annotation_col = df2)
pheatmap(df1,annotation_col = df2,annotation_row = df3)

anno_colors<-list(Group_1=c(A="red",B="Blue",C="green"),
                  Group_2=c(A_gene="orange",B_gene="skyblue"))

pheatmap(df1,
         annotation_col = df2,
         annotation_row = df3,
         cutree_rows = 2,
         cutree_cols = 3,
         annotation_colors = anno_colors)
