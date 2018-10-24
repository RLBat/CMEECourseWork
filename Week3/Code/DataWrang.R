## Using base R functions to wrangle a dataset from wide to long format

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

## Packages ##

require(reshape2)

## Load Data ##

# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../Data/PoundHillData.csv",header = F)) 

# header = true because we do have metadata headers
MyMetaData <- read.csv("../Data/PoundHillMetaData.csv",header = T, sep=";", stringsAsFactors = F)

###############


################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

############# Inspect the dataset ###############
head(MyData)
dim(MyData)
str(MyData)
fix(MyData) #Opens it in a new window
fix(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) 
head(MyData)
dim(MyData)

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data

############# Convert from wide to long format  ###############

# Uses reshape2 package

?melt #check out the melt function

# Places the edited dataframe into a properly formatted one
MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")


# Block that sets the data types for each column
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

# Block of instructions showing the structure of the new data frame
str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

