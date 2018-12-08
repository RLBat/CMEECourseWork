#!/usr/bin/env python3

""" This function calculates heights of trees given distance of each tree 
from its base and angle to its top, using  the trigonometric formula  """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import sys
import pandas
import re
import math

## CONSTANTS ##

# None

## FUNCTIONS ##

# None

##################

# Checks to see if the user inputted a file. Gives a meaningful error message if not.
if len(sys.argv)<=1:
    sys.exit("Please enter an input file")
else:
    # Imports the file using pandas
    Trees = pandas.read_csv(sys.argv[1], sep = ',', header=0)

# f= "../Data/trees.csv"
# Trees = pandas.read_csv(f, sep = ',', header=0)

# Creates an object of just the the filename - the extension using regex.
Output = re.findall(r"/+([\w\d]+).csv", sys.argv[1])
Output = Output[0]

def TreeHeight(degrees, distance):
    heights=[] # Initialises empty list
    # Uses the trigonomic formula to calculate height
    for i in range(0,len(Trees)):
        radians=degrees[i]*math.pi/180
        height=distance[i]*math.tan(radians)
        print ("Tree height is: %g" % (height))
        heights.append(height) #Appends height to list
    return heights

# Creates a list of column names that can be referenced
columns=Trees.columns

#Creates a new column in Trees of the returned values from TreeHeight
Trees["Tree.height.m"]=TreeHeight(Trees[columns[2]], Trees[columns[1]])

# Outputs the new dataframe to a csv with the using input file's name
Trees.to_csv('../Output/%s_treeheights.csv' % (Output), index=False)