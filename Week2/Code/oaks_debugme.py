#!/usr/bin/env python3

""" Module that checks a list of latin names to see which are oaks, 
    and exports all oak species to a text file """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import csv
import sys
import doctest

## CONSTANTS ##

# None

## FUNCTIONS ##

def is_an_oak(name):
    """ Tests to see if the function can correctly identify oaks

    >>> is_an_oak("Quercus, robur")
    True

    >>> is_an_oak("Fraxinus, excelsior")
    False

    >>> is_an_oak("Quercus robur")
    False

    >>> is_an_oak("Quercs, robur")
    False

    >>> is_an_oak("Quercusoba, rubinous")
    False

    >>> is_an_oak("robor, Quercus")
    False

    >>> is_an_oak("QUERCUS, ROBOR")
    True

    >>> is_an_oak("quercus, robor")
    True

    >>> is_an_oak(365)
    False

    >>> is_an_oak(True)
    False

    >>> is_an_oak("Pseudoquercus, confiscuous")
    False

    >>> is_an_oak(" Quercus, robor")
    True

    """
    name = str(name).lower() # Turns the name into a string
    name = name.lstrip() # Strips any spaces from the beginning of the string
    name = name.split(",")[0] # Removes anything after the comma in the name
    if len(name)!=7: # Ensures any name of the incorrect length returns false
        return False
    return name.startswith("quercus") # Returns true if the name begins with "quercus"

def main(argv):
    """ Main entry point of the program """ 

    taxa = csv.reader(open('../Data/TestOaksData.csv','r'))
    header = next(taxa) # Skips the header line and outputs it to header
    csvwrite = csv.writer(open('../Output/JustOaksData.csv','w'))
    csvwrite.writerow(header) # Appends the header to the output file   
    oaks = set() # Creates an empty set
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]): # Sends the row to is_an_oak, if True then run this
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]]) # Writes the name to the output file
    return 0

#doctest.testmod() #Commented out doctest, uncomment to allow the doctests to run
if (__name__ == "__main__"):
    # Runs main(argv) if this is run directly rather than being imported
    status = main(sys.argv)