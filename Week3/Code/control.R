## Some code exemlifying control flow constructs in R

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

###############

##If statement 
a <- TRUE
if (a == TRUE){
    print ("a is TRUE")
    } else {
    print ("a is FALSE")
}

z <- runif(1) # generates a random number
if (z <= 0.5) {
    print ("Less than a half")
}

## For loop using a sequence
for (i in 1:100){ # Runs for values 1 through to 100
    j <- i * i
    print (paste (i, " squared is", j ))
}

## For loop over vector of strings
for (species in c('Heliodoxa rubinoides', # Implicit loop
                 'Boissonneaua jardini', 
                 'Sula nebouxii'))
{
    print (paste ('The species is', species))
}

## For loop using a vector
v1 <- c("a", "bc", "def")
for (i in v1){
    print(i)
}

## While loop
i <- 0
while (i<100){ # Runs only if the conditions are met
    i <- i+1
    print(i^2)
}
