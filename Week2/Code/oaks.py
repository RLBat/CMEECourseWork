#!/usr/bin/env python3

""" Finds just those species that are oaks from a list of species' latin names """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## Imports ##

# None

## Constants ##

taxa = [ 'Quercus robur',
         'Fraxinus excelsior',
         'Pinus sylvestris',
         'Quercus cerris',
         'Quercus petraea',
       ]

## Functions ##

# Returns the species name (lower case) if it is an oak
def is_an_oak(name):
    return name.lower().startswith('quercus ')

################

# Using FOR loops

oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species) 
print(oaks_loops)

# Using List Comprehension
oaks_lc = set([species for species in taxa if is_an_oak(species)])
print(oaks_lc)

# Get names in UPPER CASE using FOR loops

oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species.upper())
print(oaks_loops)

# Get names in UPPER CASE using List Comprehensions
oaks_lc = set([species.upper() for species in taxa if is_an_oak(species)])
print(oaks_lc)
