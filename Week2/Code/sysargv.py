#!/usr/bin/env python3

""" A script exemplifing the use of sys.arg and how it behaves """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import sys

## CONSTANTS ##

# None

## FUNCTIONS ##

# None

################

#sys.arg[0] is always the name of the module itself
print ("This is the name of the script: ", sys.argv[0]) 
print ("Number of arguments: ", len(sys.argv))
print ("The arguments are: ", str(sys.argv))
