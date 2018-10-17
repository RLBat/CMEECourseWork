#!/usr/bin/env python3

""" Demonstates the usage of the csv library to read, manipulate
    and write to csv files """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import csv

## CONSTANTS ##

# None

## FUNCTIONS ##

# None

################

# Read a file containing:
# 'Species', 'Infraorder', 'Family', 'Distribution', 'Body mass male (kg)'
f = open ('../Data/testcsv.csv', 'r') # Opens a readable file

csvread = csv.reader(f) # Places the csv into an obect called csvread
temp = [] # Creates an empty list
temp.append(next(csvread)) # Appends the header row to temp and skips it so
                           # it is not read in the loop
for row in csvread: 
    temp.append(tuple(row)) # Appends the row to the temp list as a tuple
    print(row)
    print('The species is', row[0]) # Row[0] references the first coloumn in the row

f.close # Close the file

## Write a file containing only species name and Body mass

f = open('../Data/testcsv.csv', 'r') # Opens a readable file
g = open('../Output/bodymass.csv', 'w') # Creates a writeable file

csvread = csv.reader(f)
csvwrite = csv.writer(g)
# Places the first row into the object header and skips to the next row
header = (next(csvread)) 
# Writes the 1st and 3rd objects in header to the output file
csvwrite.writerow([header[0], header[4]])
for row in csvread:
    print (row)
    print ("Species %s has a mass of %s" % (row[0], row[4]))
    csvwrite.writerow([row[0], row[4]]) # Writes only the 1st and 3rd columns

# Closes both files
f.close()
g.close()