library(tidyverse)
library(scico)
library(data.table)
library(ggplot2)
library(ggpubr)

#Plot comparing all vs longest isoform (https://otho.netlify.app/post/2019-02-02-butter-consumption/)
setwd("Filters")
data<-fread("genes_annotated_filters_stats.txt")
colnames(data)<-c("Gene_num","Species","Isoforms","Program","Filter")
data$Filter<-factor(data$Filter, levels = c("None","depth","threshold","threshold_depth"))
levels(data$Filter) <- c("None", "Depth","RI threshold","RI threshold\n+ Depth")

data$Program<-factor(data$Program, levels = c("eggnog","deepgoplus","gopredsim_prott5","gopredsim_seqvec"))
levels(data$Program) <- c("EggNOG-mapper", "DeepGOPlus","GOPredSim\nProtT5", "GOPredSim\nSeqvec")

data$Isoforms<-factor(data$Isoforms, levels = c("all","longest"))
levels(data$Isoforms) <- c("All isoforms", "Longest isoform")


##########################
#Barplot gene proportions#
##########################
df1 <- aggregate(Gene_num ~ Program + Filter + Isoforms, data=data, FUN= 'sum')
df2 <- df1
total_num<-c(rep(2077291,10),rep(23184398,10))
df2<-df2 %>% mutate(Proportion=Gene_num/total_num)

p1<-ggplot(data=df2,aes(x=Program))+
  geom_bar(aes(y=Proportion,fill=Filter),position = position_dodge2(preserve = "single"), stat="identity")+
  facet_grid(Isoforms~., scales="free")+
  scale_fill_manual(values=c("#2D204C","#765985","#C36D9A","#D4A6C4"))+
  theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        strip.text=element_text(size=8, face = "bold"),
        plot.tag.position=c(0.03,0.78),
        plot.tag = element_text(size=12, face="bold", color="#3D3D3D"),
        axis.text = element_text(size = 10))+
  labs(y = "Proportion of annotated genes",x="GO annotation program",fill="Type of filtering")+
  geom_hline(aes(yintercept=-Inf)) + 
  coord_cartesian(clip="off")+
  scale_y_continuous(expand = c(0, 0))

pdf("filters_proportions.pdf", width=6,height=6)
p1 %>% print()
dev.off()

#########################
#Density plot IC content#
#########################
#Deepgoplus All BP
setwd("IC_content")
ic_data_1<-fread("genes_annotated_ic_all_deepgoplus_none_bp.txt")
colnames(ic_data_1)<-"Information_content"
ic_data_1$Filter<-rep("None",length(ic_data_1))
ic_data_2<-fread("genes_annotated_ic_all_deepgoplus_depth_bp.txt")
colnames(ic_data_2)<-"Information_content"
ic_data_2$Filter<-rep("Depth",length(ic_data_2))
ic_data_3<-fread("genes_annotated_ic_all_deepgoplus_threshold_bp.txt")
colnames(ic_data_3)<-"Information_content"
ic_data_3$Filter<-rep("RI threshold",length(ic_data_3))
ic_data_4<-fread("genes_annotated_ic_all_deepgoplus_threshold_depth_bp.txt")
colnames(ic_data_4)<-"Information_content"
ic_data_4$Filter<-rep("RI threshold\n+ Depth",length(ic_data_4))
ic_data<-rbind(ic_data_1,ic_data_2,ic_data_3,ic_data_4)
rm(ic_data_1,ic_data_2,ic_data_3,ic_data_4)
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold","RI threshold\n+ Depth"))

p2<-ggplot(data=ic_data)+geom_density(mapping=aes(x = Information_content, color = Filter), linewidth= 1)+ #, scale = 0.9)+ #To avoid overlapping of plots
  theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#765985","#C36D9A","#D4A6C4"))+
  labs(x = "Information Content",y="Density")

setwd("Filters")
pdf("filters_ic_all_deepgoplus_bp.pdf", width=10,height=6)
p2 %>% print()
dev.off()

#Deepgoplus All CC
setwd("IC_content")
ic_data_1<-fread("genes_annotated_ic_all_deepgoplus_none_cc.txt")
colnames(ic_data_1)<-"Information_content"
ic_data_1$Filter<-rep("None",length(ic_data_1))
ic_data_2<-fread("genes_annotated_ic_all_deepgoplus_depth_cc.txt")
colnames(ic_data_2)<-"Information_content"
ic_data_2$Filter<-rep("Depth",length(ic_data_2))
ic_data_3<-fread("genes_annotated_ic_all_deepgoplus_threshold_cc.txt")
colnames(ic_data_3)<-"Information_content"
ic_data_3$Filter<-rep("RI threshold",length(ic_data_3))
ic_data_4<-fread("genes_annotated_ic_all_deepgoplus_threshold_depth_cc.txt")
colnames(ic_data_4)<-"Information_content"
ic_data_4$Filter<-rep("RI threshold\n+ Depth",length(ic_data_4))
ic_data<-rbind(ic_data_1,ic_data_2,ic_data_3,ic_data_4)
rm(ic_data_1,ic_data_2,ic_data_3,ic_data_4)
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold","RI threshold\n+ Depth"))

p2<-ggplot(data=ic_data)+geom_density(mapping=aes(x = Information_content, color = Filter), linewidth= 1)+ #, scale = 0.9)+ #To avoid overlapping of plots
  theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#765985","#C36D9A","#D4A6C4"))+
  labs(x = "Information Content",y="Density")

setwd("Filters")
pdf("filters_ic_all_deepgoplus_cc.pdf", width=10,height=6)
p2 %>% print()
dev.off()

#Deepgoplus All MF
setwd("IC_content")
ic_data_1<-fread("genes_annotated_ic_all_deepgoplus_none_mf.txt")
colnames(ic_data_1)<-"Information_content"
ic_data_1$Filter<-rep("None",length(ic_data_1))
ic_data_2<-fread("genes_annotated_ic_all_deepgoplus_depth_mf.txt")
colnames(ic_data_2)<-"Information_content"
ic_data_2$Filter<-rep("Depth",length(ic_data_2))
ic_data_3<-fread("genes_annotated_ic_all_deepgoplus_threshold_mf.txt")
colnames(ic_data_3)<-"Information_content"
ic_data_3$Filter<-rep("RI threshold",length(ic_data_3))
ic_data_4<-fread("genes_annotated_ic_all_deepgoplus_threshold_depth_mf.txt")
colnames(ic_data_4)<-"Information_content"
ic_data_4$Filter<-rep("RI threshold\n+ Depth",length(ic_data_4))
ic_data<-rbind(ic_data_1,ic_data_2,ic_data_3,ic_data_4)
rm(ic_data_1,ic_data_2,ic_data_3,ic_data_4)
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold","RI threshold\n+ Depth"))

p2<-ggplot(data=ic_data)+geom_density(mapping=aes(x = Information_content, color = Filter), linewidth= 1)+ #, scale = 0.9)+ #To avoid overlapping of plots
  theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#765985","#C36D9A","#D4A6C4"))+
  labs(x = "Information Content",y="Density")

setwd("Filters")
pdf("filters_ic_all_deepgoplus_mf.pdf", width=10,height=6)
p2 %>% print()
dev.off()

#Eggnog All BP
setwd("IC_content")
ic_data_1<-fread("genes_annotated_ic_all_eggnog_none_bp.txt")
colnames(ic_data_1)<-"Information_content"
ic_data_1$Filter<-rep("None",length(ic_data_1))
ic_data_2<-fread("genes_annotated_ic_all_eggnog_depth_bp.txt")
colnames(ic_data_2)<-"Information_content"
ic_data_2$Filter<-rep("Depth",length(ic_data_2))
ic_data<-rbind(ic_data_1,ic_data_2)
rm(ic_data_1,ic_data_2)
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold","RI threshold\n+ Depth"))

p2<-ggplot(data=ic_data)+geom_density(mapping=aes(x = Information_content, color = Filter), linewidth= 1)+ #, scale = 0.9)+ #To avoid overlapping of plots
  theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#765985"))+
  labs(x = "Information Content",y="Density")

setwd("Filters")
pdf("filters_ic_all_eggnog_bp.pdf", width=10,height=6)
p2 %>% print()
dev.off()

#Eggnog All CC
setwd("IC_content")
ic_data_1<-fread("genes_annotated_ic_all_eggnog_none_cc.txt")
colnames(ic_data_1)<-"Information_content"
ic_data_1$Filter<-rep("None",length(ic_data_1))
ic_data_2<-fread("genes_annotated_ic_all_eggnog_depth_cc.txt")
colnames(ic_data_2)<-"Information_content"
ic_data_2$Filter<-rep("Depth",length(ic_data_2))
ic_data<-rbind(ic_data_1,ic_data_2)
rm(ic_data_1,ic_data_2)
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold","RI threshold\n+ Depth"))

p2<-ggplot(data=ic_data)+geom_density(mapping=aes(x = Information_content, color = Filter), linewidth= 1)+ #, scale = 0.9)+ #To avoid overlapping of plots
  theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#765985"))+
  labs(x = "Information Content",y="Density")

setwd("Filters")
pdf("filters_ic_all_eggnog_cc.pdf", width=10,height=6)
p2 %>% print()
dev.off()

#Eggnog All MF
setwd("IC_content")
ic_data_1<-fread("genes_annotated_ic_all_eggnog_none_mf.txt")
colnames(ic_data_1)<-"Information_content"
ic_data_1$Filter<-rep("None",length(ic_data_1))
ic_data_2<-fread("genes_annotated_ic_all_eggnog_depth_mf.txt")
colnames(ic_data_2)<-"Information_content"
ic_data_2$Filter<-rep("Depth",length(ic_data_2))
ic_data<-rbind(ic_data_1,ic_data_2)
rm(ic_data_1,ic_data_2)
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold","RI threshold\n+ Depth"))

p2<-ggplot(data=ic_data)+geom_density(mapping=aes(x = Information_content, color = Filter), linewidth= 1)+ #, scale = 0.9)+ #To avoid overlapping of plots
  theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#765985"))+
  labs(x = "Information Content",y="Density")

setwd("Filters")
pdf("filters_ic_all_eggnog_mf.pdf", width=10,height=6)
p2 %>% print()
dev.off()

#GOPredSim-prott5 All BP
setwd("IC_content")
ic_data_1<-fread("genes_annotated_ic_all_gopredsim_prott5_none_bp.txt")
colnames(ic_data_1)<-"Information_content"
ic_data_1$Filter<-rep("None",length(ic_data_1))
ic_data_2<-fread("genes_annotated_ic_all_gopredsim_prott5_threshold_bp.txt")
colnames(ic_data_2)<-"Information_content"
ic_data_2$Filter<-rep("RI threshold",length(ic_data_2))
ic_data<-rbind(ic_data_1,ic_data_2)
rm(ic_data_1,ic_data_2)
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold","RI threshold\n+ Depth"))

p2<-ggplot(data=ic_data)+geom_density(mapping=aes(x = Information_content, color = Filter), linewidth= 1)+ #, scale = 0.9)+ #To avoid overlapping of plots
  theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#C36D9A"))+
  labs(x = "Information Content",y="Density")

setwd("Filters")
pdf("filters_ic_all_gopredsim_prott5_bp.pdf", width=10,height=6)
p2 %>% print()
dev.off()

#GOPredSim-prott5 All CC
setwd("IC_content")
ic_data_1<-fread("genes_annotated_ic_all_gopredsim_prott5_none_cc.txt")
colnames(ic_data_1)<-"Information_content"
ic_data_1$Filter<-rep("None",length(ic_data_1))
ic_data_2<-fread("genes_annotated_ic_all_gopredsim_prott5_threshold_cc.txt")
colnames(ic_data_2)<-"Information_content"
ic_data_2$Filter<-rep("RI threshold",length(ic_data_2))
ic_data<-rbind(ic_data_1,ic_data_2)
rm(ic_data_1,ic_data_2)
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold","RI threshold\n+ Depth"))

p2<-ggplot(data=ic_data)+geom_density(mapping=aes(x = Information_content, color = Filter), linewidth= 1)+ #, scale = 0.9)+ #To avoid overlapping of plots
  theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#C36D9A"))+
  labs(x = "Information Content",y="Density")

setwd("Filters")
pdf("filters_ic_all_gopredsim_prott5_cc.pdf", width=10,height=6)
p2 %>% print()
dev.off()

#GOPredSim-prott5 All MF
setwd("IC_content")
ic_data_1<-fread("genes_annotated_ic_all_gopredsim_prott5_none_mf.txt")
colnames(ic_data_1)<-"Information_content"
ic_data_1$Filter<-rep("None",length(ic_data_1))
ic_data_2<-fread("genes_annotated_ic_all_gopredsim_prott5_threshold_mf.txt")
colnames(ic_data_2)<-"Information_content"
ic_data_2$Filter<-rep("RI threshold",length(ic_data_2))
ic_data<-rbind(ic_data_1,ic_data_2)
rm(ic_data_1,ic_data_2)
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold","RI threshold\n+ Depth"))

p2<-ggplot(data=ic_data)+geom_density(mapping=aes(x = Information_content, color = Filter), linewidth= 1)+ #, scale = 0.9)+ #To avoid overlapping of plots
  theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#C36D9A"))+
  labs(x = "Information Content",y="Density")

setwd("Filters")
pdf("filters_ic_all_gopredsim_prott5_mf.pdf", width=10,height=6)
p2 %>% print()
dev.off()

#GOPredSim-seqvec All BP
setwd("IC_content")
ic_data_1<-fread("genes_annotated_ic_all_gopredsim_seqvec_none_bp.txt")
colnames(ic_data_1)<-"Information_content"
ic_data_1$Filter<-rep("None",length(ic_data_1))
ic_data_2<-fread("genes_annotated_ic_all_gopredsim_seqvec_threshold_bp.txt")
colnames(ic_data_2)<-"Information_content"
ic_data_2$Filter<-rep("RI threshold",length(ic_data_2))
ic_data<-rbind(ic_data_1,ic_data_2)
rm(ic_data_1,ic_data_2)
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold","RI threshold\n+ Depth"))

p2<-ggplot(data=ic_data)+geom_density(mapping=aes(x = Information_content, color = Filter), linewidth= 1)+ #, scale = 0.9)+ #To avoid overlapping of plots
  theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#C36D9A"))+
  labs(x = "Information Content",y="Density")

setwd("Filters")
pdf("filters_ic_all_gopredsim_seqvec_bp.pdf", width=10,height=6)
p2 %>% print()
dev.off()

#GOPredSim-seqvec All CC
setwd("IC_content")
ic_data_1<-fread("genes_annotated_ic_all_gopredsim_seqvec_none_cc.txt")
colnames(ic_data_1)<-"Information_content"
ic_data_1$Filter<-rep("None",length(ic_data_1))
ic_data_2<-fread("genes_annotated_ic_all_gopredsim_seqvec_threshold_cc.txt")
colnames(ic_data_2)<-"Information_content"
ic_data_2$Filter<-rep("RI threshold",length(ic_data_2))
ic_data<-rbind(ic_data_1,ic_data_2)
rm(ic_data_1,ic_data_2)
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold","RI threshold\n+ Depth"))

p2<-ggplot(data=ic_data)+geom_density(mapping=aes(x = Information_content, color = Filter), linewidth= 1)+ #, scale = 0.9)+ #To avoid overlapping of plots
  theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#C36D9A"))+
  labs(x = "Information Content",y="Density")

setwd("Filters")
pdf("filters_ic_all_gopredsim_seqvec_cc.pdf", width=10,height=6)
p2 %>% print()
dev.off()

#GOPredSim-seqvec All MF
setwd("IC_content")
ic_data_1<-fread("genes_annotated_ic_all_gopredsim_seqvec_none_mf.txt")
colnames(ic_data_1)<-"Information_content"
ic_data_1$Filter<-rep("None",length(ic_data_1))
ic_data_2<-fread("genes_annotated_ic_all_gopredsim_seqvec_threshold_mf.txt")
colnames(ic_data_2)<-"Information_content"
ic_data_2$Filter<-rep("RI threshold",length(ic_data_2))
ic_data<-rbind(ic_data_1,ic_data_2)
rm(ic_data_1,ic_data_2)
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold","RI threshold\n+ Depth"))

p2<-ggplot(data=ic_data)+geom_density(mapping=aes(x = Information_content, color = Filter), linewidth= 1)+ #, scale = 0.9)+ #To avoid overlapping of plots
  theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#C36D9A"))+
  labs(x = "Information Content",y="Density")

setwd("Filters")
pdf("filters_ic_all_gopredsim_seqvec_mf.pdf", width=10,height=6)
p2 %>% print()
dev.off()


###############################################
#Plot comparing number of GO terms/gene/GO cat#
###############################################

setwd("Filters")
data<-fread("go_per_gene_filters_stats_go_cat.txt")
colnames(data)<-c("GO_per_gene","Gene","Ont","Isoforms","Program","Filter")
data[is.na(data$Filter),"Filter"]<-"None"
data$Filter<-factor(data$Filter, levels = c("None","depth","threshold","threshold_depth"))
levels(data$Filter) <- c("None", "Depth","RI threshold","RI threshold\n+ Depth")
data$Program<-factor(data$Program, levels = c("eggnog","deepgoplus","gopredsim_prott5","gopredsim_seqvec"))
levels(data$Program) <- c("EggNOG-mapper", "DeepGOPlus","GOPredSim\nProtT5", "GOPredSim\nSeqvec")
data$Ont<-factor(data$Ont, levels=c("biological_process","molecular_function","cellular_component"))
levels(data$Ont) <-c("Biological Process","Molecular Function","Cellular Component")

data$Isoforms<-factor(data$Isoforms, levels = c("all","longest"))
levels(data$Isoforms) <- c("All isoforms", "Longest isoform")

data<-data[data$Program %in% c("EggNOG-mapper","GOPredSim\nProtT5")]

pdf("total_gos_per_cat.pdf", width=12,height=6)
ggplot(data=data,aes(x=Filter,y=GO_per_gene))+
  geom_boxplot(aes(fill=Filter, color=Filter))+
  theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        legend.position="right",
        strip.background = element_blank(),
        strip.text=element_text(size=10, face = "bold"),
        axis.text= element_text(size=8))+
  labs(y = "Number of GO per gene",x="Filter")+
  scale_fill_manual(values=c("#2D204C","#765985","#C36D9A","#D4A6C4"),drop=TRUE)+
  scale_colour_manual(values=c("#0f0a1c","#362440","#703855","#855e77"))+
  facet_grid(Ont~Program, scales="free")
dev.off()

#Stats
maxRows <- by(data[data$Program=="EggNOG-mapper",], data[data$Program=="EggNOG-mapper","Ont"], function(X) X[which.max(X$GO_per_gene),])
do.call("rbind", maxRows)
maxRows <- by(data[data$Program=="DeepGOPlus",], data[data$Program=="DeepGOPlus","Ont"], function(X) X[which.max(X$GO_per_gene),])
do.call("rbind", maxRows)
maxRows <- by(data[data$Program=="GOPredSim\nProtT5",], data[data$Program=="GOPredSim\nProtT5","Ont"], function(X) X[which.max(X$GO_per_gene),])
do.call("rbind", maxRows)
maxRows <- by(data[data$Program=="GOPredSim\nSeqvec",], data[data$Program=="GOPredSim\nSeqvec","Ont"], function(X) X[which.max(X$GO_per_gene),])
do.call("rbind", maxRows)
