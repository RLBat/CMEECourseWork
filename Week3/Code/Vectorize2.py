#!/usr/bin/env python3

""" Runs the stochastic (with gaussian fluctuations) Ricker Eqn. using nested loops
    and without, showing the speed difference. """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'


## IMPORTS ##

import numpy as np
import time

## CONSTANTS ##

#None

## FUNCTIONS ##

def stochrick(p0=np.random.uniform(size=1000,low=.5,high=1.5),r=1.2,K=1,sigma=0.2,numyears=100):
    N=np.zeros((numyears, len(p0)))
    N[1,:]=p0
    for pop in range(0, len(p0)):
        for yr in range(1, numyears):
            N[yr,pop]=N[yr-1,pop]*np.exp(r*(1-N[yr-1,pop]/K)+np.random.normal(0,sigma,1))
    return N

def stochrickvect(p0=np.random.uniform(size=1000,low=.5,high=1.5),r=1.2,K=1,sigma=0.2,numyears=100):
    N=np.zeros((numyears, len(p0)))
    N[1,:]=p0
    for yr in range(1, numyears):
        N[yr,]=N[yr-1,]*np.exp(r*(1-N[yr-1,]/K)+np.random.normal(0,sigma,1))
    return N

################

#Time of nested loop solution
start1=time.time()
stochrick()
end1=time.time()
print("Time for loop solution to run:")
print(end1-start1,"\n")

#Time for vectorised solution
start2=time.time()
stochrickvect()
end2=time.time()
print("Time for vectorised solution to run:")
print(end2-start2, "\n")