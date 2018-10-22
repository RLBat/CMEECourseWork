
# Imports the data
MyData <- as.matrix(read.csv("../Data/PoundHillData.csv",header = F,  stringsAsFactors = F))
MyMetaData <- read.csv("../Data/PoundHillMetaData.csv",header = T,  sep=";", stringsAsFactors = F)

head(MyData)

MyData[MyData == ""] = 0 # Suitable in this case only because area was exhaustively sampled

MyData <- t(MyData) # Turns rows into columns and adds them to the data set

TempData <- as.data.frame(MyData[-1,], stringsAsFactors = F) # Turns it into a data frame minus the first row
head(TempData)

colnames(TempData) <- MyData[1,] # Assigns column names

rownames(TempData) <- NULL


head(TempData)
require (reshape2)

# Sorts the data into a long format
MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")
head(MyWrangledData); tail(MyWrangledData)


# Block to ensure that all data is the correct type
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])
str(MyWrangledData) # Displays the structure

