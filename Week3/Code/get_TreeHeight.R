## This function calculates heights of trees given distance of each tree 
## from its base and angle to its top, using  the trigonometric formula
## It takes an input file from the user and outputs the result with an appropriate name 

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

## Load Data ##

Trees <- read.csv("../Data/trees.csv")

###############

args = commandArgs(trailingOnly=TRUE) # Only reads arguments after the script is called

if (length(args) == 0){ # If there is no arguments after the script name
    stop("No input file detected") # Exits the script, giving an error message
}

# Imports a dataframe from user input
Trees <- read.csv(args[1])

Output <- args[1] # Uses the user inputted file
Output <- gsub(".csv", "", Output) # removes .csv extension
Output <- gsub(".*/", "", Output) # removes everything before last /


TreeHeight <- function(degrees, distance){
    # Uses the trigonomic formula to calculate height
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
write.csv (Trees, (sprintf('../Output/%s_treeheights.csv', Output)))


