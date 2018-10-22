#!/usr/bin/env python3

"""  """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import csv
import sys
import pandas

## CONSTANTS ##

f = open (sys.argv[1], 'r')

Trees = csv.reader(f)

head(Trees)


## FUNCTIONS ##