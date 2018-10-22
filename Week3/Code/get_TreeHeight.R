# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

args = commandArgs(trailingOnly=TRUE)

# Imports a dataframe from user input
Trees <- read.csv(args[1])

Output <- args[1]
Output <- gsub(".csv", "", Output) # removes .csv extension
Output <- gsub(".*/", "", Output) # removes everything before last /


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
write.csv (Trees, (sprintf('../Output/%s_treeheights.csv', Output)))

