## Simple code to demonstrate the use of break within while loops

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

###############

i <- 0 #Initialize i
    while(i < Inf) { # Less than infinity
        if (i == 20) {
            break } # Break out of the while loop! 
        else { 
            cat("i equals " , i , " \n")
            i <- i + 1 # Update i
    }
}