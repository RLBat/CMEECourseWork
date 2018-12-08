#!/usr/bin/env python3

""" Shows the speed differences between using loops in python
    and vectorised solutions """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'


## IMPORTS ##

import numpy as np
import time

## CONSTANTS ##

#Create an 1000x1000 array of random numbers
M=np.random.uniform(size=(1000,1000))

## FUNCTIONS ##

def SumAllElements(M): #Sums all numbers in the matrix using nested loops
    Dimensions = M.shape
    Tot = 0
    for i in range(0, Dimensions[0]):
        for j in range(0, Dimensions[1]):
            Tot = Tot + M[i,j]
    return Tot

################

#Time of nested loop solution
start1=time.time()
SumAllElements(M)
end1=time.time()
print("Time for loop solution to run:")
print(end1-start1,"\n")

#Time for vectorised solution
start2=time.time()
M.sum(axis=(0,1))
end2=time.time()
print("Time for vectorised solution to run:")
print(end2-start2, "\n")
