#!/usr/bin/env python3

""" This function calculates heights of trees given distance of each tree 
from its base and angle to its top, using  the trigonometric formula  """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import csv
import sys
import pandas

## CONSTANTS ##

f = open (sys.argv[1], 'r')

Trees = csv.reader(f)


## FUNCTIONS ##