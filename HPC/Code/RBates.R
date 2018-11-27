## HPC Week Long practical code pertaining to neutral theory and

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())
graphics.off()

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

# Creates a plot of 200 generations of a pop with 100 species
question_8 <- function(){
    Data<-neutral_time_series(initialise_max(100), 200)
    plot(seq(length(Data)), Data, xlab="Generations",
    ylab="Species Richness")
    return(p)
}

# Describes one step of a zero sum neutral model with a chance for speciation
neutral_step_speciation <- function(community, v=0.2){
    rand <- choose_two(seq(length(community)))
    r <- runif(1, min=0, max=1)
    if (r <= v){
        community[rand[1]] <- max(community)+1
    }
    else {
        community[rand[1]] <- community[rand[2]]
    }
    return(community)
}

# Describes one generation of a zero sum neutral model with a chance for speciation
neutral_generation_speciation <- function(community, v){
    x <- length(community)
    if (x %%2 !=0){ # Checks to see if x is exactly divisible by 2 (i.e. even)
        x <- x+1
    }
    gen = x/2
    for (i in 1:gen){
        community<-neutral_step_speciation(community, v)
    }
    return(community)
}

# Describes the species richness of sucessive n(duration) generations of a 
# zero sum neutral model with a chance for speciation
neutral_time_series_speciation <- function(initial, v, duration){
    Rich <- c(species_richness(initial)) # Generates the initial species richness
    for (i in 1:duration){
        initial<-neutral_generation_speciation(initial, v) # Runs one generation's changes
        Rich <- c(Rich, species_richness(initial))
    }
    return(Rich)
}

question_12 <- function(){
    Datamax<-neutral_time_series_speciation(initialise_max(100), 0.1, 200)
    Datamin<-neutral_time_series_speciation(initialise_min(100), 0.1, 200)
    p<-plot(seq(length(Datamax)), Datamax, xlab="Generations", ylab="Species Richness", type="l", col="blue")
    p<-lines(seq(length(Datamax)), Datamin, col="red")
    p<-legend(80,80,legend=c("Max initial richness", "Min initial richness"), col=c("blue", "red"), lty=1:2, cex=1.2)
    return(p)
}

species_abundance <- function(community){
    return(as.vector(table(community)))
}

# octaves <- function(community){
#     abund<-species_abundance(community)
#     n=1
#     bins<-c(0)
#     for (i in length(abund):1){
#         if (abund[i]<2^n){
#             bins[n]<-bins[n]+1
#             print(bins)
#         }
#         else{
#             n<-n+1
#             bins[n]<-0
#             bins[n]<-bins[n]+1
#             print(bins)
#         }
#     return(bins)
#     }
# }

octaves <- function(abundance){
    octav<-tabulate(floor(log2(abundance))+1)
    return(octav)
}

sum_vect <- function (x,y){
    len_x <- length(x)
    len_y <- length(y)
    if (len_x==len_y){
        sum <- x + y
    }
    else if (len_x<len_y){
        diff<-len_y-len_x
        x <- c(x, integer(diff))
        sum <- x + y
    }
    else if (len_x>len_y){
        diff<-len_x-len_y
        y <- c(y, integer(diff))
        sum <- x + y
    }
    return (sum)
}

question_16 <- function(v=0.1){
    # Datamax<-neutral_time_series_speciation(initialise_max(100), 0.1, 200)
    # Datamin<-neutral_time_series_speciation(initialise_min(100), 0.1, 200)
    initial=initialise_max(100)
    Rich <- c(species_richness(initial)) # Generates the initial species richness
    for (i in 1:200){
        initial <- neutral_generation_speciation(initial, v) # Runs one generation's changes
        Rich <- c(Rich, species_richness(initial))
    }
    vect<- octaves(species_abundance(initial))
    for (i in 1:2000){
        initial <- neutral_generation_speciation(initial, v) # Runs one generation's changes
        Rich <- c(Rich, species_richness(initial))
        if (i %% 20 == 0){
            vect<-sum_vect(vect, octaves(species_abundance(initial)))
        }
    }
    names(vect)<- 2^(seq(length(vect)))
    p <- barplot(vect, xlab = "Abundance", ylab="No. of Species", ylim=c(0, 1000))
    return(p)
}


challenge_A <- function(){
    initial=initialise_max(100)
    v=0.1
    Rich <- c(species_richness(initial)) # Generates the initial species richness
    for (i in 1:200){
        initial <- neutral_generation_speciation(initial, v) # Runs one generation's changes
        Rich <- c(Rich, species_richness(initial))
    }
    vect<- octaves(species_abundance(initial))
    for (i in 1:2000){
        initial <- neutral_generation_speciation(initial, v) # Runs one generation's changes
        Rich <- c(Rich, species_richness(initial))
        if (i %% 20 == 0){
            vect<-sum_vect(vect, octaves(species_abundance(initial)))
        }
    }
}