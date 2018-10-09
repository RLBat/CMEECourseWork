#!/usr/bin/env python3

""" Additional exercises detailing the usage of 
    control statements and control flow"""

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## Gives the sqrt of a number
def foo1(x):
    return x ** 0.5

## Gives the higher of two numbers
def foo2(x, y):
    if x > y:
        return x
    return y

## Should sort numbers numerically. Doesn't work.
def foo3(x, y, z):
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

## Gives x!
def foo4(x):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result


## Also gives x!, but in a recursive fashion
def foo5(x): #recursive function
    if x == 1:
        return 1
    return x * foo5(x - 1)