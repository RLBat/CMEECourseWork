# A simple script to illustrate R input-output.

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1


MyData <- read.csv("../Data/trees.csv", header = TRUE) # import with headers

write.csv(MyData, "../Output/MyData.csv") #write it out as a new file

write.table(MyData[1,], file = "../Output/MyData.csv",append=TRUE) # Append to it

write.csv(MyData, "../Output/MyData.csv", row.names=TRUE) # write row names

write.table(MyData, "../Output/MyData.csv", col.names=FALSE) # ignore column names