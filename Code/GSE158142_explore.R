


library("Seurat")
library("ggplot2")
library("patchwork")
library("cowplot")
library("useful")
library("openxlsx")
library("readxl")

baseDir <- "AFS_st547_0002/"
setwd(baseDir)

sample_sheet <- read.csv(paste0(baseDir, "Data/",  "sample_sheet.csv"), header=T)
sample_sheet$ClusteringResolution <- as.character( sample_sheet$ClusteringResolution )


runTimePoint <- function(RDS, RESOLUTION, TITLE, GENE){

  print("read in time point RDS")
  zftp_oldformat <- readRDS( paste0(baseDir, "RDS/", RDS) )
  print("Convert to v3 seurat format")
  zftp           <- UpdateSeuratObject(object = zftp_oldformat)
  rm(zftp_oldformat)
  
  print("Make some tSNE based plots")
  plt.1 <- DimPlot(zftp, group.by=RESOLUTION, label = T) + ggtitle(TITLE) + coord_fixed() & theme_bw() + theme(legend.position = "none")

  pdf(paste0(baseDir, "Plots/", "Dimplot_", TITLE, "_", RESOLUTION, ".pdf"), width=5,height=5, onefile=FALSE)
  par(bg=NA)
  print(plt.1)
  dev.off()
  
  an.error.occured <- FALSE
  tryCatch( 
     { 
       plt.2 <- FeaturePlot(zftp, features = c(GENE) ) + ggtitle(paste0(TITLE, " : ", GENE)) + coord_fixed() & theme_bw() 
       pdf(paste0(baseDir, "Plots/", "FeaturePlot_", TITLE, "_", RESOLUTION, "_", GENE, ".pdf"), width=6,height=5, onefile=FALSE)
       par(bg=NA)
       print(plt.2)
       dev.off()
       
       print("Get the average expression per cluster")
       ave.expr <- as.data.frame( AverageExpression(zftp, features = c(GENE), group.by=RESOLUTION )$RNA )
       print("Write the average expression per cluster")
       write.xlsx( as.data.frame( t(ave.expr) ),
                   file=paste0(baseDir, "Data/", "AverageExpression_", TITLE, "_", RESOLUTION, "_", GENE, ".xlsx"),
                   sheetName = TITLE, colNames=T, rowNames=T, overwrite=T, asTable = TRUE) },
      error=function(e){ an.error.occured <<- TRUE} )
  print(paste0("Missing ", GENE, " = ", an.error.occured))
  
  rm(zftp)
  gc()
  
  #return(ave.expr)
#  }
}


#Dlk1 (gene ID: CABZ01102109.1)

# ISSUES WITH "jag2a", "ctn1a","ctn3a",

genes <- c("dlk2",
           "dla", "dlb", "dlc", "dld", "dll4",
           "jag1a", "jag1b",  "jag2b",
           "mdm2", "numb", "egfl7", "ybx1", "thbs2a","mfap2",
           "notch1a", "notch1b", "notch2", "notch3",
           "CABZ01102109.1",  "mfap5",  "dner")
length(genes)



#Sys.setenv('R_MAX_VSIZE'=16000000000)
#j=1
#for(i in 1:nrow(sample_sheet)) 
  for(i in 12:12) 
    
  {
  for(j in 26:length(genes))   
     {
        message( paste0("Running: ", j, "/", length(genes), ":", genes[j], " ::: ", 
                        i, "/", nrow(sample_sheet), ":", sample_sheet[i,c("RDS")]  ) )
  
        ave.exp <- runTimePoint( sample_sheet[i,c("RDS")], 
                   sample_sheet[i,c("ClusteringResolution")], 
                   paste0(sample_sheet[i,c("Stage")], sample_sheet[i,c("Units")]), 
                   genes[j])
      }
  }



# ave.exp <- runTimePoint( sample_sheet[12,c("RDS")], 
#                          sample_sheet[12,c("ClusteringResolution")], 
#                          paste0(sample_sheet[12,c("Stage")], sample_sheet[i,c("Units")]), 
#                          "mfap5")
# 
# ave.exp <- runTimePoint( sample_sheet[12,c("RDS")], 
#                          sample_sheet[12,c("ClusteringResolution")], 
#                          paste0(sample_sheet[12,c("Stage")], sample_sheet[i,c("Units")]), 
#                          "jag2b")


for(i in 1:length(genes))
   {
     message(genes[i])
     inputfiles <- list.files(paste0(baseDir, "/Data"), pattern = paste0("AverageExpression.*", genes[i]), full.names=T)
     print(inputfiles)

     df.list    <- lapply(inputfiles ,function(x) read_excel(x))

     wb <- createWorkbook()

     for(j in 1:length(inputfiles))
     {
       fname <- basename(inputfiles[j])
       fname <- gsub("AverageExpression_", "", fname)
       fname <- gsub(".xlsx",              "", fname)

       addWorksheet(wb, fname)
       writeData(wb, fname, df.list[j])
     }
     saveWorkbook(wb, file = paste0("Data/CombinedAverageExpression_", genes[i], ".xlsx"), overwrite = TRUE)
   }





#
# END_OF_SCRIPT
#