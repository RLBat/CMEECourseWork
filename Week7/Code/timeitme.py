#!/usr/bin/env python3

""" Uses the timeit command to compare optimised functions 
    with non-optimised functions, compares to using time """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import timeit
import time

from profileme import my_squares as my_squares_loops
from profileme2 import my_squares as my_squares_lc

from profileme import my_join as my_join_join
from profileme2 import my_join as my_join

## CONSTANTS ##

iters = 10000000
mystring = "mystring"

## FUNCTIONS ##


##############

# Compares the time for both squares functions using timeit

# Commented out to avoid errors when running
#%timeit my_squares_loops(iters)
#%timeit my_squares_lc(iters)

# Compares the time for both joins using timeit

# Commented out to avoid errors when running
#%timeit my_join_join(iters, mystring)
#%timeit my_join(iters, mystring)


# Times the non-optimised code

start = time.time()
my_squares_loops(iters)
print("my_squares_loops takes %f s to run." % (time.time() - start))

# Times the optimised code

start = time.time()
my_squares_lc(iters)
print("my_squares_lc takes %f s to run." % (time.time() - start))
