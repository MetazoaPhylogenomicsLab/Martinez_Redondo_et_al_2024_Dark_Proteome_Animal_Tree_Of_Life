library(tidyverse)
library(scico)
library(rphylopic)
library(data.table)
library(ggplot2)
library(ggpubr)
library(ggtree)
library(ggtreeExtra)
library(ggnewscale)
library(corrplot)
library(dichromat)
library(ggridges)

setwd("Phylum")
data_unfiltered<-fread("prott5_genes_sp.txt")
colnames(data_unfiltered)<-c("Species","Ann_genes")
data_unfiltered$Filter<-rep("None",nrow(data_unfiltered))
data_filtered<-fread("prott5_filtered_genes_sp.txt")
colnames(data_filtered)<-c("Species","Ann_genes")
data_filtered$Filter<-rep("Threshold",nrow(data_filtered))
data<-rbind(data_unfiltered,data_filtered)
#Add steps for factoring by phylum
metadata<-fread("../Isoforms/Taxon_list_subset.tsv",header=TRUE, sep="\t")
data<-inner_join(data,metadata,by=c("Species"="CODE (5 letter code)"))
#sort by phylum
phyla_order<-c("CTENOPHORA","PORIFERA","PLACOZOA","CNIDARIA","XENOTURBELLIDA","ACOELA","NEMERTODERMATIDA","ECHINODERMATA","HEMICHORDATA","CEPHALOCHORDATA","UROCHORDATA","CRANIATA","KINORHYNCHA","PRIAPULIDA","NEMATODA","NEMATOMORPHA","TARDIGRADA","ONYCHOPHORA","ARTHROPODA","CHAETOGNATHA","ROTIFERA","MICROGNATHOZOA","DICYEMIDA","GASTROTRICHA","PLATYHELMINTHES","BRYOZOA","ENTOPROCTA","CYCLIOPHORA","MOLLUSCA","ANNELIDA","NEMERTEA","BRACHIOPODA","PHORONIDA") %>% rev()
data$PHYLUM<-factor(data$PHYLUM,levels=phyla_order)
data<-data %>% mutate(Proportion_annotated=Ann_genes/No_GENES)
#Remove outgroups
data<-data[data$PHYLUM!="Outgroup",]

tree <- read.tree("../metazoa_phyla_tree.nwk")

#Plot number/proportion of genes annotated by prott5 (before and after filtering) per phylum

rectangles <- data.frame(
  ymin = phyla_order,
  ymax = dplyr::lead(phyla_order),
  xmin = -Inf,
  xmax = Inf
)
rectangles[is.na(rectangles$ymax),"ymax"]<-"PHORONIDA"
rectangles$ymin<-factor(rectangles$ymin,levels=phyla_order)

pdf("prott5_annotation_filter_prop_per_phylum.pdf", width=6,height=6)
ggplot(data=data[,c("PHYLUM","Ann_genes","Proportion_annotated","Filter")])+
  geom_rect(data=rectangles, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax, fill=ymin), alpha=0.5, show.legend=FALSE)+
  scale_fill_manual(values=rep(c("white","grey90"),17))+
  new_scale_fill()+
  geom_boxplot(aes(x=Proportion_annotated, y=PHYLUM, fill=Filter))+
  theme_pubr()+
  theme(legend.position="right",legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), strip.background = element_blank())+
  labs(x = "Proportion of annotated genes",y=NULL)+
  scale_fill_manual(values=c("#2D204C","#C36D9A"))
dev.off()

#Plot proportion of annotated genes by eggnog-mapper, deepgplus, prott5, seqvec after filtering per phylum
data_eggnog<-fread("eggnog_filtered_genes_sp.txt")
colnames(data_eggnog)<-c("Species","Ann_genes")
data_eggnog$Method<-rep("EggNOG-mapper",nrow(data_eggnog))
data_deepgoplus<-fread("deepgoplus_filtered_genes_sp.txt")
colnames(data_deepgoplus)<-c("Species","Ann_genes")
data_deepgoplus$Method<-rep("DeepGOPlus",nrow(data_deepgoplus))
data_prott5<-fread("prott5_filtered_genes_sp.txt")
colnames(data_prott5)<-c("Species","Ann_genes")
data_prott5$Method<-rep("GOPredSim-ProtT5",nrow(data_prott5))
data_seqvec<-fread("seqvec_filtered_genes_sp.txt")
colnames(data_seqvec)<-c("Species","Ann_genes")
data_seqvec$Method<-rep("GOPredSim-SeqVec",nrow(data_seqvec))
data<-rbind(data_eggnog, data_deepgoplus, data_prott5, data_seqvec)
#Add steps for factoring by phylum
metadata<-fread("../Isoforms/Taxon_list_subset.tsv",header=TRUE, sep="\t")
data<-inner_join(data,metadata,by=c("Species"="CODE (5 letter code)"))
#sort by phylum
phyla_order<-c("CTENOPHORA","PORIFERA","PLACOZOA","CNIDARIA","XENOTURBELLIDA","ACOELA","NEMERTODERMATIDA","ECHINODERMATA","HEMICHORDATA","CEPHALOCHORDATA","UROCHORDATA","CRANIATA","KINORHYNCHA","PRIAPULIDA","NEMATODA","NEMATOMORPHA","TARDIGRADA","ONYCHOPHORA","ARTHROPODA","CHAETOGNATHA","ROTIFERA","MICROGNATHOZOA","DICYEMIDA","GASTROTRICHA","PLATYHELMINTHES","BRYOZOA","ENTOPROCTA","CYCLIOPHORA","MOLLUSCA","ANNELIDA","NEMERTEA","BRACHIOPODA","PHORONIDA") %>% rev()
data$PHYLUM<-factor(data$PHYLUM,levels=phyla_order)
data<-data %>% mutate(Proportion_annotated=Ann_genes/No_GENES)
data$Method<-factor(data$Method,levels=c("EggNOG-mapper","DeepGOPlus","GOPredSim-ProtT5","GOPredSim-SeqVec"))
#Remove outgroups
data<-data[data$PHYLUM!="Outgroup",]
tree <- read.tree("../metazoa_phyla_tree.nwk")
#Plot number/proportion of genes annotated
rectangles <- data.frame(
  ymin = phyla_order,
  ymax = dplyr::lead(phyla_order),
  xmin = -Inf,
  xmax = Inf
)
rectangles[is.na(rectangles$ymax),"ymax"]<-"PHORONIDA"
rectangles$ymin<-factor(rectangles$ymin,levels=phyla_order)

pdf("annotation_filter_prop_per_phylum.pdf", width=6,height=9)
ggplot(data=data[,c("PHYLUM","Ann_genes","Proportion_annotated","Method")])+
  geom_rect(data=rectangles, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax, fill=ymin), alpha=0.5, show.legend=FALSE)+
  scale_fill_manual(values=rep(c("white","grey90"),17))+
  new_scale_fill()+
  geom_boxplot(aes(x=Proportion_annotated, y=PHYLUM, fill=Method, color=Method))+
  theme_pubr()+
  theme(legend.position="right",legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), strip.background = element_blank())+
  labs(x = "Proportion of annotated genes",y=NULL)+
  scale_fill_manual(values=c("#FF6E3A","#8400CD","#00C2F9","#008DF9"))+
  scale_color_manual(values=c("#8c3718","#3e0061","#006582","#00457a"))
dev.off()

#Plot proportion of annotated genes by eggnog-mapper unfiltered per phylum
data<-fread("eggnog_genes_sp.txt")
colnames(data)<-c("Species","Ann_genes")
#Add steps for factoring by phylum
metadata<-fread("../Isoforms/Taxon_list_subset.tsv",header=TRUE, sep="\t")
data<-inner_join(data,metadata,by=c("Species"="CODE (5 letter code)"))
#sort by phylum
phyla_order<-c("CTENOPHORA","PORIFERA","PLACOZOA","CNIDARIA","XENOTURBELLIDA","ACOELA","NEMERTODERMATIDA","ECHINODERMATA","HEMICHORDATA","CEPHALOCHORDATA","UROCHORDATA","CRANIATA","KINORHYNCHA","PRIAPULIDA","NEMATODA","NEMATOMORPHA","TARDIGRADA","ONYCHOPHORA","ARTHROPODA","CHAETOGNATHA","ROTIFERA","MICROGNATHOZOA","DICYEMIDA","GASTROTRICHA","PLATYHELMINTHES","BRYOZOA","ENTOPROCTA","CYCLIOPHORA","MOLLUSCA","ANNELIDA","NEMERTEA","BRACHIOPODA","PHORONIDA") %>% rev()
data$PHYLUM<-factor(data$PHYLUM,levels=phyla_order)
data<-data %>% mutate(Proportion_annotated=Ann_genes/No_GENES)
#Remove outgroups
data<-data[data$PHYLUM!="Outgroup",]
tree <- read.tree("../metazoa_phyla_tree.nwk")
#Plot number/proportion of genes annotated
rectangles <- data.frame(
  ymin = phyla_order,
  ymax = dplyr::lead(phyla_order),
  xmin = -Inf,
  xmax = Inf
)
rectangles[is.na(rectangles$ymax),"ymax"]<-"PHORONIDA"
rectangles$ymin<-factor(rectangles$ymin,levels=phyla_order)

pdf("annotation_eggnog_prop_per_phylum.pdf", width=6,height=6)
ggplot(data=data[,c("PHYLUM","Ann_genes","Proportion_annotated")])+
  geom_rect(data=rectangles, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax, fill=ymin), alpha=0.5, show.legend=FALSE)+
  scale_fill_manual(values=rep(c("white","grey90"),17))+
  new_scale_fill()+
  geom_boxplot(aes(x=Proportion_annotated, y=PHYLUM), fill="#C36D9A")+
  theme_pubr()+
  theme(legend.position="right",legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), strip.background = element_blank())+
  labs(x = "Proportion of annotated genes",y=NULL)+
  scale_x_continuous(breaks=seq(0, 1, 0.1))
dev.off()

#Plot heatmap count of species per phylum
sp_data<-table(metadata$PHYLUM) %>% as.data.table()
colnames(sp_data)<-c("Phylum","No_species")
sp_data<-sp_data[sp_data$Phylum!="Outgroup",]
sp_data$No_species<-as.numeric(sp_data$No_species)
sp_data$Phylum<-factor(sp_data$Phylum,levels=phyla_order)
sp_data$V2<-"No species"
pdf("sp_heatmap.pdf", width=3.51,height=6)
ggplot(data=sp_data,aes(x=V2,y=Phylum,fill=No_species))+
  geom_tile()+
  geom_text(aes(label=No_species))+
  scale_fill_scico(palette = "acton",direction=-1)+
  theme_pubr()+
  theme(legend.position="right",legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), strip.background = element_blank())
dev.off()

#All data disorder
data_disorder<-fread("disorder_all.txt") %>% rename(Gene=V1,Disorder=V2)
annotated_eggnog<-read.table("../PCA/annotated_genes_eggnog.txt",header=FALSE)
data<-data_disorder %>% mutate(Annotated=case_when(Gene %in% annotated_eggnog$V1 ~ "Yes", .default="No"))
data$Annotated<-as.factor(data$Annotated)
data<- data_disorder %>% mutate(Annotated=case_when(Gene %in% annotated_eggnog$V1 ~ "Yes", .default="No"))
data<-data %>% mutate(Prot_disorder=case_when(Disorder <0.1 ~ "Globular", Disorder >=0.1 & Disorder < 0.3 ~ "Nearly ordered", Disorder >= 0.3 & Disorder <0.7 ~ "Partially disordered", Disorder >= 0.7 ~ "Mostly disordered"))
data$Prot_disorder<-factor(data$Prot_disorder,levels=c("Globular","Nearly ordered","Partially disordered","Mostly disordered"))
data<-data %>% mutate(Species=str_extract(Gene,"[A-Z]+[0-9]"))
metadata<-fread("../Isoforms/Taxon_list_subset.tsv",header=TRUE, sep="\t")
data<-inner_join(data,metadata,by=c("Species"="CODE (5 letter code)"))
#Remove outgroups
data<-data[data$PHYLUM!="Outgroup",]
phyla_order<-c("CTENOPHORA","PORIFERA","PLACOZOA","CNIDARIA","XENOTURBELLIDA","ACOELA","NEMERTODERMATIDA","ECHINODERMATA","HEMICHORDATA","CEPHALOCHORDATA","UROCHORDATA","CRANIATA","KINORHYNCHA","PRIAPULIDA","NEMATODA","NEMATOMORPHA","TARDIGRADA","ONYCHOPHORA","ARTHROPODA","CHAETOGNATHA","ROTIFERA","MICROGNATHOZOA","DICYEMIDA","GASTROTRICHA","PLATYHELMINTHES","BRYOZOA","ENTOPROCTA","CYCLIOPHORA","MOLLUSCA","ANNELIDA","NEMERTEA","BRACHIOPODA","PHORONIDA")
data$PHYLUM<-factor(data$PHYLUM, levels=phyla_order)
data$DATA_TYPE<-factor(data$DATA_TYPE)
#Annotated & Disorder
chisq <- chisq.test(table(data[,c("Annotated","Prot_disorder")]))
chisq$p.value
pdf("chisqsdresiduals_annotated_disorder.pdf",width=10,height=6)
corrplot(chisq$stdres, method="color", is.cor = FALSE,col=colorRampPalette(c("#A7658F","white","#260C3F"))(100),tl.col="black",cl.align.text="l",cl.offset=0.1,tl.srt=60)
dev.off()

#Plot IC per phylum
setwd("")
ic_data<-fread("IC_content/genes_annotated_ic_longest_gopredsim_prott5_threshold_bp.txt")
colnames(ic_data)<-"Information_content"
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_count_sp<-fread("Phylum/ic_count_sp_bp.txt")
colnames(ic_count_sp)<-c("Count","Species")
ic_data$Species<-rep(ic_count_sp$Species,ic_count_sp$Count)
ic_data <- na.omit(ic_data, "Information_content")
metadata<-fread("Isoforms/Taxon_list_subset.tsv",header=TRUE, sep="\t")
ic_data<-inner_join(ic_data,metadata,by=c("Species"="CODE (5 letter code)"))
#sort by phylum
phyla_order<-c("CTENOPHORA","PORIFERA","PLACOZOA","CNIDARIA","XENOTURBELLIDA","ACOELA","NEMERTODERMATIDA","ECHINODERMATA","HEMICHORDATA","CEPHALOCHORDATA","UROCHORDATA","CRANIATA","KINORHYNCHA","PRIAPULIDA","NEMATODA","NEMATOMORPHA","TARDIGRADA","ONYCHOPHORA","ARTHROPODA","CHAETOGNATHA","ROTIFERA","MICROGNATHOZOA","DICYEMIDA","GASTROTRICHA","PLATYHELMINTHES","BRYOZOA","ENTOPROCTA","CYCLIOPHORA","MOLLUSCA","ANNELIDA","NEMERTEA","BRACHIOPODA","PHORONIDA") %>% rev()
ic_data$PHYLUM<-factor(ic_data$PHYLUM,levels=phyla_order)
#Remove outgroups
ic_data<-ic_data[ic_data$PHYLUM!="Outgroup",]
ic_data$Category<-rep("bp",nrow(ic_data))

ic_data2<-fread("IC_content/genes_annotated_ic_longest_gopredsim_prott5_threshold_mf.txt")
colnames(ic_data2)<-"Information_content"
ic_data2$Information_content<-as.numeric(ic_data2$Information_content)
ic_count_sp<-fread("Phylum/ic_count_sp_mf.txt")
colnames(ic_count_sp)<-c("Count","Species")
ic_data2$Species<-rep(ic_count_sp$Species,ic_count_sp$Count)
ic_data2 <- na.omit(ic_data2, "Information_content")
metadata<-fread("Isoforms/Taxon_list_subset.tsv",header=TRUE, sep="\t")
ic_data2<-inner_join(ic_data2,metadata,by=c("Species"="CODE (5 letter code)"))
#sort by phylum
ic_data2$PHYLUM<-factor(ic_data2$PHYLUM,levels=phyla_order)
ic_data2$Category<-rep("mf",nrow(ic_data2))
#Remove outgroups
ic_data2<-ic_data2[ic_data2$PHYLUM!="Outgroup",]

ic_data<-rbind(ic_data,ic_data2)

ic_data2<-fread("IC_content/genes_annotated_ic_longest_gopredsim_prott5_threshold_cc.txt")
colnames(ic_data2)<-"Information_content"
ic_data2$Information_content<-as.numeric(ic_data2$Information_content)
ic_count_sp<-fread("Phylum/ic_count_sp_cc.txt")
colnames(ic_count_sp)<-c("Count","Species")
ic_data2$Species<-rep(ic_count_sp$Species,ic_count_sp$Count)
ic_data2 <- na.omit(ic_data2, "Information_content")
metadata<-fread("Isoforms/Taxon_list_subset.tsv",header=TRUE, sep="\t")
ic_data2<-inner_join(ic_data2,metadata,by=c("Species"="CODE (5 letter code)"))
#sort by phylum
ic_data2$PHYLUM<-factor(ic_data2$PHYLUM,levels=phyla_order)
ic_data2$Category<-rep("cc",nrow(ic_data2))
#Remove outgroups
ic_data2<-ic_data2[ic_data2$PHYLUM!="Outgroup",]

ic_data<-rbind(ic_data,ic_data2)

categories <- c(
  `bp` = "Biological\nprocess",
  `cc` = "Cellular\ncomponent",
  `mf` = "Molecular\nfunction"
)

pdf("Phylum/IC_per_phylum_prott5_filtered.pdf", width=6,height=6)
ggplot(data = ic_data)+
  geom_density_ridges(mapping=aes(x = Information_content, y=PHYLUM, height = ..density..), size= 1,alpha=0.5, color="#00C2F9", fill="#00C2F9")+
  facet_wrap(~Category, labeller = as_labeller(categories))+
  theme_pubr()+
  theme(legend.position="right",legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), strip.background = element_blank(),panel.grid.major.y = element_line(colour="grey"),strip.text=element_text(size=10, face = "bold"))+
  labs(x = "Information Content",y=NULL)
dev.off()