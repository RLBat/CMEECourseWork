## Script to show more examples of apply usage

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

###############

SomeOperation <- function(v){
    # If the sum of the column is positive
    if (sum(v) > 0){
        # Multiply all values in the column by 100
        return (v * 100)
    }
    return (v)
}

M <- matrix(rnorm(100), 10, 10) # Creates a 10x10 matrix of random numbers
print (apply(M, 1, SomeOperation)) # Uses SomeOperation column-wise on the data within M
print (M)
