#!/usr/bin/env python3

""" Finds just those species that are oaks from a list of species' latin names """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## Imports ##

# None

## Constants ##

# A list of latin names
taxa = [ 'Quercus robur',
         'Fraxinus excelsior',
         'Pinus sylvestris',
         'Quercus cerris',
         'Quercus petraea',
       ]

## Functions ##

# Returns the species name (lower case) if it is an oak
def is_an_oak(name):
    """ Checks to see if the latin name begins with Quercus """
    return name.lower().startswith('quercus ') # Places the name in lowercase first

################

# Using FOR loops

oaks_loops = set() # Creates an empty set
for species in taxa:
    if is_an_oak(species): # Runs is_an_oak on each item
        oaks_loops.add(species) # If return is True, adds the species to the set
print(oaks_loops) # Prints the oak species latin names

# Using List Comprehension
# Does the same as the for loop, but within one line of code
oaks_lc = set([species for species in taxa if is_an_oak(species)])
print(oaks_lc)

# Get names in UPPER CASE using FOR loops

oaks_loops = set() # Makes an empty set
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species.upper()) # Adds the species name of any identified\
        # Oaks in upper case
print(oaks_loops)

# Get names in UPPER CASE using List Comprehensions
# Does the same as above but via list comprehension
oaks_lc = set([species.upper() for species in taxa if is_an_oak(species)])
print(oaks_lc)
