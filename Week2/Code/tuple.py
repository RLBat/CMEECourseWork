#!/usr/bin/env python3

""" Prints the latin name, common name and mass of various bird species """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## Imports ##

# None

## Constants ##

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

## Functions ##

# None

###############

# Prints the attributes for each species using loops
for species in birds:
    print (species)

# Prints the attributes for each species using list comprehension
all_birds = [print(species) for species in birds]
