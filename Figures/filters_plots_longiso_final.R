# library(tidyverse)
library(scico)
library(data.table)
library(ggplot2)
library(ggpubr)

setwd("filters_plots_dark_proteome")

#########################
#Density plot IC content#
#########################

#Deepgoplus longest BP
setwd("filters_plots_dark_proteome/data")

ic_data<-fread("genes_annotated_ic_longest_deepgoplus_none_bp.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("None",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None"))

p <- ggplot() + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_deepgoplus_depth_bp.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("Depth",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth"))


p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_deepgoplus_threshold_bp.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("RI threshold",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold"))


p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_deepgoplus_threshold_depth_bp.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("RI threshold\n+ Depth",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold","RI threshold\n+ Depth"))

p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

p <- p + theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold",), 
        legend.title = element_text(face = "bold"))+
  scale_colour_manual(values=c("#765985", "#2D204C", "#C36D9A","#D4A6C4"))+
  labs(x = "Information Content",y="Density")


setwd("filters_plots_dark_proteome/results")
pdf("filters_ic_longest_deepgoplus_bp.pdf", width=10,height=6)
p %>% print()
dev.off()


#Deepgoplus longest CC
setwd("filters_plots_dark_proteome/data")

ic_data<-fread("genes_annotated_ic_longest_deepgoplus_none_cc.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("None",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None"))


p <- ggplot() + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_deepgoplus_depth_cc.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("Depth",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth"))


p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_deepgoplus_threshold_cc.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("RI threshold",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold"))


p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_deepgoplus_threshold_depth_cc.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("RI threshold\n+ Depth",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold","RI threshold\n+ Depth"))


p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

p <- p + theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold",), 
        legend.title = element_text(face = "bold"))+
  scale_colour_manual(values=c("#765985", "#2D204C", "#C36D9A","#D4A6C4"))+
  labs(x = "Information Content",y="Density")


setwd("filters_plots_dark_proteome/results")
pdf("filters_ic_longest_deepgoplus_cc.pdf", width=10,height=6)
p %>% print()
dev.off()


#Deepgoplus longest MF
setwd("filters_plots_dark_proteome/data")

ic_data<-fread("genes_annotated_ic_longest_deepgoplus_none_mf.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("None",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None"))


p <- ggplot() + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_deepgoplus_depth_mf.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("Depth",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth"))


p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_deepgoplus_threshold_mf.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("RI threshold",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold"))


p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_deepgoplus_threshold_depth_mf.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("RI threshold\n+ Depth",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth","RI threshold","RI threshold\n+ Depth"))


p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

p <- p + theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold",), 
        legend.title = element_text(face = "bold"))+
  scale_colour_manual(values=c("#765985", "#2D204C", "#C36D9A","#D4A6C4"))+
  labs(x = "Information Content",y="Density")


setwd("filters_plots_dark_proteome/results")
pdf("filters_ic_longest_deepgoplus_mf.pdf", width=10,height=6)
p %>% print()
dev.off()


#Eggnog longest BP
setwd("filters_plots_dark_proteome/data")

ic_data<-fread("genes_annotated_ic_longest_eggnog_none_bp.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("None",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None"))


p <- ggplot() + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_eggnog_depth_bp.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("Depth",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth"))


p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

p <- p + theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold",), 
        legend.title = element_text(face = "bold"))+
  scale_colour_manual(values=c("#765985", "#2D204C"))+
  labs(x = "Information Content",y="Density")


setwd("filters_plots_dark_proteome/results")
pdf("filters_ic_longest_eggnog_bp.pdf", width=10,height=6)
p %>% print()
dev.off()

#Eggnog longest CC
setwd("filters_plots_dark_proteome/data")

ic_data<-fread("genes_annotated_ic_longest_eggnog_none_cc.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("None",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None"))


p <- ggplot() + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_eggnog_depth_cc.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("Depth",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth"))


p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

p <- p + theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold",), 
        legend.title = element_text(face = "bold"))+
  scale_colour_manual(values=c("#765985", "#2D204C"))+
  labs(x = "Information Content",y="Density")


setwd("filters_plots_dark_proteome/results")
pdf("filters_ic_longest_eggnog_cc.pdf", width=10,height=6)
p %>% print()
dev.off()

#Eggnog longest MF
setwd("filters_plots_dark_proteome/data")

ic_data<-fread("genes_annotated_ic_longest_eggnog_none_mf.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("None",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None"))


p <- ggplot() + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_eggnog_depth_mf.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("Depth",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "Depth"))


p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

p <- p + theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold",), 
        legend.title = element_text(face = "bold"))+
  scale_colour_manual(values=c("#765985", "#2D204C"))+
  labs(x = "Information Content",y="Density")


setwd("filters_plots_dark_proteome/results")
pdf("filters_ic_longest_eggnog_mf.pdf", width=10,height=6)
p %>% print()
dev.off()

#GOPredSim-prott5 longest BP
setwd("filters_plots_dark_proteome/data")

ic_data<-fread("genes_annotated_ic_longest_gopredsim_prott5_none_bp.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("None",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None"))


p <- ggplot() + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_gopredsim_prott5_threshold_bp.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("RI threshold",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "RI threshold"))


p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

p <- p + theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold",), 
        legend.title = element_text(face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#C36D9A"))+
  labs(x = "Information Content",y="Density")


setwd("filters_plots_dark_proteome/results")
pdf("filters_ic_longest_gopredsim_prott5_bp.pdf", width=10,height=6)
p %>% print()
dev.off()


#GOPredSim-prott5 longest CC
setwd("filters_plots_dark_proteome/data")

ic_data<-fread("genes_annotated_ic_longest_gopredsim_prott5_none_cc.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("None",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None"))


p <- ggplot() + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_gopredsim_prott5_threshold_cc.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("RI threshold",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "RI threshold"))


p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

p <- p + theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold",), 
        legend.title = element_text(face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#C36D9A"))+
  labs(x = "Information Content",y="Density")


setwd("filters_plots_dark_proteome/results")
pdf("filters_ic_longest_gopredsim_prott5_cc.pdf", width=10,height=6)
p %>% print()
dev.off()


#GOPredSim-prott5 longest MF
setwd("filters_plots_dark_proteome/data")

ic_data<-fread("genes_annotated_ic_longest_gopredsim_prott5_none_mf.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("None",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None"))


p <- ggplot() + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_gopredsim_prott5_threshold_mf.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("RI threshold",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "RI threshold"))


p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

p <- p + theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold",), 
        legend.title = element_text(face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#C36D9A"))+
  labs(x = "Information Content",y="Density")


setwd("filters_plots_dark_proteome/results")
pdf("filters_ic_longest_gopredsim_prott5_mf.pdf", width=10,height=6)
p %>% print()
dev.off()


#GOPredSim-seqvec longest BP
setwd("filters_plots_dark_proteome/data")

ic_data<-fread("genes_annotated_ic_longest_gopredsim_seqvec_none_bp.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("None",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None"))


p <- ggplot() + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_gopredsim_seqvec_threshold_bp.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("RI threshold",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "RI threshold"))


p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

p <- p + theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold",), 
        legend.title = element_text(face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#C36D9A"))+
  labs(x = "Information Content",y="Density")


setwd("filters_plots_dark_proteome/results")
pdf("filters_ic_longest_gopredsim_seqvec_bp.pdf", width=10,height=6)
p %>% print()
dev.off()


#GOPredSim-seqvec longest CC
setwd("filters_plots_dark_proteome/data")

ic_data<-fread("genes_annotated_ic_longest_gopredsim_seqvec_none_cc.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("None",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None"))


p <- ggplot() + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_gopredsim_seqvec_threshold_cc.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("RI threshold",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "RI threshold"))


p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

p <- p + theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold",), 
        legend.title = element_text(face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#C36D9A"))+
  labs(x = "Information Content",y="Density")


setwd("filters_plots_dark_proteome/results")
pdf("filters_ic_longest_gopredsim_seqvec_cc.pdf", width=10,height=6)
p %>% print()
dev.off()


#GOPredSim-seqvec longest MF
setwd("filters_plots_dark_proteome/data")

ic_data<-fread("genes_annotated_ic_longest_gopredsim_seqvec_none_mf.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("None",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None"))


p <- ggplot() + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

ic_data<-fread("genes_annotated_ic_longest_gopredsim_seqvec_threshold_mf.txt")
colnames(ic_data)<-"Information_content"
ic_data$Filter<-rep("RI threshold",length(ic_data))
ic_data$Information_content<-as.numeric(ic_data$Information_content)
ic_data <- na.omit(ic_data, "Information_content")
ic_data$Filter<-factor(ic_data$Filter, levels = c("None", "RI threshold"))


p <- p + geom_density(data=ic_data, mapping=aes(x = Information_content, color = Filter))

p <- p + theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        strip.background = element_blank(),
        panel.grid.major.y = element_line(colour="grey"),
        strip.text=element_text(size=10, face = "bold",), 
        legend.title = element_text(face = "bold"))+
  scale_colour_manual(values=c("#2D204C","#C36D9A"))+
  labs(x = "Information Content",y="Density")


setwd("filters_plots_dark_proteome/results")
pdf("filters_ic_longest_gopredsim_seqvec_mf.pdf", width=10,height=6)
p %>% print()
dev.off()