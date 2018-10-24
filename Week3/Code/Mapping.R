## Loads a set of location data for various species, and plots these coordinates
## on a world map

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

## Packages ##

require(maps)

## Load Data ##

load("../Data/GPDDFiltered.RData")

################

# generates a world map and sets colours and margins
map("world", fill=TRUE, col="lightgreen", bg="lightblue", mar=c(0,0,0,0))
# plots points from data frame on map, sets colours and shape
points(gpdd[,3], gpdd[,2], col="black", pch=16)

## Biases ##

# The observations are largely along the same lattitude (30-60)

# The observations also occur only over Eurasia and North America (other than
# one point in Africa and two in Japan). This restricts them spatially.

# The observations are largely terrestrially biased.

