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
    par(mar=c(5,5,5,5))
    p<-plot(seq(length(Data)), Data, xlab="Generations", ylab="Species Richness",
    main="Neutral Model Simulation", cex.lab=1.6, cex.axis=1.6, cex.main=1.6, cex.sub=1.6)
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
        x <- x+1 # If not even, +1
    }
    gen = x/2 #Define generation size
    for (i in 1:gen){
        # Runs gen no. of time steps with speciation on the commmunity
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
    p<-plot(seq(length(Datamax)), Datamax, xlab="Generations", ylab="Species Richness", ylim=c(0,100),
    main="Neutral Model Simulation with Speciation (v=0.1)", type="l", col="blue", cex.lab=1.6, cex.axis=1.6, cex.main=1.6, cex.sub=1.6)
    p<-lines(seq(length(Datamax)), Datamin, col="red")
    p<-legend(80,80,legend=c("Max initial richness", "Min initial richness"), col=c("blue", "red"), lty=1:2, cex=1.2)
    return(p)
}

# pdf("../Output/question_16.pdf", # Open blank pdf page using a relative path
#     12, 8) # These numbers are page dimensions in inches
# par(oma=c(2,2,2,2))
# par(mar=c(5,5,5,5))
# question_16()
# graphics.off();

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
    p <- barplot(vect, xlab = "Abundance", main="Abundance Octaves (J=100)", ylab="No. of Species", ylim=c(0, 10), cex.lab=1.6, cex.axis=1.6, cex.main=1.6, cex.sub=1.6)
    return(p)
}

challenge_AB <- function(initial=initialise_max(100), v=0.1, rep=10, len=200){
    Richness<-integer(len+1)
    Richness_sum <- integer(len+1)
    Community<-initial 
    for (i in 1:rep){
        Rich <- c(species_richness(initial)) # Adds richness at t=0 to vector
        Rich_sum <- c(Rich^2)
        for (j in 1:(len)){
            Community <- neutral_generation_speciation(Community, v) # Runs one generation's changes
            Rich <- c(Rich, species_richness(Community))
            Rich_sum <- c(Rich_sum, Rich[length(Rich)]^2)
        }
        Richness <- Richness + Rich
        Richness_sum <- Richness_sum + Rich_sum
    }
    Outputs<-list(Richness, Richness_sum)
    return(Outputs)
}

challenge_AB2 <- function(initial=initialise_max(100), v=0.1, rep=10, len=200){
    Rich<-integer(len+1)
    Rich_sum<- integer(len+1)
    for (i in 1:(rep)){
        time_series<-neutral_time_series_speciation(initial=initial, v=v, duration=len)
        Rich <- sum_vect(Rich, time_series)
        Rich_sum <- sum_vect(Rich_sum, (time_series)^2)
    }
    Outputs<-list(Rich, Rich_sum)
    return(Outputs)
}

challenge_A <- function(initial=initialise_max(100), v=0.1, rep=10, len=200){
    Outputs<-challenge_AB2(initial=initial, v=v, rep=rep, len=len)
    mean_rich <- Outputs[[1]]/rep
    Var <- (Outputs[[2]]/rep)-mean_rich^2
    SE <- sqrt(Var)/sqrt(rep)
    CI <- integer(length(SE))
    for (i in 1:length(SE)){
         CI[i] <- qnorm(0.986)*SE[i]
    }
    CI_bott<-mean_rich-CI
    CI_top<-mean_rich+CI

    p<-plot(mean_rich, type="l", xlab="Generations", main=paste("Mean Species Richness over time. Intial richness=", 
        max(initial, sep="")), ylab="Mean Species Richness", ylim=c(0,max(mean_rich)+5), xlim=c(0,len), cex.lab=1.6, cex.axis=1.6, cex.main=1.6, cex.sub=1.6)
    p<-lines(CI_top, type="l", col="green")
    p<-lines(CI_bott, type="l", col="blue")
    return(p)
}


challenge_B <- function(Population=100, v=0.1, rep=10, len=200){
    p<-plot(x=NULL, ylim=c(0,100), xlim=c(0,30), xlab="Generations", main="Mean Species Richness over time", 
        ylab="Mean Species Richness", cex.lab=1.6, cex.axis=1.6, cex.main=1.6, cex.sub=1.6)
    used_rich<-c()
    for (i in 1:Population){
        if (Population %% i == 0){
            run_rich=100/i
            initial=rep(seq(1,i), run_rich)
            Outputs<-challenge_AB(initial=initial, v=v, rep=rep, len=len)
            mean_rich <- Outputs[[1]]/rep
            used_rich<-c(used_rich, i)
            p<-lines(mean_rich, type="l", col=rainbow(Population/10)[tail(seq(1,length(used_rich)), n=1)])
        }
        else{
            next()
        }
    }
    p<-legend(20,90,legend=used_rich, col=rainbow(Population/10)[seq(1,length(used_rich))], lty=1, title="Species Richness", cex=1.2)
}

## CHECK ALL ITERATIVE FUNCTIONS - DO THEY REUSE INITIAL IN A NEW LOOP? ##

cluster_run <- function(speciation_rate=0.1, wall_time=1, size=100, interval_rich=10, interval_oct=20, burn_in_generations=200, output_file_name="Test2.rda"){
    Community <- initialise_min(size)
    generation=0
    iter_oct=0
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
                iter_oct<- iter_oct+1
                Octs[[iter_oct]]<-octaves(species_abundance(Community))
            }
        }
    }
    wall_time<-wall_time/60
    end_time<-proc.time()[3]-start
    # Save all parameters and outputs to a .rda file that can be later loaded back in
    save(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, end_time, Community, Richness, Octs, file=output_file_name)
}

# iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
# set.seed(iter)
# filename=paste("RLB18_", as.character(iter), sep="")
# Speciation_rate <- 0.006621
# J <- c(5000, 500,1000,2500)
# J <- J[iter %% 4 +1]
# cluster_run(speciation_rate=Speciation_rate, wall_time=690, size=J, interval_rich=1, interval_oct=J/10, burn_in_generations=8*J, output_file_name=paste(filename,".rda",sep=""))


question_20 <- function (){
    # Create empty lists for later use
    Final_Octs<-list()
    Vect_mean<-list()
    for (i in 1:100){ #Loop over each of the 100 runs
        load(paste("../Data/100_Runs/RLB18_",i,".rda", sep="")) #Load the RData file for each iteration
        if (is.null(Final_Octs[[as.character(size)]])){ #Runs if no runs for that J have been recorded
            Final_Octs[[as.character(size)]]<-Octs[[1]] #Places the first octaves from this run into Final_Octs per J
            Vect_mean[[as.character(size)]]<-length(Octs) #Adds 
            for (j in 2:length(Octs)){
                Final_Octs[[as.character(size)]]<-sum_vect(Final_Octs[[as.character(size)]], Octs[[j]])
            }
        }
        else{
            Vect_mean[[as.character(size)]]<-Vect_mean[[as.character(size)]]+length(Octs)
            for (j in 1:length(Octs)){
                Final_Octs[[as.character(size)]]<-sum_vect(Final_Octs[[as.character(size)]], Octs[[j]])
            }
        }
    }
    Sizes<-names(Final_Octs)
    par(mfrow=c(2,2))
    Finals<-list()
    for (i in 1:length(Sizes)){
        names(Final_Octs[[i]])<- 2^(seq(length(Final_Octs[[i]])))
        Finals[[i]]<-Final_Octs[[i]]/Vect_mean[[i]]
        p <- barplot(Finals[[i]], main=paste("Population Size = ", Sizes[i]), xlab = "Abundance Octaves", ylab="Mean No. of Species", cex.lab=1.6, cex.axis=1.6,cex.names=1, cex.main=1.6, cex.sub=1.6)
        p
    }
    return()
}

challenge_C <- function (){

}

coalescence<-function(J=100, v=0.1){
    lineages<-rep(1, J)
    abundances<-c()
    N<-J
    Theta<-(v*((J-1)/(1-v)))
    while (N>1){
        j<-sample(length(lineages), 1)
        randnum=runif(1)
        if (randnum<(Theta/(Theta+N-1))){
            abundances<-c(abundances, lineages[j])
            lineages<-lineages[-j]
            N<-N-1
        }
        else if (randnum>=(Theta/(Theta+N-1))){
            i<-sample(length(lineages), 1)
            while (i==j){
                i<-sample(length(lineages),1)
            }
            lineages[i]<-lineages[i]+lineages[j]
            lineages<-lineages[-j]
            N<-N-1
        }
    }
    abundances<-c(abundances, lineages)
    return(abundances)
}

challenge_D <- function(J=c(500,1000,2500,5000), v=0.1, runs=25){
    start<-proc.time()[3]
    Final_Abunds<-list()
    for (i in J){
        Final_Abunds[[as.character(i)]]<-octaves(coalescence(J=i, v=v))
        for (j in 2:runs){
            Final_Abun<-octaves(coalescence(J=i, v=v))
            Final_Abunds[[as.character(i)]]<-sum_vect(Final_Abunds[[as.character(i)]], Final_Abun)
        }
        Final_Abunds[[as.character(i)]]<-Final_Abunds[[as.character(i)]]/runs
    }
    Final_Abunds[["end_time"]]<-proc.time()[3]-start
    return(Final_Abunds)
}



############################################
############      FRACTALS      ###########
###########################################

chaos_game <- function (A=c(0,0), B=c(3,4), C=c(4,1), X=c(0,0), reps=10000){
    plot.new()
    Points <- list(A, B, C)
    plot (x=A[1], y=A[2], xlim=c(0,4), ylim=c(0,4), xlab="x", ylab="y", pch=0)
    points(B[1], B[2], pch=0)
    points(C[1], C[2], pch=0)
    points(X[1], X[2], cex=0.00001)
    for (i in 1:reps){
        D<-sample(Points, 1)[[1]]
        X_x<-((sqrt((D[1]-X[1])^2))/2)+(min(X[1], D[1]))
        X_y<-((sqrt((D[2]-X[2])^2))/2)+(min(X[2], D[2]))
        X<-c(X_x, X_y)
        points(X[1], X[2], cex=0.01)
    }
    return(plot)
}


turtle <- function (Start=c(0,0), Direction, Length){
    Angle = Direction
    Y = cos(Angle)*Length
    X = sin(Angle)*Length
    segments(Start[1], Start[2], X+Start[1], Y+Start[2])
    return(c(X+Start[1],Y+Start[2]))
}

# plot.new()
# plot(x=NULL, ylim=c(-10,10), xlim=c(-10,10))

elbow <- function (Start, Direction, Length){
    Point_1<-turtle(Start=Start, Direction=Direction, Length=Length)
    Point_2<-turtle(Start=c(Point_1), Direction=Direction+(pi/4), Length=0.95*Length)
}

# plot.new()
# plot(x=NULL, ylim=c(-10,10), xlim=c(-10,10), xlab="x", ylab="y")

spiral <- function (Start, Direction, Length){
    Point_1<-turtle(Start=Start, Direction=Direction, Length=Length)
    Point_2<-spiral(Start=c(Point_1), Direction=Direction+(pi/4), Length=0.95*Length)
}

spiral_2 <- function (Start, Direction, Length){
    if (Length > 0.01){
        Point_1<-turtle(Start=Start, Direction=Direction, Length=Length)
        Point_2<-spiral_2(Start=c(Point_1), Direction=Direction+(pi/4), Length=0.95*Length)
    }
    else {
        return("ended")
    }
}

tree <- function (Start, Direction, Length){
    if (Length > 0.01){
        Point_1<-turtle(Start=Start, Direction=Direction, Length=Length)
        Point_2<-tree(Start=c(Point_1), Direction=Direction+(pi/4), Length=0.65*Length)
        Point_3<-tree(Start=c(Point_1), Direction=Direction-(pi/4), Length=0.65*Length)
    }
    else {
        return("ended")
    }
}

# plot.new()
# plot(x=NULL, ylim=c(-10,20), xlim=c(-10,10))
# fern(c(0,-10), 2*pi, 4)

fern <- function (Start, Direction, Length){
    if (Length > 0.1){
        Point_1<-turtle(Start=Start, Direction=Direction, Length=Length)
        Point_2<-fern(Start=c(Point_1), Direction=Direction-(pi/4), Length=0.38*Length)
        Point_3<-fern(Start=c(Point_1), Direction=Direction, Length=0.87*Length)
    }
    else {
        return("ended")
    }
}

fern_2 <- function (Start=c(0,-10), Direction=2*pi, Length=5, dir=-1){
    if (Length > 0.01){
        Point_1<-turtle(Start=Start, Direction=Direction, Length=Length)
        if (dir==-1){
            Point_2<-fern_2(Start=c(Point_1), Direction=Direction-(pi/4), Length=0.38*Length, dir=-1)
            Point_3<-fern_2(Start=c(Point_1), Direction=Direction, Length=0.87*Length, dir=1)
        }
        else if (dir==1){
            Point_2<-fern_2(Start=c(Point_1), Direction=Direction+(pi/4), Length=0.38*Length, dir=1)
            Point_3<-fern_2(Start=c(Point_1), Direction=Direction, Length=0.87*Length, dir=-1)
        }  
    }
    else {
        return("ended")
    }
}

# par(mfrow=c(1,1))
# plot.new()
# plot(x=NULL, ylim=c(-10,32), xlim=c(-20,20), xlab="x", ylab="y")
# fern_2(c(0,-10), 2*pi, 5, -1)
