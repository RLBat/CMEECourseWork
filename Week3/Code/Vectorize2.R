# 

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

# Runs the stochastic (with gaussian fluctuations) Ricker Eqn .

rm(list=ls())


stochrick<-function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100) { # Generates 1000 random values between 0.5 and 1.5 for p0 
  #initialize
  N<-matrix(NA,numyears,length(p0)) # Makes a matrix populated with NAs. It has rows = numyears and colums = length(p0)
  N[1,]<-p0 # Places the values of p0 into row 1

  for (pop in 1:length(p0)) #loop through the populations
  {
    for (yr in 2:numyears) #for each pop, loop through the years
    {
      N[yr,pop]<-N[yr-1,pop]*exp(r*(1-N[yr-1,pop]/K)+rnorm(1,0,sigma))
    }
  }
  return(N)
}

print (stochrick)

stochrickvect <- function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100) { # Generates 1000 random values between 0.5 and 1.5 for p0 
  #initialize
  N<-matrix(NA,numyears,length(p0)) # Makes a matrix populated with NAs. It has rows = numyears and colums = length(p0)
  N[1,]<-p0 # Places the values of p0 into row 1

  
  
  return(N)
}
# Now write another function called stochrickvect that vectorizes the above 
# to the extent possible, with improved performance: 

# print("Vectorized Stochastic Ricker takes:")
# print(system.time(res2<-stochrickvect()))

