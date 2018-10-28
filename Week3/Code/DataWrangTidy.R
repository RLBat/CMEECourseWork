## 

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

## Packages ##

require(tidyr)
require(dplyr)

## Load Data ##

# header = false because the raw data don't have real headers
MyData <- as_tibble(read.csv("../Data/PoundHillData.csv",header = F), stringsAsFactors = F) 

# header = true because we do have metadata headers
MyMetaData <- read.csv("../Data/PoundHillMetaData.csv",header = T, sep=";", stringsAsFactors = F)

##############


## Inspect the data ##

head(MyData)
fix(MyData)

# Gather all variables into 3 columns
new<-gather(MyData, Unique_ID, value, -V1)
# Spread out the data to true long format with separate species data
MyData<-spread(new, V1, value)

#tail(transposed)

# Rearrange the columns so that the treatment data comes first
MyData<-select(MyData, Cultivation, Block, Plot, Quadrat, everything())
# Removes unique ID column (only needed to rearrange the data)
MyData<-within(MyData, rm(Unique_ID))

####### Not dplyr or tidyr
# Replaces missing values with 0s
MyData[MyData == ""] = 0

#### Efforts to use dplyr 
#transposed %>% replace_na(list(0))

#df <- tibble(x = c(1, 2, NA), y = c("a", NA, "b"), z = list(1:5, NULL, 10:20))
#df %>% replace_na(list(x = 0, y = "unknown"))

# Does something but IDK
#transposed %>% mutate('Achillea millefolium' = replace("Achillea millefolium", "Achillea millefolium" == "" , "0"))
#mutate_all(transposed, funs(replace(., 0)))

# Example usage
#dat <- as_data_frame(c("Candy","Sanitizer","Candy","Water","Cake","Candy","Ice Cream","Gum","Candy","Coffee"))
#colnames(dat) <- "var"
#dat %>% mutate(var = replace(var, var != "Candy", "Not Candy"))

#numTable %>% mutate_all(funs(replace(., abs(. - mean(., na.rm = TRUE)) > 3 * sd(., na.rm = TRUE), NA)))

##Don't need to change to df as is already one

# Final formatting with one species column and counts for different treatments
MyWrangledData<-gather(MyData, Species, Count, 5:ncol(MyData))

# Block ensuring that all columns are the correct data type
MyWrangledData<-mutate(MyWrangledData, Cultivation=as.factor(Cultivation))
MyWrangledData<-mutate(MyWrangledData, Block=as.factor(Block))
MyWrangledData<-mutate(MyWrangledData, Plot=as.factor(Plot))
MyWrangledData<-mutate(MyWrangledData, Quadrat=as.factor(Quadrat))
MyWrangledData<-mutate(MyWrangledData, Species=as.factor(Species))
MyWrangledData<-mutate(MyWrangledData, Count=as.integer(Count))

str(MyWrangledData)