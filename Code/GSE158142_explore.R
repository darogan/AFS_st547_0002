


library("Seurat")
library("ggplot2")
library("patchwork")
library("cowplot")
library("xlsx")

baseDir <- "/storage/Russell/AFS_Test/"
setwd(baseDir)

sample_sheet <- read.csv(paste0(baseDir, "sample_sheet.csv"), header=T)
sample_sheet$ClusteringResolution <- as.character( sample_sheet$ClusteringResolution )


runTimePoint <- function(RDS, RESOLUTION, TITLE, GENE){

  # read in time point and convert to v3 seurat format
  zftp_oldformat <- readRDS( paste0(baseDir, "RDS/", RDS) )
  zftp           <- UpdateSeuratObject(object = zftp_oldformat)

  # Make some tSNE based plots
  plt.1 <- DimPlot(zftp, group.by=RESOLUTION, label = T) + ggtitle(TITLE) + coord_fixed() & theme_bw() + theme(legend.position = "none")
  plt.2 <- FeaturePlot(zftp, features = c(GENE) ) + ggtitle(paste0(TITLE, " : ", GENE)) + coord_fixed() & theme_bw() 

  pdf(paste0(baseDir, "Plots/", "Dimplot_", TITLE, "_", RESOLUTION, ".pdf"), width=5,height=5, onefile=FALSE)
  par(bg=NA)
  print(plt.1)
  dev.off()
  
  pdf(paste0(baseDir, "Plots/", "FeaturePlot_", TITLE, "_", RESOLUTION, "_", GENE, ".pdf"), width=6,height=5, onefile=FALSE)
  par(bg=NA)
  print(plt.2)
  dev.off()
  
  # Get the average expression per cluster
  ave.expr <- as.data.frame( AverageExpression(zftp, features = c(GENE), group.by=RESOLUTION )$RNA )
  
  write.xlsx( t(ave.expr),
    paste0(baseDir, "Data/", "AverageExpression_", TITLE, "_", RESOLUTION, "_", GENE, ".xlsx"),
    sheetName = TITLE, col.names=T, row.names=T, append=F)
  
  return(ave.expr)
}

# test one file
# zf36hpf <- runTimePoint("GSE158142_zf36hpf_cc_filt.cluster.rds", "res.6", "zf36hpf", "dlk2")


for(i in 1:nrow(sample_sheet)) 
  {     
    message( paste0("Running: ",  i, " : ", sample_sheet[i,c("RDS")]  ) )
  
    ave.exp <- runTimePoint( sample_sheet[i,c("RDS")], 
                 sample_sheet[i,c("ClusteringResolution")], 
                 paste0(sample_sheet[i,c("Stage")], sample_sheet[i,c("Units")]), 
                "dlk2") 
  }


#
# END_OF_SCRIPT
#
