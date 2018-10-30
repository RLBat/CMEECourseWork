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
require(dplyr)

###############

MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")

names(MyDF)

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
    # Sets line thicknesses for borders
    panel.border = element_rect(colour="grey30", size = 0.25),
    strip.background = element_rect(colour="grey30", size = 0.25),
    # Sets line thicknesses for gridlines
    panel.grid.minor = element_line(size=0.25),
    panel.grid.major = element_line(size=0.5))+
# Places the legend all on one line
guides(colour = guide_legend(nrow = 1))

pdf("../Output/PP_Regress.pdf", # Open blank pdf page using a relative path
    11.7, 8.3)
print(p)
graphics.off()
