##

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

## Packages ##

require(lattice)
require(plyr)

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
graphics.off(); #you can also use dev.off()

pdf("../Output/SizeRatio_Lattice.pdf", # Open blank pdf page using a relative path
    11.7, 8.3) # These numbers are page dimensions in inches
print (densityplot(~log(SizeRatio) | Type.of.feeding.interaction, data=MyDF))    
graphics.off(); #you can also use dev.off()

OutputDF<-ddply(MyDF, "Type.of.feeding.interaction", function(MyDF){
    Pred.Mean = mean(MyDF$Predator.mass) 
    Prey.Mean = mean(MyDF$Prey.mass)
    Pred.Median = median(MyDF$Predator.mass) 
    Prey.Median = median(MyDF$Prey.mass)
    Ratio.Mean = mean(MyDF$SizeRatio)
    Ratio.Median = median(MyDF$SizeRatio)
    data.frame(Pred.Mean, Prey.Mean, Ratio.Mean, Pred.Median, Prey.Median, Ratio.Median)
})

write.csv(OutputDF, ("../Output/PP_Results.csv"))


#print(log(by(MyDF[,9], MyDF$Type.of.feeding.interaction, mean)))
#print(log(by(MyDF[,9], MyDF$Type.of.feeding.interaction, median)))
#print(log(by(MyDF[,13], MyDF$Type.of.feeding.interaction, mean)))
#print(log(by(MyDF[,13], MyDF$Type.of.feeding.interaction, median)))
#print(log(by(MyDF[,16], MyDF$Type.of.feeding.interaction, mean)))
#print(log(by(MyDF[,16], MyDF$Type.of.feeding.interaction, median)))
