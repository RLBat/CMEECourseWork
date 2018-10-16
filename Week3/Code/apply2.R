# Script to show more examples of apply usage

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

SomeOperation <- function(v){
    if (sum(v) > 0){
        return (v * 100)
    }
    return (v)
}

M <- matrix(rnorm(100), 10, 10) # Creates a 10x10 matrix of random numbers
print (apply(M, 1, SomeOperation)) # Uses SomeOperation row-wise on the data within M
print (M)
