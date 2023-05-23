# AFS_st547_0002

Bioinformatics methods for the re-analysis of Raj et al, 2020 and zebrafish tracking scripts to accompany Telerman et al, 2023 [add paper title and DOI when available and link to Journal website]

Stephanie B. Telerman<sup>1</sup>, Russell S, Hamilton<sup>1</sup>, Ben Shaw<sup>1</sup>, Jordan D. Dimitrov<sup>2</sup>, Ben Steventon<sup>1</sup> & Anne.C Ferguson-Smith<sup>1,*</sup> (2023) Post-translational regulation of the Numb/Notch pathway in neurogenesis and cancer by Dlk2 

> ADD DOI LINKS ONCE AVAILABLE

<sub>
<sup>1</sup> Department of Genetics, University of Cambridge, CB2 3EH Cambridge, United Kingdom
<sup>2</sup> Centre de Recherche des Cordeliers, INSERM, CNRS, Sorbonne Université, Université Paris Cité, 75006 Paris, France
<sup>*</sup> Corresponding author
</sub>



## Zebra Fish Tracking

Tracking, recording, and data acquisition of larval (vibration startle and light/dark cycles assays) were done using the Zantiks MWP unit (Zantiks limited, Cambridge UK). The detailed scripts of the experimental setups for both experiments are available below. 

### Tracking Scripts

1. [[light_dark_transitions](Tracking/light_dark_transitions_zoom_21st.zs)]
2. [[vibration_protocol_zoom_21st](Tracking/vibration_protocol_zoom_21st.zs)]

## Single Cell RNA-Seq
Reanalysis of:

Raj et al. (2020) Emergence of Neuronal Diversity during Vertebrate Brain Development. Neuron, 108:6, 1058--1074.e6
https://doi.org/10.1016/j.neuron.2020.09.023

```
@article{Raj2020,
  doi = {10.1016/j.neuron.2020.09.023},
  url = {https://doi.org/10.1016/j.neuron.2020.09.023},
  year = {2020},
  month = dec,
  publisher = {Elsevier {BV}},
  volume = {108},
  number = {6},
  pages = {1058--1074.e6},
  author = {Bushra Raj and Jeffrey A. Farrell and Jialin Liu and Jakob El Kholtei and Adam N. Carte and Joaquin Navajas Acedo and Lucia Y. Du and Aaron McKenna and {\DJ}or{\dj}e Reli{\'{c}} and Jessica M. Leslie and Alexander F. Schier},
  title = {Emergence of Neuronal Diversity during Vertebrate Brain Development},
  journal = {Neuron}
}
```

### Data Download from GEO

Wget commands for downloading all the required rds files are available in [[Code/get_GSE158142_RDSFiles.sh](Code/get_GSE158142_RDSFiles.sh)]. The sample sheet containing metadata (RDS, Stage, Units, ClusteringResolution) for the Robjects was also downloaded in order to match the published annotations and resolutions for the dimensionality reduction. 

Each GEO Robject/RDS was read into Seurat and converted to Version 3 format using `UpdateSeuratObject()`.

> Example command:

`wget https://ftp.ncbi.nlm.nih.gov/geo/series/GSE158nnn/GSE158142/suppl/GSE158142_zf10s_cc_filt.cluster.rds.gz`

### Analysis Code

An Rscript is provided to run the gene specific re-analysis of the single-cell data [[Code/GSE158142_explore.R ](Code/GSE158142_explore.R )]. 

### Methods

Reanalysis of the single-cell RNA-Seq data from Raj et al, 2020 was performed using R (v4.2.1) and R-Studio (v2022.12.+353). From the GEO data submission [[GSE158142](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE158142)] the Robject files were downloaded for each time point and loaded in to Seurat (v4.3.0) [Cite Seurat - see below]. The sample sheet containing metadata (RDS, Stage, Units, ClusteringResolution) for the Robjects was also downloaded in order to match the published annotations and resolutions for the dimensionality reduction. UMAP plots at the published resulution were plotted for specific genes of interest using `FeaturePlot()`. Average expression for published clusters and resolutions were extracted using `AverageExpression()` and written to XLS format files. We have provided shell scripts and a Rscript a download and recreate the gene specific analyses via GitHub [[https://github.com/darogan/AFS_st547_0002](https://github.com/darogan/AFS_st547_0002)]. We also provide gene specific data and plot files.

### Seurat Reference

````
@Article{,
  author = {Andrew Butler and Paul Hoffman and Peter Smibert and Efthymia Papalexi and Rahul Satija},
  title = {Integrating single-cell transcriptomic data across different conditions, technologies, and species},
  journal = {Nature Biotechnology},
  year = {2018},
  volume = {36},
  pages = {411-420},
  doi = {10.1038/nbt.4096},
  url = {https://doi.org/10.1038/nbt.4096},
}
````


### Sample Sheet

| RDS                                   | Stage | Units | ClusteringResolution |
|---------------------------------------|-------|-------|----------------------|
| GSE158142_zf6s_cc_filt.cluster.rds    |    12 | hpf   | res.4.5              |
| GSE158142_zf10s_cc_filt.cluster.rds   |    14 | hpf   | res.4                |
| GSE158142_zf14s_cc_filt.cluster.rds   |    16 | hpf   | res.5                |
| GSE158142_zf18s_cc_filt.cluster.rds   |    18 | hpf   | res.5                |
| GSE158142_zf20hpf_cc_filt.cluster.rds |    20 | hpf   | res.4.5              |
| GSE158142_zf24hpf_cc_filt.cluster.rds |    24 | hpf   | res.5                |
| GSE158142_zf36hpf_cc_filt.cluster.rds |    36 | hpf   | res.6                |
| GSE158142_zf2dpf_cc_filt.cluster.rds  |     2 | dpf   | res.6                |
| GSE158142_zf3dpf_cc_filt.cluster.rds  |     3 | dpf   | res.5                |
| GSE158142_zf5dpf_cc_filt.cluster.rds  |     5 | dpf   | res.5.5              |
| GSE158142_zf8dpf_cc_filt.cluster4.rds |     8 | dpf   | res.6                |
| GSE158142_zf15dpf_PCAALL.rds          |    15 | dpf   | res.5                |

### Results

Gene of interest is dlk2 (ENSDARG00000076247), tables below refer to dlk2 however results for a wider selection of genes is available in the sub-directories (Plots/ and Data/).

| Sample          | DimPlot | FeaturePlot (dlk2) | AverageExpression |
| --------------- | ----------------------------------------- | ----------- | ----------------- |
| GSE158142_12hpf  | [[PDF](Plots/Dimplot_12hpf_res.4.5.pdf)] | [[PDF](Plots/FeaturePlot_12hpf_res.4.5_dlk2.pdf)] | [[XLSX](Data/AverageExpression_12hpf_res.4.5_dlk2.xlsx)] |
| GSE158142_14hpf  | [[PDF](Plots/Dimplot_14hpf_res.4.pdf)] | [[PDF](Plots/FeaturePlot_14hpf_res.4_dlk2.pdf)]   | [[XLSX](Data/AverageExpression_14hpf_res.4_dlk2.xlsx)]   |
| GSE158142_16hpf  | [[PDF](Plots/Dimplot_16hpf_res.5.pdf)] | [[PDF](Plots/FeaturePlot_16hpf_res.5_dlk2.pdf)]   | [[XLSX](Data/AverageExpression_16hpf_res.5_dlk2.xlsx)]              |
| GSE158142_18hpf  | [[PDF](Plots/Dimplot_18hpf_res.5.pdf)] | [[PDF](Plots/FeaturePlot_18hpf_res.5_dlk2.pdf)]   | [[XLSX](Data/AverageExpression_18hpf_res.5_dlk2.xlsx)]   |
| GSE158142_20hpf  | [[PDF](Plots/Dimplot_20hpf_res.4.5.pdf)] | [[PDF](Plots/FeaturePlot_20hpf_res.4.5_dlk2.pdf)] | [[XLSX](Data/AverageExpression_20hpf_res.4.5_dlk2.xlsx)]   |
| GSE158142_24hpf  | [[PDF](Plots/Dimplot_24hpf_res.5.pdf)] | [[PDF](Plots/FeaturePlot_24hpf_res.5_dlk2.pdf)]   | [[XLSX](Data/AverageExpression_24hpf_res.5_dlk2.xlsx)] |
| GSE158142_36hpf  | [[PDF](Plots/Dimplot_36hpf_res.6.pdf)] | [[PDF](Plots/FeaturePlot_36hpf_res.6_dlk2.pdf)]   | [[XLSX](Data/AverageExpression_36hpf_res.6_dlk2.xlsx)]   |
| GSE158142_2dpf   | [[PDF](Plots/Dimplot_2dpf_res.6.pdf)]  | [[PDF](Plots/FeaturePlot_2dpf_res.6_dlk2.pdf)]    | [[XLSX](Data/AverageExpression_2dpf_res.6_dlk2.xlsx)]    |
| GSE158142_3dpf   | [[PDF](Plots/Dimplot_3dpf_res.5.pdf)]  | [[PDF](Plots/FeaturePlot_3dpf_res.5_dlk2.pdf)]    | [[XLSX](Data/AverageExpression_3dpf_res.5_dlk2.xlsx)]    |
| GSE158142_5dpf   | [[PDF](Plots/Dimplot_5dpf_res.5.5.pdf)]  | [[PDF](Plots/FeaturePlot_5dpf_res.5.5_dlk2.pdf)]  | [[XLSX](Data/AverageExpression_5dpf_res.5.5_dlk2.xlsx)]  |
| GSE158142_8dpf   | [[PDF](Plots/Dimplot_8dpf_res.6.pdf)]  | [[PDF](Plots/FeaturePlot_8dpf_res.6_dlk2.pdf)]    | [[XLSX](Data/AverageExpression_8dpf_res.6_dlk2.xlsx)]    |
| GSE158142_zf15dpf | [[PDF](Plots/Dimplot_15dpf_res.5.pdf)]  | [[PDF](Plots/FeaturePlot_15dpf_res.5_dlk2.pdf)]    | [[XLSX](Data/AverageExpression_15dpf_res.5_dlk2.xlsx)]    |

# Contact

Bioinformatics ::: Russell Hamilton ::: darogan@gmail.com
Main Paper ::: Stephanie Telerman ::: st547@cam.ac.uk
