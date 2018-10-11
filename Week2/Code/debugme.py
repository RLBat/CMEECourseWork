#!/usr/bin/env python3

""" A script with inbuilt bugs to demonstrate debugging practices """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## imports ##

#None

## constants ##

#None

## functions ##

def createabug(x):
    y = x**4
    z = 0.
    import ipdb; ipdb.set_trace() # Adds a breakpoint at which to start debugging
    y = y/z
    return y

##############

createabug(25)