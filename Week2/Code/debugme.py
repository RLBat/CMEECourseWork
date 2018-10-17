#!/usr/bin/env python3

""" A script with inbuilt bugs to demonstrate debugging practices """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## imports ##

import ipdb

## constants ##

#None

## functions ##

def createabug(x):
    """ A function that creates an impossible number. Contains a breakpoint
    for debuging """
    y = x**4
    z = 0.
    ipdb.set_trace() # Adds a breakpoint at which to start debugging
    y = y/z # Creates an impossible number
    return y

##############

createabug(25)