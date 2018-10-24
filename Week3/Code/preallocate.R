## Script demonstarting the speed benefits of pre-allocating variables

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

###############

a <- 1 # Creates a vector of one value
no_allocate <- function(a){
    for (i in 1:1000000){ # Extends the vector as the function runs
        a[i] = 10
    }
}

print(system.time(no_allocate(a))) # Displays the computation time for no pre-allocation

a <- rep(NA, 1000000) # Creates a vector of 1000000 NA values
pre_allocate <- function(a){
    for (i in 1:1000000){
        a[i] = 10 # Allocates a value to each position on the vector
    }
}

print(system.time(pre_allocate(a))) # Displays the computation time when pre-allocating