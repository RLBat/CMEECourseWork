#!/usr/bin/env python3

""" Additional exercises detailing the usage of 
    control statements and control flow"""

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

def foo1(x):
    return x ** 0.5

def foo2(x, y):
    if x > y:
        return x
    return y

def foo3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo4(x)