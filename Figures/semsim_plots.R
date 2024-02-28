library(tidyverse)
library(scico)
library(rphylopic)
library(data.table)
library(ggplot2)
library(ggpubr)
library(ggtree)
library(grafify)
library(ggridges)
library(ggsignif)
library(see)
library(stringr)

setwd("Semantic_similarity")

#Semantic similarity Longest isoforms eggnog vs deepgoplus, eggnog vs prott5, eggnog vs seqvec separated by GO categories
data_semsim_deepgoplus<-fread("Longest_semsim_eggnog_depth_deepgoplus_threshold_depth_go_category.txt")
colnames(data_semsim_deepgoplus)<-c("Gene","Semantic_similarity","GO_category")
data_semsim_deepgoplus$Method<-"EggNOG-mapper vs DeepGOPlus"
data_semsim_prott5<-fread("Longest_semsim_eggnog_depth_prott5_threshold_go_category.txt")
colnames(data_semsim_prott5)<-c("Gene","Semantic_similarity","GO_category")
data_semsim_prott5$Method<-"EggNOG-mapper vs GOPredSim-ProtT5"
data_semsim_seqvec<-fread("Longest_semsim_eggnog_depth_seqvec_threshold_go_category.txt")
colnames(data_semsim_seqvec)<-c("Gene","Semantic_similarity","GO_category")
data_semsim_seqvec$Method<-"EggNOG-mapper vs GOPredSim-SeqVec"
common_genes<-intersect(data_semsim_deepgoplus$Gene,data_semsim_prott5$Gene) %>% intersect(data_semsim_seqvec$Gene) %>% unique()
data_semsim<-rbind(data_semsim_deepgoplus,data_semsim_prott5,data_semsim_seqvec)
data_semsim$Semantic_similarity<-as.numeric(data_semsim$Semantic_similarity)
data_semsim$GO_category<-factor(data_semsim$GO_category,levels=c("BP","MF","CC"))
data_semsim<-data_semsim[data_semsim$Gene%in%common_genes,]

#Plot without subset genes
pdf("Semantic_similarity_GO_category.pdf", width=15,height=5)
ggplot(data_semsim,aes(x=Method, y =Semantic_similarity))+
  geom_violin(aes(fill=Method),alpha=0.9,size=1,color="NA",scale = "count")+
  geom_boxplot(width=0.1,size=1,color="black")+
  theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        legend.position="none",
        strip.background = element_blank(),
        strip.text=element_text(size=10, face = "bold"),
        axis.text=element_text(size=10))+
  scale_fill_manual(values=c("#8400CD","#00C2F9","#008DF9"))+
  facet_grid(.~GO_category)+
  labs(y = "Semantic similarity",x="")+
  scale_x_discrete(labels=c("EggNOG-mapper\nvs\nDeepGoPlus", "EggNOG-mapper\nvs\nGOPredSim-ProtT5", "EggNOG-mapper\nvs\nGOPredSim-SeqVec"))
dev.off()

#Plot with subset genes
set.seed(1234)
sample_genes<-sample(unique(data_semsim$Gene),100)

pdf("Semantic_similarity_GO_category_subset.pdf", width=15,height=5)
ggplot(data_semsim,aes(x=Method, y =Semantic_similarity))+
  geom_violin(aes(fill=Method),alpha=0.9,size=1,color="NA",scale = "count")+
  geom_boxplot(width=0.1,size=1,color="black")+
  theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        legend.position="none",
        strip.background = element_blank(),
        strip.text=element_text(size=10, face = "bold"),
        axis.text=element_text(size=10))+
  scale_fill_manual(values=c("#8400CD","#00C2F9","#008DF9"))+
  facet_grid(.~GO_category)+
  labs(y = "Semantic similarity",x="")+
  scale_x_discrete(labels=c("EggNOG-mapper\nvs\nDeepGoPlus", "EggNOG-mapper\nvs\nGOPredSim-ProtT5", "EggNOG-mapper\nvs\nGOPredSim-SeqVec"))+
  geom_line(data=data_semsim[data_semsim$Gene%in%sample_genes,],aes(group = factor(Gene)),
            colour = "black", alpha = 0.5, 
            size = (20/1.5)/22)+
  geom_point(data=data_semsim[data_semsim$Gene%in%sample_genes,],
             size = 1, 
             stroke = 20/22,
             alpha = 1, 
             position = position_dodge(width = 0.1),
             shape = 19)
dev.off()

#See differences between same genes
data_semsim_combined<-inner_join(data_semsim_deepgoplus,data_semsim_prott5, by=c("Gene","GO_category")) %>% inner_join(data_semsim_seqvec, by=c("Gene","GO_category"))
data_semsim_combined<-data_semsim_combined[data_semsim_combined$Gene%in%common_genes,]

data_semsim_combined$Semantic_similarity.x<-as.numeric(data_semsim_combined$Semantic_similarity.x)
data_semsim_combined$Semantic_similarity.y<-as.numeric(data_semsim_combined$Semantic_similarity.y)
data_semsim_combined$Semantic_similarity<-as.numeric(data_semsim_combined$Semantic_similarity)
data_semsim_combined$prott5_vs_deepgoplus<-data_semsim_combined$Semantic_similarity.y-data_semsim_combined$Semantic_similarity.x
data_semsim_combined$prott5_vs_seqvec<-data_semsim_combined$Semantic_similarity.y-data_semsim_combined$Semantic_similarity
data_semsim_combined<-data_semsim_combined %>% select(c(Gene,prott5_vs_deepgoplus,prott5_vs_seqvec))
data_semsim_combined<-melt(data_semsim_combined, id.vars = "Gene", variable.name = "Comparison")

pdf("Difference_in_semantic_similarity_same_gene.pdf", width=5,height=5)
ggplot(data_semsim_combined,aes(x=Comparison, y =value))+
  geom_violin(aes(fill=Comparison),alpha=0.9,size=1,color="NA",scale = "count")+
  geom_boxplot(width=0.05,size=0.5,color="black",outlier.alpha = 0.05,outlier.size=0.05)+
  geom_signif(comparisons = list(c("prott5_vs_deepgoplus", "prott5_vs_seqvec")), map_signif_level=c("***"=0.001,"**"=0.01, "*"=0.05, " "=2))+
  theme_pubr()+
  theme(legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"),
        legend.position="none",
        strip.background = element_blank(),
        strip.text=element_text(size=10, face = "bold"),
        axis.text=element_text(size=10))+
  scale_fill_manual(values=c("#8400CD","#008DF9"))
dev.off()

#Plot relationship IC and semsim
#DeepGOPlus
ic_deepgoplus<-fread("deepgoplus_IC_for_semsim.txt")
colnames(ic_deepgoplus)<-c("Gene","GO_category","IC_deepgoplus")
ic_deepgoplus$IC_deepgoplus<-as.double(ic_deepgoplus$IC_deepgoplus)
ic_deepgoplus<-ic_deepgoplus[!is.na(ic_deepgoplus$IC_deepgoplus),]
ic_deepgoplus_bp<-ic_deepgoplus %>% filter(GO_category=="BP") %>% group_by(Gene) %>% summarise(IC_deepgoplus=mean(IC_deepgoplus))
ic_deepgoplus_mf<-ic_deepgoplus %>% filter(GO_category=="MF") %>% group_by(Gene) %>% summarise(IC_deepgoplus=mean(IC_deepgoplus))
ic_deepgoplus_cc<-ic_deepgoplus %>% filter(GO_category=="CC") %>% group_by(Gene) %>% summarise(IC_deepgoplus=mean(IC_deepgoplus))
ic_eggnog<-fread("eggnog_IC_for_semsim.txt")
colnames(ic_eggnog)<-c("Gene","GO_category","IC_eggnog")
ic_eggnog$IC_eggnog<-as.double(ic_eggnog$IC_eggnog)
ic_eggnog<-ic_eggnog[!is.na(ic_eggnog$IC_eggnog),]
ic_eggnog_bp<-ic_eggnog %>% filter(GO_category=="BP") %>% group_by(Gene) %>% summarise(IC_eggnog=mean(IC_eggnog))
ic_eggnog_mf<-ic_eggnog %>% filter(GO_category=="MF") %>% group_by(Gene) %>% summarise(IC_eggnog=mean(IC_eggnog))
ic_eggnog_cc<-ic_eggnog %>% filter(GO_category=="CC") %>% group_by(Gene) %>% summarise(IC_eggnog=mean(IC_eggnog))

ic_dp_bp<-inner_join(ic_deepgoplus_bp,ic_eggnog_bp, by="Gene")
ic_dp_mf<-inner_join(ic_deepgoplus_mf,ic_eggnog_mf, by="Gene")
ic_dp_cc<-inner_join(ic_deepgoplus_cc,ic_eggnog_cc, by="Gene")

semsim_ic_dp_bp<-data_semsim %>% filter(Method=="EggNOG-mapper vs DeepGOPlus",GO_category=="BP") %>% inner_join(ic_dp_bp,by="Gene")
semsim_ic_dp_mf<-data_semsim %>% filter(Method=="EggNOG-mapper vs DeepGOPlus",GO_category=="MF") %>% inner_join(ic_dp_mf,by="Gene")
semsim_ic_dp_cc<-data_semsim %>% filter(Method=="EggNOG-mapper vs DeepGOPlus",GO_category=="CC") %>% inner_join(ic_dp_cc,by="Gene")

cor.test(abs(semsim_ic_dp_bp$IC_deepgoplus-semsim_ic_dp_bp$IC_eggnog),semsim_ic_dp_bp$Semantic_similarity)

pdf("IC_eggnog_deepgoplus_semsim_bp.pdf", width=5,height=5)
ggplot(semsim_ic_dp_bp,aes(x=IC_eggnog,y=IC_deepgoplus,color=Semantic_similarity))+
  geom_point()+
  scale_color_scico(palette = "acton",direction=-1)+
  theme_pubr()+
  theme(legend.title.align=0.5,
        legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), 
        strip.background = element_blank(), strip.text=element_text(size=8, face = "bold"),
        plot.tag.position=c(0.03,0.78), 
        plot.tag = element_text(size=12, face="bold", color="#3D3D3D"), 
        axis.text = element_text(size = 8), 
        legend.position="right")+
  xlab("IC EggNOG-mapper")+
  ylab("IC DeepGOPlus")
dev.off()

pdf("IC_eggnog_deepgoplus_semsim_mf.pdf", width=5,height=5)
ggplot(semsim_ic_dp_mf,aes(x=IC_eggnog,y=IC_deepgoplus,color=Semantic_similarity))+
  geom_point()+
  scale_color_scico(palette = "acton",direction=-1)+
  theme_pubr()+
  theme(legend.title.align=0.5,
        legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), 
        strip.background = element_blank(), strip.text=element_text(size=8, face = "bold"),
        plot.tag.position=c(0.03,0.78), 
        plot.tag = element_text(size=12, face="bold", color="#3D3D3D"), 
        axis.text = element_text(size = 8), 
        legend.position="right")+
  xlab("IC EggNOG-mapper")+
  ylab("IC DeepGOPlus")
dev.off()

pdf("IC_eggnog_deepgoplus_semsim_cc.pdf", width=5,height=5)
ggplot(semsim_ic_dp_cc,aes(x=IC_eggnog,y=IC_deepgoplus,color=Semantic_similarity))+
  geom_point()+
  scale_color_scico(palette = "acton",direction=-1)+
  theme_pubr()+
  theme(legend.title.align=0.5,
        legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), 
        strip.background = element_blank(), strip.text=element_text(size=8, face = "bold"),
        plot.tag.position=c(0.03,0.78), 
        plot.tag = element_text(size=12, face="bold", color="#3D3D3D"), 
        axis.text = element_text(size = 8), 
        legend.position="right")+
  xlab("IC EggNOG-mapper")+
  ylab("IC DeepGOPlus")
dev.off()

#Boxplot with quantile Semsim
semsim_ic_dp_bp_quant <- melt(data = semsim_ic_dp_bp, 
                   id.vars = c("Semantic_similarity","Gene"), 
                   measure.vars = c("IC_deepgoplus","IC_eggnog"),
                   variable.name = "Program", 
                   value.name = "IC")
quantile_values<-quantile(semsim_ic_dp_bp_quant$Semantic_similarity, na.rm=TRUE)
semsim_ic_dp_bp_quant<-semsim_ic_dp_bp_quant %>% mutate(Quantile=case_when(Semantic_similarity <= quantile_values[2] ~ paste0(quantile_values[1],"-",quantile_values[2]), Semantic_similarity <= quantile_values[3] & Semantic_similarity > quantile_values[2]  ~ paste0(quantile_values[2],"-",quantile_values[3]),Semantic_similarity <= quantile_values[4] & Semantic_similarity > quantile_values[3]  ~ paste0(quantile_values[3],"-",quantile_values[4]), Semantic_similarity > quantile_values[4]  ~ paste0(quantile_values[4],"-",quantile_values[5])))
pdf("IC_eggnog_deepgoplus_semsim_boxplot_bp.pdf", width=5,height=5)
ggplot(semsim_ic_dp_bp_quant,aes(x=Quantile,y=IC,fill=Program,color=Program))+
  geom_boxplot()+
  scale_fill_manual(values=c("#FF6E3A","#8400CD"))+
  scale_color_manual(values=c("#8c3718","#3e0061"))+
  theme_pubr()+
  theme(legend.title.align=0.5,
        legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), 
        strip.background = element_blank(), strip.text=element_text(size=8, face = "bold"),
        plot.tag.position=c(0.03,0.78), 
        plot.tag = element_text(size=12, face="bold", color="#3D3D3D"), 
        axis.text = element_text(size = 8), 
        legend.position="right")+
  xlab("Semantic similarity")
dev.off()

semsim_ic_dp_mf_quant <- melt(data = semsim_ic_dp_mf, 
                              id.vars = c("Semantic_similarity","Gene"), 
                              measure.vars = c("IC_deepgoplus","IC_eggnog"),
                              variable.name = "Program", 
                              value.name = "IC")
quantile_values<-quantile(semsim_ic_dp_mf_quant$Semantic_similarity, na.rm=TRUE)
semsim_ic_dp_mf_quant<-semsim_ic_dp_mf_quant %>% mutate(Quantile=case_when(Semantic_similarity <= quantile_values[2] ~ paste0(quantile_values[1],"-",quantile_values[2]), Semantic_similarity <= quantile_values[3] & Semantic_similarity > quantile_values[2]  ~ paste0(quantile_values[2],"-",quantile_values[3]),Semantic_similarity <= quantile_values[4] & Semantic_similarity > quantile_values[3]  ~ paste0(quantile_values[3],"-",quantile_values[4]), Semantic_similarity > quantile_values[4]  ~ paste0(quantile_values[4],"-",quantile_values[5])))
pdf("IC_eggnog_deepgoplus_semsim_boxplot_mf.pdf", width=5,height=5)
ggplot(semsim_ic_dp_mf_quant,aes(x=Quantile,y=IC,fill=Program,color=Program))+
  geom_boxplot()+
  scale_fill_manual(values=c("#FF6E3A","#8400CD"))+
  scale_color_manual(values=c("#8c3718","#3e0061"))+
  theme_pubr()+
  theme(legend.title.align=0.5,
        legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), 
        strip.background = element_blank(), strip.text=element_text(size=8, face = "bold"),
        plot.tag.position=c(0.03,0.78), 
        plot.tag = element_text(size=12, face="bold", color="#3D3D3D"), 
        axis.text = element_text(size = 8), 
        legend.position="right")+
  xlab("Semantic similarity")
dev.off()

semsim_ic_dp_cc_quant <- melt(data = semsim_ic_dp_cc, 
                              id.vars = c("Semantic_similarity","Gene"), 
                              measure.vars = c("IC_deepgoplus","IC_eggnog"),
                              variable.name = "Program", 
                              value.name = "IC")
quantile_values<-quantile(semsim_ic_dp_cc_quant$Semantic_similarity, na.rm=TRUE)
semsim_ic_dp_cc_quant<-semsim_ic_dp_cc_quant %>% mutate(Quantile=case_when(Semantic_similarity <= quantile_values[2] ~ paste0(quantile_values[1],"-",quantile_values[2]), Semantic_similarity <= quantile_values[3] & Semantic_similarity > quantile_values[2]  ~ paste0(quantile_values[2],"-",quantile_values[3]),Semantic_similarity <= quantile_values[4] & Semantic_similarity > quantile_values[3]  ~ paste0(quantile_values[3],"-",quantile_values[4]), Semantic_similarity > quantile_values[4]  ~ paste0(quantile_values[4],"-",quantile_values[5])))
pdf("IC_eggnog_deepgoplus_semsim_boxplot_cc.pdf", width=5,height=5)
ggplot(semsim_ic_dp_cc_quant,aes(x=Quantile,y=IC,fill=Program,color=Program))+
  geom_boxplot()+
  scale_fill_manual(values=c("#FF6E3A","#8400CD"))+
  scale_color_manual(values=c("#8c3718","#3e0061"))+
  theme_pubr()+
  theme(legend.title.align=0.5,
        legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), 
        strip.background = element_blank(), strip.text=element_text(size=8, face = "bold"),
        plot.tag.position=c(0.03,0.78), 
        plot.tag = element_text(size=12, face="bold", color="#3D3D3D"), 
        axis.text = element_text(size = 8), 
        legend.position="right")+
  xlab("Semantic similarity")
dev.off()

#Prott5
ic_prott5<-fread("prott5_IC_for_semsim_bp.txt")
colnames(ic_prott5)<-c("Gene","GO_category","IC_prott5")
ic_prott5$IC_prott5<-as.double(ic_prott5$IC_prott5)
ic_prott5<-ic_prott5[!is.na(ic_prott5$IC_prott5),]
ic_prott5_bp<-ic_prott5 %>% filter(GO_category=="BP") %>% group_by(Gene) %>% summarise(IC_prott5=mean(IC_prott5))
ic_prott5_mf<-ic_prott5 %>% filter(GO_category=="MF") %>% group_by(Gene) %>% summarise(IC_prott5=mean(IC_prott5))
ic_prott5_cc<-ic_prott5 %>% filter(GO_category=="CC") %>% group_by(Gene) %>% summarise(IC_prott5=mean(IC_prott5))
ic_eggnog_prott5<-fread("eggnog_prott5_IC_for_semsim.txt")
colnames(ic_eggnog_prott5)<-c("Gene","GO_category","IC_eggnog_prott5")
ic_eggnog_prott5$IC_eggnog_prott5<-as.double(ic_eggnog_prott5$IC_eggnog_prott5)
ic_eggnog_prott5<-ic_eggnog_prott5[!is.na(ic_eggnog_prott5$IC_eggnog_prott5),]
ic_eggnog_prott5_bp<-ic_eggnog_prott5 %>% filter(GO_category=="BP") %>% group_by(Gene) %>% summarise(IC_eggnog_prott5=mean(IC_eggnog_prott5))
ic_eggnog_prott5_mf<-ic_eggnog_prott5 %>% filter(GO_category=="MF") %>% group_by(Gene) %>% summarise(IC_eggnog_prott5=mean(IC_eggnog_prott5))
ic_eggnog_prott5_cc<-ic_eggnog_prott5 %>% filter(GO_category=="CC") %>% group_by(Gene) %>% summarise(IC_eggnog_prott5=mean(IC_eggnog_prott5))

ic_bp<-inner_join(ic_prott5_bp,ic_eggnog_prott5_bp, by="Gene")
ic_mf<-inner_join(ic_prott5_mf,ic_eggnog_prott5_mf, by="Gene")
ic_cc<-inner_join(ic_prott5_cc,ic_eggnog_prott5_cc, by="Gene")

semsim_ic_bp<-data_semsim %>% filter(Method=="EggNOG-mapper vs GOPredSim-ProtT5",GO_category=="BP") %>% inner_join(ic_bp,by="Gene")
semsim_ic_mf<-data_semsim %>% filter(Method=="EggNOG-mapper vs GOPredSim-ProtT5",GO_category=="MF") %>% inner_join(ic_mf,by="Gene")
semsim_ic_cc<-data_semsim %>% filter(Method=="EggNOG-mapper vs GOPredSim-ProtT5",GO_category=="CC") %>% inner_join(ic_cc,by="Gene")

cor.test(abs(semsim_ic_bp$IC_eggnog_prott5-semsim_ic_bp$IC_prott5),semsim_ic_bp$Semantic_similarity)

#dev.new()
pdf("IC_eggnog_prott5_semsim_bp.pdf", width=5,height=5)
ggplot(semsim_ic_bp,aes(x=IC_eggnog_prott5,y=IC_prott5,color=Semantic_similarity))+
  geom_point()+
  scale_color_scico(palette = "acton",direction=-1)+
  theme_pubr()+
  theme(legend.title.align=0.5,
        legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), 
        strip.background = element_blank(), strip.text=element_text(size=8, face = "bold"),
        plot.tag.position=c(0.03,0.78), 
        plot.tag = element_text(size=12, face="bold", color="#3D3D3D"), 
        axis.text = element_text(size = 8), 
        legend.position="right")+
  xlab("IC EggNOG-mapper")+
  ylab("IC GOPredSim-ProtT5")
dev.off()

pdf("IC_eggnog_prott5_semsim_mf.pdf", width=5,height=5)
ggplot(semsim_ic_mf,aes(x=IC_eggnog_prott5,y=IC_prott5,color=Semantic_similarity))+
  geom_point()+
  scale_color_scico(palette = "acton",direction=-1)+
  theme_pubr()+
  theme(legend.title.align=0.5,
        legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), 
        strip.background = element_blank(), strip.text=element_text(size=8, face = "bold"),
        plot.tag.position=c(0.03,0.78), 
        plot.tag = element_text(size=12, face="bold", color="#3D3D3D"), 
        axis.text = element_text(size = 8), 
        legend.position="right")+
  xlab("IC EggNOG-mapper")+
  ylab("IC GOPredSim-ProtT5")
dev.off()

pdf("IC_eggnog_prott5_semsim_cc.pdf", width=5,height=5)
ggplot(semsim_ic_cc,aes(x=IC_eggnog_prott5,y=IC_prott5,color=Semantic_similarity))+
  geom_point()+
  scale_color_scico(palette = "acton",direction=-1)+
  theme_pubr()+
  theme(legend.title.align=0.5,
        legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), 
        strip.background = element_blank(), strip.text=element_text(size=8, face = "bold"),
        plot.tag.position=c(0.03,0.78), 
        plot.tag = element_text(size=12, face="bold", color="#3D3D3D"), 
        axis.text = element_text(size = 8), 
        legend.position="right")+
  xlab("IC EggNOG-mapper")+
  ylab("IC GOPredSim-ProtT5")
dev.off()

#Boxplot with quantile Semsim
semsim_ic_bp<-semsim_ic_bp[!is.na(semsim_ic_bp$Semantic_similarity),]
semsim_ic_bp_quant <- melt(data = semsim_ic_bp, 
                              id.vars = c("Semantic_similarity","Gene"), 
                              measure.vars = c("IC_prott5","IC_eggnog_prott5"),
                              variable.name = "Program", 
                              value.name = "IC")
quantile_values<-quantile(semsim_ic_bp_quant$Semantic_similarity, na.rm=TRUE)
semsim_ic_bp_quant<-semsim_ic_bp_quant %>% mutate(Quantile=case_when(Semantic_similarity <= quantile_values[2] ~ paste0(quantile_values[1],"-",quantile_values[2]), Semantic_similarity <= quantile_values[3] & Semantic_similarity > quantile_values[2]  ~ paste0(quantile_values[2],"-",quantile_values[3]),Semantic_similarity <= quantile_values[4] & Semantic_similarity > quantile_values[3]  ~ paste0(quantile_values[3],"-",quantile_values[4]), Semantic_similarity > quantile_values[4]  ~ paste0(quantile_values[4],"-",quantile_values[5])))
pdf("IC_eggnog_prott5_semsim_boxplot_bp.pdf", width=5,height=5)
ggplot(semsim_ic_bp_quant,aes(x=Quantile,y=IC,fill=Program,color=Program))+
  geom_boxplot(na.rm=TRUE)+
  scale_fill_manual(values=c("#FF6E3A","#00C2F9"))+
  scale_color_manual(values=c("#8c3718","#006582"))+
  theme_pubr()+
  theme(legend.title.align=0.5,
        legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), 
        strip.background = element_blank(), strip.text=element_text(size=8, face = "bold"),
        plot.tag.position=c(0.03,0.78), 
        plot.tag = element_text(size=12, face="bold", color="#3D3D3D"), 
        axis.text = element_text(size = 8), 
        legend.position="right")+
  xlab("Semantic similarity")
dev.off()

semsim_ic_mf<-semsim_ic_mf[!is.na(semsim_ic_mf$Semantic_similarity),]
semsim_ic_mf_quant <- melt(data = semsim_ic_mf, 
                           id.vars = c("Semantic_similarity","Gene"), 
                           measure.vars = c("IC_prott5","IC_eggnog_prott5"),
                           variable.name = "Program", 
                           value.name = "IC")
quantile_values<-quantile(semsim_ic_mf_quant$Semantic_similarity, na.rm=TRUE)
semsim_ic_mf_quant<-semsim_ic_mf_quant %>% mutate(Quantile=case_when(Semantic_similarity <= quantile_values[2] ~ paste0(quantile_values[1],"-",quantile_values[2]), Semantic_similarity <= quantile_values[3] & Semantic_similarity > quantile_values[2]  ~ paste0(quantile_values[2],"-",quantile_values[3]),Semantic_similarity <= quantile_values[4] & Semantic_similarity > quantile_values[3]  ~ paste0(quantile_values[3],"-",quantile_values[4]), Semantic_similarity > quantile_values[4]  ~ paste0(quantile_values[4],"-",quantile_values[5])))
pdf("IC_eggnog_prott5_semsim_boxplot_mf.pdf", width=5,height=5)
ggplot(semsim_ic_mf_quant,aes(x=Quantile,y=IC,fill=Program,color=Program))+
  geom_boxplot(na.rm=TRUE)+
  scale_fill_manual(values=c("#FF6E3A","#00C2F9"))+
  scale_color_manual(values=c("#8c3718","#006582"))+
  theme_pubr()+
  theme(legend.title.align=0.5,
        legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), 
        strip.background = element_blank(), strip.text=element_text(size=8, face = "bold"),
        plot.tag.position=c(0.03,0.78), 
        plot.tag = element_text(size=12, face="bold", color="#3D3D3D"), 
        axis.text = element_text(size = 8), 
        legend.position="right")+
  xlab("Semantic similarity")
dev.off()

semsim_ic_cc<-semsim_ic_cc[!is.na(semsim_ic_cc$Semantic_similarity),]
semsim_ic_cc_quant <- melt(data = semsim_ic_cc, 
                           id.vars = c("Semantic_similarity","Gene"), 
                           measure.vars = c("IC_prott5","IC_eggnog_prott5"),
                           variable.name = "Program", 
                           value.name = "IC")
quantile_values<-quantile(semsim_ic_cc_quant$Semantic_similarity, na.rm=TRUE)
semsim_ic_cc_quant<-semsim_ic_cc_quant %>% mutate(Quantile=case_when(Semantic_similarity <= quantile_values[2] ~ paste0(quantile_values[1],"-",quantile_values[2]), Semantic_similarity <= quantile_values[3] & Semantic_similarity > quantile_values[2]  ~ paste0(quantile_values[2],"-",quantile_values[3]),Semantic_similarity <= quantile_values[4] & Semantic_similarity > quantile_values[3]  ~ paste0(quantile_values[3],"-",quantile_values[4]), Semantic_similarity > quantile_values[4]  ~ paste0(quantile_values[4],"-",quantile_values[5])))
pdf("IC_eggnog_prott5_semsim_boxplot_cc.pdf", width=5,height=5)
ggplot(semsim_ic_cc_quant,aes(x=Quantile,y=IC,fill=Program,color=Program))+
  geom_boxplot(na.rm=TRUE)+
  scale_fill_manual(values=c("#FF6E3A","#00C2F9"))+
  scale_color_manual(values=c("#8c3718","#006582"))+
  theme_pubr()+
  theme(legend.title.align=0.5,
        legend.margin = margin(t = 0, r = 10, b = 0, l = -10, unit = "pt"), 
        strip.background = element_blank(), strip.text=element_text(size=8, face = "bold"),
        plot.tag.position=c(0.03,0.78), 
        plot.tag = element_text(size=12, face="bold", color="#3D3D3D"), 
        axis.text = element_text(size = 8), 
        legend.position="right")+
  xlab("Semantic similarity")
dev.off()
