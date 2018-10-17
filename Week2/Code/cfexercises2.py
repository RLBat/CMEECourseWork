#!/usr/bin/env python3

""" Additional exercises detailing the usage of 
    control statements and control flow """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## Imports ##

import sys

## Constants ##

# None

## Functions ##

def foo1(x=64): # x=num gives the default value for x in the function if no value \
    # is specified before running
    """ Gives the sqrt of a number """
    return x ** 0.5

def foo2(x=200, y=20):
    """ Gives the higher of two numbers """
    if x > y:
        return x
    return y

def foo3(x=3, y=1, z=2):
    """ Sorts 3 numbers into numerical order """
    if x > y: # If x is numerically larger than y
        tmp = y # Copies y into a placeholder object
        y = x # Copies x over y
        x = tmp # Makes x become the original value of y
    if x > z:
        tmp = z
        z = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo4(x=4):
    """ Gives x!"""
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo5(x=4): #recursive function
    """ Gives x! using a recursive function """
    if x == 1:
        return 1
    return x * foo5(x - 1) # Multiplies x by the result of running the function \
    # With a value of x 1 lower than the current iteration

def main(argv):
    """ Main entry point of the program """
    print(foo1(64))
    print(foo1(63))
    print(foo2(200, 1))
    print(foo2(5, 5.01))
    print(foo3(3, 2, 1))
    print(foo3(24, 365, 60))
    print(foo4(1))
    print(foo4(12))
    print(foo5(1))
    print(foo5(12))
    return 0 ## Gives a value for status

####################

if __name__ == "__main__":
    """ Makes sure the "main" function is called from command line"""
    status = main(sys.argv)
    sys.exit(status) ## 0 causes the program to terminate
