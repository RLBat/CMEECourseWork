## Plots predator mass against prey mass for each feeding interaction type, and 
## gives lm estimates for each lifestage.
## Calculates true lm values for each lifestage, for each feeding interaction
## and outputs to a csv.

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

## Packages ##

require(ggplot2)
require(tidyr)
require(plyr)
require(dplyr)

###############

MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")

# Inspect the df
names(MyDF)
str(MyDF)

# Creates a plot of predator mass against prey mass by life stage, seperated by feeding type
p<-qplot(Prey.mass, Predator.mass, 
    data = MyDF, colour = Predator.lifestage, shape=I(3),
    xlab="Prey mass in grams", ylab="Predator mass in grams", log = "xy")+
theme_bw()+ # Sets the theme colour
facet_grid(Type.of.feeding.interaction ~.)+ # Separates the plots
geom_smooth(method = "lm", fullrange=TRUE, size=0.5)+ # Adds lm estimate lines
# formats the legend position and colours as well as plot size
theme(legend.position="bottom", plot.margin = unit(c(1,6,1,6),"cm"),
    legend.key = element_rect(colour = 'grey', size = 0.5, linetype='solid'),
    legend.title = element_text(face="bold"),
    # Sets line thicknesses for borders
    panel.border = element_rect(colour="grey30", size = 0.25),
    strip.background = element_rect(colour="grey30", size = 0.25),
    # Sets line thicknesses for gridlines
    panel.grid.minor = element_line(size=0.25),
    panel.grid.major = element_line(size=0.5))+
# Places the legend all on one line
guides(colour = guide_legend(nrow = 1))

pdf("../Output/PP_Regress.pdf", # Open blank pdf page using a relative path
    9, 11.7)
# Prints the created ggplot to the pdf
print(p)
graphics.off()

# Changes all units to grams
MyDF1<-subset(MyDF, MyDF$Prey.mass.unit!="mg")
MyDF2<-subset(MyDF, MyDF$Prey.mass.unit!="g")
MyDF2$Prey.mass<-MyDF2$Prey.mass/1000
MyDF2$Prey.mass.unit<-"g"
MyDF<-rbind(MyDF1, MyDF2)

# Creates a data frame with outputs from lms of all categories plotted
Outputlm.DF<-ddply(MyDF, .(Type.of.feeding.interaction, Predator.lifestage), summarize,
# Extracts the intercept of the lm
Intercept=summary(lm(MyDF$Predator.mass ~ MyDF$Prey.mass))$coef[1,1], 
# Extracts the slope of the lm
Slope=summary(lm(MyDF$Predator.mass ~ MyDF$Prey.mass))$coef[2,1],
# Extracts the r squared value
R.squared=summary(lm(MyDF$Predator.mass ~ MyDF$Prey.mass))$r.squared,
# Extracts the f statistic 
F.Statistic=summary(lm(MyDF$Predator.mass ~ MyDF$Prey.mass))$fstatistic[1],
# Calculates the overall p value using the f statistic values
Overall.Pvalue=pf(summary(lm(MyDF$Predator.mass ~ MyDF$Prey.mass))$fstatistic[1],
summary(lm(MyDF$Predator.mass ~ MyDF$Prey.mass))$fstatistic[2],
summary(lm(MyDF$Predator.mass ~ MyDF$Prey.mass))$fstatistic[3],lower.tail=FALSE) 
)


# b<-MyDF %>%
# group_by(Type.of.feeding.interaction, Predator.lifestage) %>%
# rowwise()%>%
# summarise(Intercept=summary(lm(Predator.mass ~ Prey.mass))$coef[1,1], Slope=summary(lm(Predator.mass ~ Prey.mass))$coef[2,1])

#summary(MyDF)

write.csv(Outputlm.DF, "../Output/PP_Regress_Results.csv", row.names=F)

# Outputlm.DF<-ddply(MyDF, .(Type.of.feeding.interaction, Predator.lifestage), summarize,
# # Extracts the intercept of the lm
# Intercept=summary(lm(Predator.mass ~ Prey.mass))$coef[1,1], 
# # Extracts the slope of the lm
# Slope=summary(lm(Predator.mass ~ Prey.mass))$coef[2,1]
# )