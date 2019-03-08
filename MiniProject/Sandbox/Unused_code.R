p1<-ggplot(Birds)+aes(x=Latitude, y=log(Richness)) + geom_point(aes(colour=Latitude))
p1<-p1+scale_colour_gradient2(low="red",mid="gold",high="darkblue",midpoint=30)
p1<-p1+geom_vline(xintercept = 23.5, linetype="dashed",size=0.2)+  geom_text(aes(x=23.5, label="\nTropics", y=5), colour="black", angle=90, size=5, fontface="italic")
p1<-p1+scale_x_continuous('Latitude', breaks=seq(0,60,10))
p1<-p1+scale_y_continuous("Species Richness (log)")
p1<-p1+geom_smooth(method = "lm", se = FALSE, colour="black")
p1<-p1+theme(axis.text.x = element_text(size=14,angle = 50, vjust = 0.7, hjust=1), 
    axis.title.x = element_text(size=14,vjust=-9), 
    axis.title.y = element_text(size=14, vjust=5),
    axis.text.y = element_text(size=14),
    legend.title = element_text(size=14),
    legend.text = element_text(size=12),
    plot.margin = margin(20, 400, 40, 45))
p1<-p1+labs(fill='Predominant Land-Use')

p2<-ggplot(Birds)+aes(x=Latitude, y=log(Simpson)) + geom_point(aes(colour=Latitude))
p2<-p2+scale_colour_gradient2(low="red",mid="gold",high="darkblue",midpoint=30)
p2<-p2+geom_vline(xintercept = 23.5, linetype="dashed",size=0.2)+  geom_text(aes(x=23.5, label="\nTropics", y=4), colour="black", angle=90, size=3, fontface="italic")
p2<-p2+scale_x_continuous('Latitude', breaks=seq(0,60,10))
p2<-p2+scale_y_continuous("Reciprocal Simpson's Diversity Index (log)")
p2<-p2+geom_smooth(method = "lm", se = FALSE, colour="black")
p2<-p2+theme(axis.text.x = element_text(size=14,angle = 50, vjust = 0.7, hjust=1), 
    axis.title.x = element_text(size=14,vjust=-9), 
    axis.title.y = element_text(size=14, vjust=5),
    axis.text.y = element_text(size=14),
    legend.position = "none",
    plot.margin = margin(10, 10, 40, 45))
p2<-p2+labs(fill='Predominant Land-Use')

p3<-ggplot(Birds)+aes(x=Latitude, y=Shannon) + geom_point(aes(colour=Latitude))
p3<-p3+scale_colour_gradient2(low="red",mid="gold",high="darkblue",midpoint=30)
p3<-p3+geom_vline(xintercept = 23.5, linetype="dashed",size=0.2)+  geom_text(aes(x=23.5, label="\nTropics", y=4.5), colour="black", angle=90, size=3, fontface="italic")
p3<-p3+scale_x_continuous('Latitude', breaks=seq(0,60,10))
p3<-p3+scale_y_continuous("Shannon's Measure of Diversity")
p3<-p3+geom_smooth(method = "lm", se = FALSE, colour="black")
p3<-p3+theme(axis.text.x = element_text(size=14,angle = 50, vjust = 0.7, hjust=1), 
    axis.title.x = element_text(size=14,vjust=-9), 
    axis.title.y = element_text(size=14, vjust=5),
    axis.text.y = element_text(size=14),
    legend.position = "none",
    plot.margin = margin(10, 10, 40, 30))
p3<-p3+labs(fill='Predominant Land-Use')

p<-ggarrange(p1, ggarrange(p2,p3, ncol=2, nrow=1, labels=c("B", "C")), nrow=2, common.legend= TRUE, legend = "bottom", labels="A")



## Latitude ##

p<-ggplot(Birds)+aes(x=Latitude, y=log(Richness)) + geom_point(aes(colour=Predominant_land_use))
p<-p+scale_colour_manual(values=c("darkcyan","lightskyblue","gold", "orange","firebrick4"), labels = c("Primary","Secondary","Plantation","Agriculture","Urban"))
p<-p+geom_vline(xintercept = 23.5, linetype="dashed",size=0.2)+  geom_text(aes(x=23.5, label="\nTropics", y=5), colour="black", angle=90, size=5, fontface="italic")
p<-p+scale_x_continuous('Latitude', breaks=seq(0,60,10))
p<-p+scale_y_continuous("Species Richness (log)")
p<-p+theme(axis.text.x = element_text(size=16,angle = 50, vjust = 0.7, hjust=1), 
    axis.title.x = element_text(size=18,vjust=-9), 
    axis.title.y = element_text(size=18, vjust=5),
    axis.text.y = element_text(size=16),
    legend.title = element_text(size=16),
    legend.text = element_text(size=14),
    plot.margin = margin(20, 20, 40, 20))
p<-p+labs(fill='Predominant Land-Use')


pdf("../Output/Latitude.pdf", # Open blank pdf page using a relative path
    16, 12)
# Prints the created ggplot to the pdf
print(p)
graphics.off()
