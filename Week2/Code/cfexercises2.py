#!/usr/bin/env python3

""" Additional exercises detailing the usage of 
    control statements and control flow """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## Imports ##

import sys

## Functions ##

def foo1(x):
    """ Gives the sqrt of a number """
    return x ** 0.5

def foo2(x, y):
    """ Gives the higher of two numbers """
    if x > y:
        return x
    return y

def foo3(x, y, z):
    """ Sorts 3 numbers into numerical order """
    if x > y:
        tmp = y
        y = x
        x = tmp
    if x > z:
        tmp = z
        z = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo4(x):
    """ Gives x!"""
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo5(x): #recursive function
    """ Gives x! using a recursive function """
    if x == 1:
        return 1
    return x * foo5(x - 1)

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