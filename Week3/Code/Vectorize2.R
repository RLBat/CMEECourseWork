## Runs the stochastic (with gaussian fluctuations) Ricker Eqn. using nested loops
## and without, showing the speed difference.

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

###############


stochrick<-function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100) { # Generates 1000 random values between 0.5 and 1.5 for p0 
  #initialize
  N<-matrix(NA,numyears,length(p0)) # Makes a matrix populated with NAs. It has rows = numyears and colums = length(p0)
  N[1,]<-p0 # Places the values of p0 into row 1

  for (pop in 1:length(p0)) #loop through the populations
  {
    for (yr in 2:numyears) #for each pop, loop through the years
    {
      #Adds the population size for each year, for each population
      N[yr,pop]<-N[yr-1,pop]*exp(r*(1-N[yr-1,pop]/K)+rnorm(1,0,sigma))
    }
  }
  return(N)
}



stochrickvect <- function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100) { # Generates 1000 random values between 0.5 and 1.5 for p0 
  #initialize
  N<-matrix(NA,numyears,length(p0)) # Makes a matrix populated with NAs. It has rows = numyears and colums = length(p0)
  N[1,]<-p0 # Places the values of p0 into row 1
  for (yr in 2:numyears) #for each pop, loop through the years
    {
      # Calculates the population size for each year across all columns
      N[yr,]<-N[yr-1,]*exp(r*(1-N[yr-1,]/K)+rnorm(1,0,sigma))
    }
  return(N)
}

# Displays computation time for nested loops
print ("Non-vectorised Stochastic Ricker takes:")
print(system.time(stochrick()))

# Displays computation time for non-nested loops
print ("Vectorised Stochastic Ricker takes:")
print(system.time(stochrickvect()))