## 

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

## Install Packages ##

require(ggplot2)
require(repr)
require(minpack.lm)

###############

options(repr.plot.width=6, repr.plot.height=5) # changes default plot size

#Store the non-linear function
powMod <- function(x, a, b) {
    return(a * x^b)
}

#Read in the data
MyData <- read.csv("../Data/GenomeSize.csv")
head(MyData)

#Subset it for only dragonflies and remove NA values
Data2Fit<-subset(MyData, Suborder == "Anisoptera")
Data2Fit<-Data2Fit[!is.na(Data2Fit$TotalLength),]
head(Data2Fit)

# Scatter plots of the data using base R
plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)

# and ggplots
ggplot(Data2Fit, aes(x = TotalLength, y = BodyWeight)) + geom_point()

#Creates the NLLS model
PowFit <- nlsLM(BodyWeight ~ powMod(TotalLength, a, b), data = Data2Fit, start = list(a = .1, b = .1))
summary(PowFit)

#Creates an ordered list of all lengths
Lengths <- seq(min(Data2Fit$TotalLength),max(Data2Fit$TotalLength),len=200)

# Finds the coefficients of the variables in the NLLS
coef(PowFit)["a"]
coef(PowFit)["b"]

# Creates the equation of the NLLS line using the outputs
Predic2PlotPow <- powMod(Lengths, coef(PowFit)["a"], coef(PowFit)["b"])

#Plots the data again, and adds the NLLS line
plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
lines(Lengths, Predic2PlotPow, col = 'blue', lwd = 2.5)

confint(Powfit)