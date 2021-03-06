## HPC Week Long practical code pertaining to neutral theory, to run a neutral 
## theory system at equilibrium on the HPC and to create graphical fractals

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())
graphics.off()

################################

# Function to calculate species richness of an input community
species_richness <- function(community=c(1,5,3,7,2,3,1,1,2,1,6)){
    return(length(unique(community)))
}

################################

# Gives a vector from 0 to size
initialise_max <- function(size=8){
    return (seq(size))
}

################################

# Gives a vector of n 1s where n is size
initialise_min <- function(size=8){
    return(rep(1, size))
}

################################

# Creates a vector of two random number from a given input vector
choose_two <- function(x=c(1,5,3,7,2,3,1,1,2,1,6)){
    sample(x,2)
}

################################

# Replaces one member of a community with another (simulates death and birth)
neutral_step <- function(community=c(1,5,3,7,2,3,1,1,2,1,6)){
    rand <- choose_two(seq(length(community))) # Picks 2 non-same individuals in the community
    community[rand[1]] <- community[rand[2]] # Replaces the first individual with the same species as the second
    return(community)
}

################################

# Runs neutral_step on a community n/2 times
neutral_generation <- function(community=c(1,5,3,7,2,3,1,1,2,1,6)){
    x <- length(community)
    if (x %%2 !=0){ # Checks to see if x is exactly divisible by 2 (i.e. even)
        x <- x+1 # If not even, +1
    }
    gen = x/2 # Defines generation size
    for (i in 1:gen){ # For each generation
        community<-neutral_step(community) #Replaces community with the community at t+1
    }
    return(community)
}

################################

# Creates a time series of species richness over duration generations of a community
neutral_time_series <- function(initial=c(1,5,3,7,2,3,1,1,2,1,6), duration=10){
    Rich <- c(species_richness(initial)) # Generates the initial species richness
    for (i in 1:duration){
        initial<-neutral_generation(initial) # Runs one generation's changes
        Rich <- c(Rich, species_richness(initial)) #Adds the species richness at each time to vector Rich
    }
    return(Rich)
}

################################

# Creates a plot of 200 generations of a pop with 100 species
question_8 <- function(){
    Data<-neutral_time_series(initialise_max(100), 200) # Runs the neutral model time series
    par(mar=c(5,5,5,5)) # Sets the plot margins
    p<-plot(seq(length(Data)), Data, xlab="Generations", ylab="Species Richness",
    main="Neutral Model Simulation", cex.lab=1.6, cex.axis=1.6, cex.main=1.6, cex.sub=1.6) #Plots richness over time
    return(p)
}

################################

# Describes one step of a zero sum neutral model with a chance for speciation
neutral_step_speciation <- function(community=c(1,5,3,7,2,3,1,1,2,1,6), v=0.2){
    rand <- choose_two(seq(length(community))) #Picks two random individuals from the community
    r <- runif(1, min=0, max=1) # Generates a random number between 0 and 1
    if (r <= v){ # If speciation occurs
        community[rand[1]] <- max(community)+1 # Replace the first individual with a novel species
    }
    else {
        community[rand[1]] <- community[rand[2]] # Replace the first individual with the same species as the second individual
    }
    return(community)
}

################################

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

################################

# Describes the species richness of sucessive n(duration) generations of a 
# zero sum neutral model with a chance for speciation
neutral_time_series_speciation <- function(initial=c(1,5,3,7,2,3,1,1,2,1,6), v=0.1, duration=20){
    Rich <- c(species_richness(initial)) # Generates the initial species richness
    for (i in 1:duration){
        initial<-neutral_generation_speciation(initial, v) # Runs one generation's changes
        Rich <- c(Rich, species_richness(initial)) # Adds the species richness to Rich
    }
    return(Rich)
}

################################

# Plots a neutral model with speciation over time, from both an initial
# and minimum species richness.
question_12 <- function(){
    #Runs a time series with max species richness
    Datamax<-neutral_time_series_speciation(initialise_max(100), 0.1, 200)
    #Runs a time series with min species richness
    Datamin<-neutral_time_series_speciation(initialise_min(100), 0.1, 200)
    # Plot the max time series
    p<-plot(seq(length(Datamax)), Datamax, xlab="Generations", ylab="Species Richness", ylim=c(0,100),
    main="Neutral Model Simulation with Speciation (v=0.1)", type="l", col="blue", cex.lab=1.6, cex.axis=1.6, cex.main=1.6, cex.sub=1.6)
    p<-lines(seq(length(Datamax)), Datamin, col="red") # Add min time series line
    # Add legend
    p<-legend(80,80,legend=c("Max initial richness", "Min initial richness"), col=c("blue", "red"), lty=1:2, cex=1.2)
    return(p)
}

################################

# Calcualates the abundance of each species
species_abundance <- function(community=c(1,5,3,7,2,3,1,1,2,1,6)){
    return(as.vector(table(community)))
}

################################

# Sorts an abundance vector into octave bins based on log2.
octaves <- function(abundance=c(1,1,1,1,2,2,4,3,6,12,18,26,57,68)){
    octav<-tabulate(floor(log2(abundance))+1)
    return(octav)
}

################################

# Sums two vectors together
sum_vect <- function (x=c(1,2,3,4),y=c(3,2,9,7,5,15,8)){
    # Obtains vector lengths
    len_x <- length(x)
    len_y <- length(y)
    # Checks if lengths are equal
    if (len_x==len_y){
        sum <- x + y
    }
    # Adds 0s to the shorter vector (x) to make the lengths the same
    else if (len_x<len_y){
        diff<-len_y-len_x
        x <- c(x, integer(diff))
        sum <- x + y
    }
    # Does the same, but if y is shorter
    else if (len_x>len_y){
        diff<-len_x-len_y
        y <- c(y, integer(diff))
        sum <- x + y
    }
    return (sum)
}

################################

# Generates octaves of the mean species richness at equilibrium and plots them
question_16 <- function(initial=initialise_max(100), v=0.1){
    # Defines the burn in period
    for (i in 1:200){
        initial <- neutral_generation_speciation(initial, v) # Runs one generation's changes
    }
    # Initialises vector for storing the cumulative mean of octaves
    vect<- octaves(species_abundance(initial))
    vect_mean=1
    # Equilibrium period
    for (i in 1:2000){
        initial <- neutral_generation_speciation(initial, v) # Runs one generation's changes
        if (i %% 20 == 0){ # At every 20th generation
            # add to the cumulative total
            vect<-sum_vect(vect, octaves(species_abundance(initial)))
            vect_mean=vect_mean+1 # Keeps count for calculating the final average
        }
    }
    vect<-vect/vect_mean #Calculates the mean octave
    names(vect)<- 2^(seq(length(vect))) # Names the bins
    # Creates the barplot
    p <- barplot(vect, xlab = "Abundance", main="Abundance Octaves (J=100)", ylab="No. of Species", ylim=c(0, 10), cex.lab=1.6, cex.axis=1.6, cex.main=1.6, cex.sub=1.6)
    return(p)
}

################################

# Add-on function for challenges A and B calculating species richness over time.
challenge_AB <- function(initial=initialise_max(100), v=0.1, rep=10, len=200){
    # Initialises empty vectors
    Rich<-integer(len+1)
    Rich_sum<- integer(len+1)
    for (i in 1:(rep)){ # Repeats rep times
        # Runs one time series and generates vector of richness over time
        time_series<-neutral_time_series_speciation(initial=initial, v=v, duration=len)
        Rich <- sum_vect(Rich, time_series) #Adds time series to Rich
        Rich_sum <- sum_vect(Rich_sum, (time_series)^2) # Adds Richness^2 for later calculation of varience
    }
    Outputs<-list(Rich, Rich_sum) # Creates a list so both vectors can be returned
    return(Outputs)
}

################################

# Calculates mean species richness over time with 97.5% confidence intervals and plots it
challenge_A <- function(initial=initialise_max(100), v=0.1, rep=10, len=200){
    Outputs<-challenge_AB(initial=initial, v=v, rep=rep, len=len) #Saves outputs from add-on function
    mean_rich <- Outputs[[1]]/rep # Calculates mean richness over time
    Var <- (Outputs[[2]]/rep)-mean_rich^2 # Calculates varience over time
    SE <- sqrt(Var)/sqrt(rep) # Calculates standard error over time
    CI <- integer(length(SE))
    for (i in 1:length(SE)){
         CI[i] <- qnorm(0.986)*SE[i] # Calculates the 1.25% confidence intervals
    }
    CI_bott<-mean_rich-CI
    CI_top<-mean_rich+CI
    # Creates a line graph of richness over time
    p<-plot(mean_rich, type="l", xlab="Generations", main=paste("Mean Species Richness over time. Intial richness=", 
        max(initial, sep="")), ylab="Mean Species Richness", ylim=c(0,max(mean_rich)+5), xlim=c(0,len), cex.lab=1.6, cex.axis=1.6, cex.main=1.6, cex.sub=1.6)
    # Adds green line for upper confidence interval
    p<-lines(CI_top, type="l", col="green")
    # Adds blue line for lower confidence interval
    p<-lines(CI_bott, type="l", col="blue")
    return(p)
}

################################

# Calculates mean species richness over time for a variety of initial 
# (but equally even) initial species richness values
challenge_B <- function(Population=100, v=0.1, rep=10, len=200){
    # Initialises an empty plot with all nessecary labels
    p<-plot(x=NULL, ylim=c(0,100), xlim=c(0,len), xlab="Generations", main="Mean Species Richness over time", 
        ylab="Mean Species Richness", cex.lab=1.6, cex.axis=1.6, cex.main=1.6, cex.sub=1.6)
    used_rich<-c() # Initialises empty vector
    for (i in 1:Population){
        #Ensures that this value of species richness can have equal numbers of each species
        if (Population %% i == 0){ 
            run_rich=100/i
            initial=rep(seq(1,i), run_rich) # Generates a vector of size pop with equal numbers of each species
            # Runs the add-on function to calculate richness over time
            Outputs<-challenge_AB(initial=initial, v=v, rep=rep, len=len)
            mean_rich <- Outputs[[1]]/rep # Generates mean richness
            used_rich<-c(used_rich, i) # Stores the initial richness value
            # Plots the species richness over time, with a colour determined by picking from a rainbow sequence
            p<-lines(mean_rich, type="l", col=rainbow(Population/10)[tail(seq(1,length(used_rich)), n=1)])
        }
        else{
            next()
        }
    }
    # Adds a legend to the plot using the stored use_rich values and rainbow colours
    p<-legend(20,90,legend=used_rich, col=rainbow(Population/10)[seq(1,length(used_rich))], lty=1, title="Species Richness", cex=1.2)
}

################################

# Generates average octaves for each value of J from the cluster data
question_20 <- function (){
    # Create empty lists for later use
    Final_Octs<-list()
    Vect_mean<-list()
    for (i in 1:100){ #Loop over each of the 100 runs
        load(paste("../Data/RLB18_",i,".rda", sep="")) #Load the RData file for each iteration
        if (is.null(Final_Octs[[as.character(size)]])){ #Runs if no runs for that J have been recorded
            Final_Octs[[as.character(size)]]<-Octs[[1]] #Places the first octaves from this run into Final_Octs per J
            Vect_mean[[as.character(size)]]<-length(Octs) #Records how many octaves were measured for this run
            for (j in 2:length(Octs)){
                # Sums all recorded octaves for that run
                Final_Octs[[as.character(size)]]<-sum_vect(Final_Octs[[as.character(size)]], Octs[[j]])
            }
        }
        else{ # If at least one run for that J has already been recorded
            # Adds to tot. number of recorded octaves for that J
            Vect_mean[[as.character(size)]]<-Vect_mean[[as.character(size)]]+length(Octs) 
            for (j in 1:length(Octs)){
                # Sums recorded octaves for that run with total so far from other runs
                Final_Octs[[as.character(size)]]<-sum_vect(Final_Octs[[as.character(size)]], Octs[[j]])
            }
        }
    }
    Sizes<-names(Final_Octs) # Records size names for graph
    par(mfrow=c(2,2))
    Finals<-list() 
    for (i in 1:length(Sizes)){ # For each value of J
        names(Final_Octs[[i]])<- 2^(seq(length(Final_Octs[[i]]))) # Names the octave bins
        Finals[[i]]<-Final_Octs[[i]]/Vect_mean[[i]] # Generates the mean octave
        # Makes a barplot of the abundance octaves
        p <- barplot(Finals[[i]], main=paste("Population Size = ", Sizes[i]), xlab = "Abundance Octaves", ylab="Mean No. of Species", cex.lab=1.6, cex.axis=1.6,cex.names=1, cex.main=1.6, cex.sub=1.6)
        p
    }
    return()
}

################################

# Additional function for Challenge D, calculates species richness at equilibrium using coalescence
coalescence<-function(J=100, v=0.1){
    lineages<-rep(1, J) #Creates a vector of 1s
    abundances<-c()
    N<-J
    Theta<-(v*((J-1)/(1-v)))
    while (N>1){
        j<-sample(length(lineages), 1) # chooses a random position in lineages
        randnum=runif(1) # chooses a random number between 0 and 1
        if (randnum<(Theta/(Theta+N-1))){
            # Places the value of the selected lineages individual into abundances
            abundances<-c(abundances, lineages[j]) 
            lineages<-lineages[-j] # Removes the selected lineages individual from lineages
            N<-N-1 # Lower the value of N to equal the number of individuals
        }
        else if (randnum>=(Theta/(Theta+N-1))){
            i<-sample(length(lineages), 1) # Sample a second random position in lineages
            while (i==j){ # Ensures the numbers aren't the same
                i<-sample(length(lineages),1)
            }
            lineages[i]<-lineages[i]+lineages[j] # Adds the values of the randomly selected individuals together
            lineages<-lineages[-j] # Removes the first selected individual from lineages
            N<-N-1 # Lower the value of N to equal the number of individuals
        }
    }
    abundances<-c(abundances, lineages) # Adds the final lineages individual to abundances
    return(abundances)
}

################################

# Calculates species richness octaves at equilibrum for any value/s of J, v, and reps.
challenge_D <- function(J=c(500,1000,2500,5000), v=0.1, runs=25){
    start<-proc.time()[3] # Start timer
    Final_Abunds<-list() # Initialise list
    for (i in J){ # Runs for each value of J
        Final_Abunds[[as.character(i)]]<-octaves(coalescence(J=i, v=v)) # Runs the coalescene function and sorts the output into bins
        for (j in 2:runs){
            Final_Abun<-octaves(coalescence(J=i, v=v)) # Runs the coalescene function and sorts the output into bins
            Final_Abunds[[as.character(i)]]<-sum_vect(Final_Abunds[[as.character(i)]], Final_Abun) # Adds octaves to running total
        }
        Final_Abunds[[as.character(i)]]<-Final_Abunds[[as.character(i)]]/runs # Calculates mean of the octaves
    }
    Final_Abunds[["end_time"]]<-proc.time()[3]-start # Stores duration
    return(Final_Abunds) # Returns means for all values of J
}

############################################
############      FRACTALS      ###########
###########################################

# Shape created by moving halfway to either of three coordinates repeatedly 
chaos_game <- function (A=c(0,0), B=c(3,4), C=c(4,1), X=c(0,0), reps=10000){
    plot.new() # Opens empty plot
    Points <- list(A, B, C)
    # Defines labels and axes, plots key coordinates
    plot (x=A[1], y=A[2], xlim=c(0,4), ylim=c(0,4), xlab="x", ylab="y", pch=0)
    points(B[1], B[2], pch=0)
    points(C[1], C[2], pch=0)
    # Defines initial point
    points(X[1], X[2], cex=0.01)
    for (i in 1:reps){
        D<-sample(Points, 1)[[1]] # Randomly picks one key coordinate
        X_x<-((sqrt((D[1]-X[1])^2))/2)+(min(X[1], D[1])) # Calculates halfway between the two x coordinates
        X_y<-((sqrt((D[2]-X[2])^2))/2)+(min(X[2], D[2])) # Calculates halfway between the two y coordinates
        X<-c(X_x, X_y) # Assigns new x
        points(X[1], X[2], cex=0.01) # Plots new x
    }
    return(plot)
}

################################

# Same as chaos game, but with an additonal parameter to highlight the first n points plotted
challenge_E_tri <- function (A=c(0,0), B=c(3,4), C=c(4,1), X=c(0,0), reps=10000, n=20){
    plot.new() # Opens empty plot
    Points <- list(A, B, C)
    # Defines labels and axes, plots key coordinates
    plot (x=A[1], y=A[2], xlim=c(0,4), ylim=c(0,4), xlab="x", ylab="y", pch=0)
    points(B[1], B[2], pch=0)
    points(C[1], C[2], pch=0)
    # Defines initial point
    points(X[1], X[2], cex=1, col="red", pch=16)
    for (i in 1:n){
        D<-sample(Points, 1)[[1]] # Randomly picks one key coordinate
        X_x<-((sqrt((D[1]-X[1])^2))/2)+(min(X[1], D[1])) # Calculates halfway between the two x coordinates
        X_y<-((sqrt((D[2]-X[2])^2))/2)+(min(X[2], D[2])) # Calculates halfway between the two y coordinates
        X<-c(X_x, X_y) # Assigns new x
        points(X[1], X[2], cex=1, col="red", pch=16) # Plots new x in red
    }
    for (i in 1:(reps-n)){
        D<-sample(Points, 1)[[1]] # Randomly picks one key coordinate
        X_x<-((sqrt((D[1]-X[1])^2))/2)+(min(X[1], D[1])) # Calculates halfway between the two x coordinates
        X_y<-((sqrt((D[2]-X[2])^2))/2)+(min(X[2], D[2])) # Calculates halfway between the two y coordinates
        X<-c(X_x, X_y) # Assigns new x
        points(X[1], X[2], cex=0.01) # Plots new x
    }
    return(plot)
}

challenge_E_quad <- function (A=c(0,0), B=c(0,4), C=c(4,0), D=c(4,4), X=c(0,0), reps=10000, n=20){
    plot.new() # Opens empty plot
    Points <- list(A, B, C, D)
    # Defines labels and axes, plots key coordinates
    plot (x=A[1], y=A[2], xlim=c(0,4), ylim=c(0,4), xlab="x", ylab="y", pch=0)
    points(B[1], B[2], pch=0)
    points(C[1], C[2], pch=0)
    points(D[1], D[2], pch=0)
    # Defines initial point
    points(X[1], X[2], cex=1, col="red", pch=16)
    for (i in 1:n){
        Z<-sample(Points, 1)[[1]] # Randomly picks one key coordinate
        X_x<-((sqrt((Z[1]-X[1])^2))/2)+(min(X[1], Z[1])) # Calculates halfway between the two x coordinates
        X_y<-((sqrt((Z[2]-X[2])^2))/2)+(min(X[2], Z[2])) # Calculates halfway between the two y coordinates
        X<-c(X_x, X_y) # Assigns new x
        points(X[1], X[2], cex=1, col="red", pch=16) # Plots new x in red
    }
    for (i in 1:(reps-n)){
        Z<-sample(Points, 1)[[1]] # Randomly picks one key coordinate
        X_x<-((sqrt((Z[1]-X[1])^2))/2)+(min(X[1], Z[1])) # Calculates halfway between the two x coordinates
        X_y<-((sqrt((Z[2]-X[2])^2))/2)+(min(X[2], Z[2])) # Calculates halfway between the two y coordinates
        X<-c(X_x, X_y) # Assigns new x
        points(X[1], X[2], cex=0.01) # Plots new x
    }
    return(plot)
}

################################

# Draws a like of specified length from a specified point in a specified direction
turtle <- function (Start=c(0,0), Direction=2*pi, Length=2){
    Angle = Direction
    Y = cos(Angle)*Length # Calculates new y coordinate
    X = sin(Angle)*Length # Calculate new x coordinate
    segments(Start[1], Start[2], X+Start[1], Y+Start[2]) # Draws the line
    return(c(X+Start[1],Y+Start[2])) # Returns end coordinates
}

################################

# Draws a line, then a subsequent shorter line 45 degrees to the right
elbow <- function (Start=c(0,0), Direction=2*pi, Length=2){
    Point_1<-turtle(Start=Start, Direction=Direction, Length=Length) # Draws the initial line
    # Draws the subsequent line, at pi/4 radians to the right and 5% shorter
    Point_2<-turtle(Start=c(Point_1), Direction=Direction+(pi/4), Length=0.95*Length)
}

################################

# Plots a spiral shape using recursive functions
spiral <- function (Start=c(0,2), Direction=2, Length=2){
    Point_1<-turtle(Start=Start, Direction=Direction, Length=Length)
    # Plots smaller line at an angle to initial line, by re-calling spiral
    Point_2<-spiral(Start=c(Point_1), Direction=Direction+(pi/4), Length=0.95*Length)
}

################################

# Plots a spiral shape using recursive functions
spiral_2 <- function (Start=c(0,2), Direction=2, Length=2){
    if (Length > 0.01){ # Stops the function re-calling itself when length reaches a critically small length
        Point_1<-turtle(Start=Start, Direction=Direction, Length=Length)
        # Plots smaller line at an angle to initial line, by re-calling spiral
        Point_2<-spiral_2(Start=c(Point_1), Direction=Direction+(pi/4), Length=0.95*Length)
    }
    else {
        return("ended")
    }
}

################################

# Plots a tree shape using recursive functions
tree <- function (Start=c(0,-10), Direction=2*pi, Length=2){
    if (Length > 0.01){ # Stops the function re-calling itself when length reaches a critically small length
        Point_1<-turtle(Start=Start, Direction=Direction, Length=Length)
        # Plots smaller line at an angle to initial line, by re-calling tree
        Point_2<-tree(Start=c(Point_1), Direction=Direction+(pi/4), Length=0.65*Length) # Right turn
        Point_3<-tree(Start=c(Point_1), Direction=Direction-(pi/4), Length=0.65*Length) # Left turn
    }
    else {
        return("ended")
    }
}

################################

# Plots a one-sided fern shape using recursive functions
fern <- function (Start=c(0,-10), Direction=2*pi, Length=4){
    if (Length > 0.1){ # Stops the function re-calling itself when length reaches a critically small length
        Point_1<-turtle(Start=Start, Direction=Direction, Length=Length)
        # Plots smaller line at an angle to initial line, by re-calling fern
        Point_2<-fern(Start=c(Point_1), Direction=Direction-(pi/4), Length=0.38*Length) #Left turn
        Point_3<-fern(Start=c(Point_1), Direction=Direction, Length=0.87*Length) # Straight ahead
    }
    else {
        return("ended")
    }
}

################################

# Plots a fern shape using recursive functions
fern_2 <- function (Start=c(0,-10), Direction=2*pi, Length=5, dir=-1){
    if (Length > 0.01){ # Stops the function re-calling itself when length reaches a critically small length
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
