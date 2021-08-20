#notes
#will only produce one half of the plot
#be careful to ensure your readin file has the start site as the start site column (and not the start OR stop)
#this will cause your gene arrows to not show up in the proper orientation regardless of orientation data.

#geneplot diagram libraries
library(ggplot2)
library(gggenes)
library(RColorBrewer)
library(gghighlight)

#Makes standrard gene plot, with some aesethic adjustments for supplemental
genes <- read.delim("Aenteropelogenes_CECT4255T_syntenicregion_condensed.fna", header = TRUE)
genes$gene=as.factor(genes$gene)
#change this number if you have more annotations
nb.cols <- 30
mycolors <- colorRampPalette(brewer.pal(12,"Set3"))(nb.cols)
ggplot(genes, aes(xmin = start, xmax = stop, y = chr, fill = gene,orientation=strand)) +
  scale_fill_manual(values = mycolors) +
  geom_gene_arrow() +
  theme_genes() +
  facet_wrap(~ chr, scales="fixed", ncol = 1)
  

ggsave("gggenes_plot_contig4_rast_v_prokka.pdf",height=6,width=10,units="in")

