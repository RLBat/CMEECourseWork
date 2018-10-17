#!/usr/bin/env python3

""" Shows how to distinguish between the module being run directly or called from another module """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

# None

## CONSTANTS ##

# None

## FUNCTIONS ##

# None

###############


if __name__ == '__main__': # If the name of this programe is the same as the\
    # name of the main program being run
    print ('This program is being run by itself')
else:
    print ('I am being imported from another module')
