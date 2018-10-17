#!/usr/bin/env python3

""" A script exemplifyig the theory of variable scope by using local 
    and global variables in various ways """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

# None

## CONSTANTS ##

# None

################

_a_global = 10 # Define local variable

def a_function():
    """ Gives local values to variables and prints them """
    _a_global = 5 # Redefine the variable locally to a_function
    _a_local = 4
    print("Inside the function, the value is ", _a_global) 
    print("Inside the function, the value is ", _a_local)
    return None

a_function()

# Will still print "10" as _a_global only = 5 within a_function
print("Outside the function, the value is ", _a_global)

## Then try this

_a_global = 10 # Globally defines the variable

def a_function():
    """ Changes _a_global to a global variable, assigns new values to it and
    _a_local and prints them """
    # Makes _a_global a global function, meaning local changes have global effects
    global _a_global 
    # Locally defines/redefines the variables
    _a_global = 5
    _a_local = 4
    print("Inside the function, the value is ", _a_global)
    print("Inside the function, the value is ", _a_local)
    return None

a_function()
# Now prints 5, as the local changes were carried
print("Outside the function, the value is ", _a_global)
