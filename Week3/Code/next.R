## Simple code to demonstrate the use of next in loops

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

###############

for (i in 1:10) {
  if ((i %% 2) == 0) 
    next # pass to next iteration of loop 
  print(i) # Only print if not exactly divisible by 2 (odd numbers)
}