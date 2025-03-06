install.packages("dplyr")
## Load the required libraries
library("ggplot2") 
library("tidyr") 
library("dplyr") 
library("cowplot") 
library("RColorBrewer") 
library("PupillometryR")
library("ggpubr")

getwd()
setwd("/Users/shawnrain/Desktop/Final_year_project/scatterplot")
## Load the data
df<-read.csv("total_genes.csv",header=T,
             stringsAsFactors = F)

## Select the columns and reorder the data
df <- select(df,c("cyc8","tup1","tup1.cyc8"))

## Reformat the data for ggplot
plotData <- gather(df,
                   condition,
                   value,
                   colnames(df),
                   factor_key = TRUE) %>%
  filter(value != "") 

## plot the data
ggplot(plotData, aes(x = condition, y = value, fill = condition, color = condition)) +
  ggtitle("total downregulated genes") +
  ylab("Log2Flod Change") +
  xlab("knockout genes") +
  theme_cowplot() +
  scale_shape_identity() +
  theme(legend.position = "none",
        plot.title = element_text(size = 20),
        axis.title = element_text(size = 15),
        axis.text = element_text(size = 15),
        axis.text.x = element_text(angle = 0, 
                                   hjust = 0.4,
                                   vjust = 0)) +
  scale_colour_brewer(palette = "Set1") +
  scale_fill_brewer(palette = "Set1") +
  geom_point(position = position_jitter(0.15), 
             size = 2, 
             alpha = 1, 
             aes(shape = 16)) +
  geom_flat_violin(position = position_nudge(x = 0.25, y = 0),
                   adjust = 2,
                   alpha = 0.6, 
                   trim = TRUE, 
                   scale = "width") +
  geom_boxplot(aes(x = as.numeric(condition) + 0.25, y = value), 
               notch = TRUE, 
               width = 0.1, 
               varwidth = FALSE, 
               outlier.shape = NA, 
               alpha = 0.3, 
               colour = "black", 
               show.legend = FALSE)+
  theme_classic() +
  geom_signif(comparisons = list(c("cyc8", "tup1"),
                                 c("tup1", "tup1.cyc8"),
                                 c("cyc8", "tup1.cyc8")),
              map_signif_level=TRUE,
              textsize=5,
              test=wilcox.test,
              step_increase=0.2,
              size = 1) +
  theme(axis.line = element_line(size = 0.5),
  axis.ticks = element_line(size = 1),
  axis.text = element_text(size = 16),
  axis.title = element_text(size = 16))

