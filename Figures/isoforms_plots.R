library(tidyverse)
library(scico)
library(rphylopic)
library(data.table)
library(ggplot2)
library(ggpubr)
library(ggtree)
library(grafify)
library(ggridges)
library(see)
library(corrplot)
library(dichromat)

#Plot comparing all vs longest isoform (https://otho.netlify.app/post/2019-02-02-butter-consumption/)
setwd("Isoforms")
data<-fread("eggnog_depth_allvslongest.txt")
data<-fread("deepgoplus_depth_allvslongest.txt")
data<-fread("deepgoplus_threshold_depth_allvslongest.txt")
data<-fread("prott5_allvslongest.txt")
data<-fread("prott5_threshold_allvslongest.txt")
data<-fread("seqvec_allvslongest.txt")
data<-fread("seqvec_threshold_allvslongest.txt")
colnames(data)<-c("Species","All_isoforms","Longest_isoform") #,"Percentage")
#Add steps for factoring by phylum
metadata<-fread("Taxon_list_subset.tsv",header=TRUE, sep="\t")
data<-inner_join(data,metadata,by=c("Species"="CODE (5 letter code)"))
#Remove outgroups
data<-data[data$PHYLUM!="Outgroup",]
#sort by phylum

phyla_order<-c("CTENOPHORA","PORIFERA","PLACOZOA","CNIDARIA","XENOTURBELLIDA","ACOELA","NEMERTODERMATIDA","ECHINODERMATA","HEMICHORDATA","CEPHALOCHORDATA","UROCHORDATA","CRANIATA","KINORHYNCHA","PRIAPULIDA","NEMATODA","NEMATOMORPHA","TARDIGRADA","ONYCHOPHORA","ARTHROPODA","CHAETOGNATHA","ROTIFERA","MICROGNATHOZOA","DICYEMIDA","GASTROTRICHA","PLATYHELMINTHES","BRYOZOA","ENTOPROCTA","CYCLIOPHORA","MOLLUSCA","ANNELIDA","NEMERTEA","BRACHIOPODA","PHORONIDA")
levels(data$PHYLUM)<-phyla_order
data<-data %>% mutate(Proportion_all_isoforms=All_isoforms/No_GENES, Proportion_longest_isoform=Longest_isoform/No_GENES, Percentage=All_isoforms/Longest_isoform
                      *100-100)

tree <- read.tree("subset_all_isoforms_tree_no_outgroup.nwk")

p<-ggtree(tree, branch.length="none",size=1)+
  geom_facet(panel = "Program", data = data, geom = geom_bar, 
             aes(x = Percentage, color = PHYLUM), stat="identity", orientation = 'y')+
            #aes(x = Percentage, fill = Percentage), stat="identity", orientation = 'y')+
  scale_x_continuous(limits = c(-25,45),breaks=c(-25,-20,-15,-10,-5,0,5,10,15,20,25))+
  theme_pubr()+
  theme(legend.position="right",legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), strip.background = element_blank(),axis.text.x = element_text(size=10))+
  #scale_fill_scico(palette = "acton", direction = -1)+
  scale_color_scico_d(palette = "batlow")+
  geom_vline(xintercept=5,linetype=2,color="grey70")+
  geom_vline(xintercept=10,linetype=2,color="grey70")+
  geom_vline(xintercept=15,linetype=2,color="grey70")+
  geom_vline(xintercept=20,linetype=2,color="grey70")+
  geom_vline(xintercept=25,linetype=2,color="grey70")+
  geom_vline(xintercept=-5,linetype=2,color="grey70")+
  geom_vline(xintercept=-10,linetype=2,color="grey70")+
  geom_vline(xintercept=-15,linetype=2,color="grey70")+
  geom_vline(xintercept=-20,linetype=2,color="grey70")+
  geom_vline(xintercept=-25,linetype=2,color="grey70")+
  labs(x = "Relative percentage change of annotated genes")

p<- p %<+% data+geom_tippoint(aes(color=PHYLUM))+
  scale_color_scico_d(palette = "batlow")#+
  #geom_tiplab(aes(image=uuid, colour=PHYLUM), geom="phylopic", size=0.005)

pdf("dif_perc_eggnog_depth.pdf", width=12,height=6)
facet_labeller(p, c(Tree = "", 'Program' = "EggNOG-mapper"))#+
#theme(aspect.ratio = 9/3)
dev.off()
pdf("dif_perc_deepgoplus_depth.pdf", width=12,height=6)
facet_labeller(p, c(Tree = "", 'Program' = "DeepGOPlus"))#+
dev.off()
pdf("dif_perc_deepgoplus_threshold_depth.pdf", width=12,height=6)
facet_labeller(p, c(Tree = "", 'Program' = "DeepGOPlus"))#+
dev.off()
pdf("dif_perc_prott5.pdf", width=12,height=6)
facet_labeller(p, c(Tree = "", 'Program' = "GOPredSim-ProtT5"))#+
dev.off()
pdf("dif_perc_prott5_threshold.pdf", width=12,height=6)
facet_labeller(p, c(Tree = "", 'Program' = "GOPredSim-ProtT5"))#+
dev.off()
pdf("dif_perc_seqvec.pdf", width=12,height=6)
facet_labeller(p, c(Tree = "", 'Program' = "GOPredSim-SeqVec"))#+
dev.off()
pdf("dif_perc_seqvec_threshold.pdf", width=12,height=6)
facet_labeller(p, c(Tree = "", 'Program' = "GOPredSim-SeqVec"))#+
dev.off()

#Semantic similarity All vs longest all programs GO categories
data_semsim<-fread("semsim_allvslong_go_cat.txt")
colnames(data_semsim)<-c("Gene","Semantic_similarity","Ont","Program")
data_semsim$Semantic_similarity<-as.numeric(data_semsim$Semantic_similarity)
data_semsim$Program<-factor(data_semsim$Program, levels = c("eggnog-mapper","deepgoplus","gopredsim_prott5","gopredsim_seqvec"))
levels(data_semsim$Program) <- c("EggNOG-mapper", "DeepGOPlus","GOPredSim\nProtT5", "GOPredSim\nSeqvec")
data_semsim$Ont<-factor(data_semsim$Ont, levels = c("biological_process","molecular_function","cellular_component"))
levels(data_semsim$Ont) <- c("Biological Process", "Molecular Function","Cellular Component")
pdf("semsim_allvslongest_go_cat.pdf", width=11,height=6)
ggplot(data=data_semsim)+
  stat_ecdf(mapping=aes(x = Semantic_similarity,color = Program), 
            geom = "step", size = 1.5)+
  theme_pubr()+
  facet_wrap(.~Ont)+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        legend.position="right",
        strip.background = element_blank(),
        strip.text=element_text(size=10, face = "bold"))+
  labs(x = "Semantic similarity",y="Cumulative frequency")+
  scale_fill_manual(values=c("#FF6E3A","#8400CD","#00C2F9","#008DF9"))+
  scale_colour_manual(values=c("#FF6E3A","#8400CD","#00C2F9","#008DF9"))
dev.off()