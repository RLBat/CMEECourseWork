## HPC Week Long practical code pertaining to neutral theory, to run a neutral 
## theory system at equilibrium on the HPC

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())
graphics.off()

###############

# Gives example community, each number is a different species
community <- c(1,5,3,7,2,3,1,1,2,1,6)

# Function to calculate species richness of an input community
species_richness <- function(community=c(1,5,3,7,2,3,1,1,2,1,6)){
    return(length(unique(community)))
}

# Gives a vector from 0 to size
initialise_max <- function(size=8){
    return (seq(size))
}

# Gives a vector of n 1s where n is size
initialise_min <- function(size=8){
    return(rep(1, size))
}

# Creates a vector of two random number from a given input vector
choose_two <- function(x=c(1,5,3,7,2,3,1,1,2,1,6)){
    sample(x,2)
}

# Replaces one member of a community with another (simulates death and birth)
neutral_step <- function(community=c(1,5,3,7,2,3,1,1,2,1,6)){
    rand <- choose_two(seq(length(community)))
    community[rand[1]] <- community[rand[2]]
    return(community)
}

# Runs neutral_step on a community n/2 times
neutral_generation <- function(community=c(1,5,3,7,2,3,1,1,2,1,6)){
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

# Creates a time series of species richness over duration generations of a community
neutral_time_series <- function(initial=c(1,5,3,7,2,3,1,1,2,1,6), duration=10){
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
neutral_step_speciation <- function(community=c(1,5,3,7,2,3,1,1,2,1,6), v=0.2){
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
neutral_generation_speciation <- function(community=c(1,5,3,7,2,3,1,1,2,1,6), v=0.2){
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
neutral_time_series_speciation <- function(initial=c(1,5,3,7,2,3,1,1,2,1,6), v=0.1, duration=20){
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

species_abundance <- function(community=c(1,5,3,7,2,3,1,1,2,1,6)){
    return(as.vector(table(community)))
}

octaves <- function(abundance=c()){
    octav<-tabulate(floor(log2(abundance))+1)
    return(octav)
}

sum_vect <- function (x=c(1,2,3,4),y=c(3,2,9,7,5,15,8)){
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

question_16 <- function(initial=initialise_max(100), v=0.1){
    for (i in 1:200){
        initial <- neutral_generation_speciation(initial, v) # Runs one generation's changes
    }
    vect<- octaves(species_abundance(initial))
    vect_mean=1
    for (i in 1:2000){
        initial <- neutral_generation_speciation(initial, v) # Runs one generation's changes
        if (i %% 20 == 0){
            vect<-sum_vect(vect, octaves(species_abundance(initial)))
            vect_mean=vect_mean+1
        }
    }
    vect<-vect/vect_mean
    names(vect)<- 2^(seq(length(vect)))
    p <- barplot(vect, xlab = "Abundance", ylab="No. of Species", ylim=c(0, 10))
    return(p)
}

challenge_A <- function(initial=initialise_max(100), v=0.1, rep=10, burn=200, eq=2000){
    Richness<-integer(burn+eq+1)
    Richness_sum <- integer(burn+eq+1)
    Community<-initial
    for (i in 1:rep){
        Rich <- c(species_richness(initial)) # Adds richness at t=0 to vector
        Rich_sum <- c(Rich^2)
        for (j in 1:burn){
            Community <- neutral_generation_speciation(Community, v) # Runs one generation's changes
            Rich <- c(Rich, species_richness(Community))
            Rich_sum <- c(Rich_sum, Rich[length(Rich)]^2)
        }
        vect_mean=1
        for (j in 1:eq){
            Community <- neutral_generation_speciation(Community, v) # Runs one generation's changes
            Rich <- c(Rich, species_richness(Community))
            Rich_sum <- c(Rich_sum, Rich[length(Rich)]^2)
        }
        Richness <- Richness + Rich
        Richness_sum <- Richness_sum + Rich_sum
    }
    mean_rich <- Richness/rep
    Var <- (Richness_sum/rep)-mean_rich^2
    SE <- sqrt(Var)/sqrt(rep)
    CI <- integer(length(SE))
    for (i in 1:length(SE)){
         CI[i] <- qnorm(0.986)*SE[i]
    }
    CI_bott<-mean_rich-CI
    CI_top<-mean_rich+CI

    plot(mean_rich, type="l", xlab="Generations", ylab="Mean Species Richness")
    lines(CI_top, type="l", col="green")
    lines(CI_bott, type="l", col="blue")
    proc.time()
}

## CHECK ALL ITERATIVE FUNCTIONS - DO THEY REUSE INITIAL IN A NEW LOOP? ##

cluster_run <- function(speciation_rate=0.1, wall_time=1, size=100, interval_rich=10, interval_oct=20, burn_in_generations=200, output_file_name="Test2.rda"){
    Community <- initialise_min(size)
    generation=0
    iter=0
    Octs<-list()
    Richness<-c()
    wall_time<-wall_time*60
    start<-proc.time()[3]
    while (proc.time()[3]-start < wall_time){
        Community<-neutral_generation_speciation(community=Community, v=speciation_rate)
        generation=generation+1
        if (generation<burn_in_generations){
            if (generation %% interval_rich == 0){
                Richness <- c(Richness, species_richness(Community))
            }
        }
        else{
            if (generation %% interval_oct == 0){
                iter<- iter+1
                Octs[[iter]]<-octaves(species_abundance(Community))
            }
        }
    }
    wall_time<-wall_time/60
    end_time<-proc.time()[3]-start
    # Save all parameters and outputs to a .rda file that can be later loaded back in
    save(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, end_time, Community, Richness, Octs, file=output_file_name)
}

iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
set.seed(iter)
filename=paste("RLB18_", as.character(iter), sep="")
Speciation_rate <- 0.006621
J <- c(5000, 500,1000,2500)
J <- J[iter %% 4 +1]
cluster_run(speciation_rate=Speciation_rate, wall_time=690, size=J, interval_rich=1, interval_oct=J/10, burn_in_generations=8*J, output_file_name=paste(filename,".rda",sep=""))