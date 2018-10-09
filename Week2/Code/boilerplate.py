#!/usr/bin/env python3

""" Description of this program or application.
    You can use several lines"""

__appname__ = '[application name here]'
__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'
__license__ = "Licence for this code/program"

## imports ##

import sys # module to interface out program with the operating system

## constants ##

## functions ##

def main(argv):
    """ Main entry point of the program """
    print ('This is a boilerplate') # NOTE:indented using two tabs or 4 spaces
    return 0

################

## This means the code will not run when it's imported, but the functions can still be called.
if __name__ == "__main__": #Makes sure the first system argument is the 
                            #name of the program
    """ Makes sure the "main" function is called from command line"""
    status = main(sys.argv)
    sys.exit(status)