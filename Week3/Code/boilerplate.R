# A boilerplate R script

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1


MyFunction <- function(Arg1, Arg2){

    # Statements involving Arg1, Arg2:
    print (paste ("Argument", as.character(Arg1), "is a", class(Arg1)))
    print (paste ("Argument", as.character(Arg2), "is a", class(Arg2)))

    return (c(Arg1, Arg2)) # this is optional, but useful
}

MyFunction(1,2) #test the function
MyFunction("Riki", "Tiki") # Another test