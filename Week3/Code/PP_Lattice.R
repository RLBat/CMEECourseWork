## Generates density plots and key descriptive stats for predator/prey masses
## Per type of feeding interaction. Outputs the results as a pdf for the graphs
## and a csv file of descriptive stats

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

## Packages ##

require(lattice)
require(tidyr)
require(plyr)
require(dplyr)

###############

MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")
dim(MyDF) #check the size of the data frame you loaded

MyDF$SizeRatio = with(MyDF, Predator.mass/Prey.mass) # Makes a new column with predator/prey mass ratios

pdf("../Output/Pred_Lattice.pdf", # Open blank pdf page using a relative path
    11.7, 8.3) # These numbers are page dimensions in inches
print (densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data=MyDF))    
graphics.off(); #you can also use dev.off()

pdf("../Output/Prey_Lattice.pdf", # Open blank pdf page using a relative path
    11.7, 8.3) # These numbers are page dimensions in inches
print (densityplot(~log(Prey.mass) | Type.of.feeding.interaction, data=MyDF))    
graphics.off(); 

pdf("../Output/SizeRatio_Lattice.pdf", # Open blank pdf page using a relative path
    11.7, 8.3) # These numbers are page dimensions in inches
print (densityplot(~log(SizeRatio) | Type.of.feeding.interaction, data=MyDF))    
graphics.off();

# Creates a dataframe of the predator mass means and medians by feeding interaction
PredDF<-ddply(MyDF, "Type.of.feeding.interaction", function(MyDF){
    Mean = mean(log(MyDF$Predator.mass)) 
    Median = median(log(MyDF$Predator.mass))
    data.frame(Mean, Median)
})
# Adds a column detailing that these are all predator masses
PredDF$"Log(Type)"<-"Predator.mass"

# Creates a dataframe of the prey mass means and medians by feeding interaction
PreyDF<-ddply(MyDF, "Type.of.feeding.interaction", function(MyDF){
    Mean = mean(log(MyDF$Prey.mass)) 
    Median = median(log(MyDF$Prey.mass))
    data.frame(Mean, Median)
})
# Adds a column detailing that these are all prey masses
PreyDF$"Log(Type)"<-"Prey.mass"

# Creates a dataframe of the size ratio means and medians by feeding interaction
RatioDF<-ddply(MyDF, "Type.of.feeding.interaction", function(MyDF){
    Mean = mean(log(MyDF$SizeRatio)) 
    Median = median(log(MyDF$SizeRatio)) 
    data.frame(Mean, Median)
})
# Adds a column detailing that these are all size ratios
RatioDF$"Log(Type)"<-"Size.Ratio"

# Bind all three dataframes together
OutputDF<-rbind(PredDF, PreyDF, RatioDF)
# Place type of mass as the first column
OutputDF<-select(OutputDF, "Log(Type)", everything())


# Export the dataframe as a csv to the output folder
write.csv(OutputDF, ("../Output/PP_Results.csv"), row.names=F)
