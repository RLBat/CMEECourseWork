## HPC Week Long practical code pertaining to neutral theory and

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())
graphics.off()

## Packages ##

require(ggplot2)

###############

# Gives example community, each number is a different species
community <- c(1,5,3,7,2,3,1,1,2,1,6)

# Function to calculate species richness of an input community
species_richness <- function(community){
    return(length(unique(community)))
}

# Gives a vector from 0 to size
initialise_max <- function(size){
    return (seq(size))
}

# Gives a vector of n 1s where n is size
initialise_min <- function(size){
    return(rep(1, size))
}

# Creates a vector of two random number from a given input vector
choose_two <- function(x){
    sample(x,2)
}

# Replaces one member of a community with another (simulates death and birth)
neutral_step <- function(community){
    rand <- choose_two(seq(length(community)))
    #print(rand)
    community[rand[1]] <- community[rand[2]]
    return(community)
}

# Runs neutral_step on a community n/2 times
neutral_generation <- function(community){
    x <- length(community)
    if (x %%2 !=0){ # Checks to see if x is exactly divisible by 2 (i.e. even)
        x <- x+1
    }
    gen = x/2
    for (i in 1:gen){
        community<-neutral_step(community)
    }
    return(community)
}
neutral_generation(community)

# Creates a time series of species richness over duration generations of a community
neutral_time_series <- function(initial, duration){
    Rich <- c(species_richness(initial)) # Generates the initial species richness
    for (i in 1:duration){
        initial<-neutral_generation(initial) # Runs one generation's changes
        Rich <- c(Rich, species_richness(initial))
    }
    return(Rich)
}

question_8 <- function(){
    Data<-neutral_time_series(initialise_max(100), 200)
    p<-qplot(seq(length(Data)), Data, geom = c("point"), xlab="Generations",
    ylab="Species Richness")
    return(p)
}

question_8()