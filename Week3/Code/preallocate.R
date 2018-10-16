# Script demonstarting the speed benefits of pre-allocating variables

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

a <- 1
no_allocate <- function(a){

    for (i in 1:1000000){
        a[i] = 10
    }
}

a <- rep(NA, 1000000)
pre_allocate <- function(a){
    for (i in 1:1000000){
        a[i] = 10
    }
}
print(system.time(no_allocate(a)))

print(system.time(pre_allocate(a)))