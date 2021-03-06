## This function calculates heights of trees given distance of each tree 
## from its base and angle to its top, using  the trigonometric formula 

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

## Load Data ##

Trees <- read.csv("../Data/trees.csv")

###############

TreeHeight <- function(degrees, distance){
    for (species in Trees){
        radians <- degrees * pi / 180
        height <- distance * tan(radians)
        print(paste("Tree height is:", height))

        return (height) #Outputs the calculated height

    }
}

#Creates a new column in Trees of the returned values from TreeHeight
Trees$Tree.height.m<-TreeHeight(Trees$Angle.degrees, Trees$Distance.m)

# Writes the dataframe to an output file
write.csv (Trees, "../Output/TreeHts.csv")


