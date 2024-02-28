library(ggplot2)
library(scico)
library(dplyr)
library(reshape2)
library(ggpubr)

#Set wd
setwd("")

#Load data
fantasia_data<-read.table("Fantasia_computer_resources.txt",header=TRUE,sep="\t")
fantasia_data[fantasia_data == "*"] <- NA

#Plot mem-size
fantasia_mem_long<-melt(fantasia_data,na.rm=TRUE,measure.vars=c("MemCPU","MemGPU"),variable.name="Arch",value.name="Mem")
fantasia_mem_long$Mem<-gsub(" GB","",fantasia_mem_long$Mem) %>% as.numeric()
fantasia_mem_long$Arch<-gsub("Mem","",fantasia_mem_long$Arch)
pdf("fantasia_memory_per_num_seqs.pdf", width=6,height=5)
ggplot(data=fantasia_mem_long,aes(x=Size,y=Mem))+
  geom_smooth(data=fantasia_mem_long[fantasia_mem_long$Arch=="GPU",],method="lm",color="#C36D9A")+
  geom_smooth(data=fantasia_mem_long[fantasia_mem_long$Arch=="CPU",],method="lm",color="#2D204C")+
  stat_regline_equation(label.y=350,label.x=90000,color="#2D204C")+
  geom_point(aes(color=Arch))+
  theme_pubr()+
  theme(legend.position=c(0.7,0.2),legend.margin = margin(t = 0, r = 10, b = 0, l = 10, unit = "pt"), strip.background = element_blank(), legend.box.background = element_rect(color="grey30", size=2))+
  labs(colour="Processor type")+
  scale_colour_manual(values=c("#2D204C","#C36D9A"))+
  xlab("Number of sequences")+
  ylab("RAM usage (GB)")
dev.off()

#Plot time-size
fantasia_time_long<-melt(fantasia_data,na.rm=TRUE,measure.vars=c("TimeClockCPU","TimeClockGPU"),variable.name="Arch",value.name="TimeClock")
fantasia_time_long$TimeClock<-as.difftime(fantasia_time_long$TimeClock) %>% as.numeric()
fantasia_time_long$Arch<-gsub("TimeClock","",fantasia_time_long$Arch)
pdf("fantasia_time_per_num_seqs.pdf", width=6,height=5)
ggplot(data=fantasia_time_long,aes(x=Size,y=TimeClock))+
  geom_smooth(data=fantasia_time_long[fantasia_time_long$Arch=="GPU",],method="lm",color="#C36D9A",fill="grey90")+
  geom_smooth(data=fantasia_time_long[fantasia_time_long$Arch=="CPU",],method="lm",color="#2D204C",fill="grey90")+
  geom_point(aes(color=Arch))+
  theme_pubr()+
  theme(legend.position=c(0.7,0.9),legend.margin = margin(t = 0, r = 10, b = 0, l = 10, unit = "pt"), strip.background = element_blank(), legend.box.background = element_rect(color="grey30", size=2))+
  labs(colour="Processor type")+
  scale_colour_manual(values=c("#2D204C","#C36D9A"))+
  xlab("Number of sequences")+
  ylab("Execution time (minutes)")
dev.off()