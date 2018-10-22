##

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

## Packages ##

require(maps)

## Load Data ##

load("../Data/GPDDFiltered.RData")

################

map("world", fill=TRUE, col="lightgreen", bg="lightblue", ylim=c(-100, 90), mar=c(0,0,0,0))
points(gpdd[,3], gpdd[,2], col="black", pch=16)

# The observations are largely along the same lattitude which restricts the 
# ability of any models to be used for predictions or results outside of this lattitude