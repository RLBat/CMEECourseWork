#!/usr/bin/env python3

""" An example script to show profiling optimisations (optimised) """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

# None

## CONSTANTS ##

# None

## FUNCTIONS ##

def my_squares(iters):
    """ Creates a list of square numbers from 0 to iters (10,000,000) 
    using list comprehension """
    out = [i ** 2 for i in range(iters)]
    return out

def my_join(iters, string):
    """ Creates a string of the inputted string 
        separated by commas, iters number of times """
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x,y):
    """ Prints the inputted x and y objects, runs my_squares and my_join """
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

################

run_my_funcs(10000000,"My string")