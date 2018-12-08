## Shows the speed differences between using loops in R 
## and pre-defined functions that call from C

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

###############
#Creates a matrix of 1000000 random numbers
M <- matrix(runif(1000000),1000,1000)

#Sums all numbers in the matrix using nested loops
SumAllElements <- function(M){
  Dimensions <- dim(M)
  Tot <- 0
  for (i in 1:Dimensions[1]){
    for (j in 1:Dimensions[2]){
      Tot <- Tot + M[i,j]
    }
  }
  return (Tot)
}

#Time of nested loop solution
print("Time for loop solution to run:")
print(system.time(SumAllElements(M)))
#Time for vectorised solution
print("Time for vectorised solution to run:")
print(system.time(sum(M)))