## Demonstrates usage of the try function

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

###############

x <- rnorm(50) #Generate your population
doit <- function(x){
	x <- sample(x, replace = TRUE)
	if(length(unique(x)) > 30) {#only take mean if sample was sufficient
		 print(paste("Mean of this sample was:", as.character(mean(x))))
		} 
	else {
		stop("Couldn't calculate mean: too few unique points!")
		}
	}

print("Using vectorisation:")
result <- lapply(1:100, function(i) try(doit(x), FALSE)) # try stops stop() from exiting the whole programme

print("Using loops:")
result <- vector("list", 100) #Preallocate/Initialize
for(i in 1:100) {
	result[[i]] <- try(doit(x), FALSE) # try stops stop() from exiting the whole programme
	}
