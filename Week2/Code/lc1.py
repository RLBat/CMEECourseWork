#!/usr/bin/env python3

""" Creates lists of one attribute for several bird species in one tuple """

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

#None

##################

# Creates a list of all the latin names for species in "birds" using loops
Birds_latin = []
for species in birds:
    Birds_latin.append(species[0])
print (Birds_latin)

# Creates a list of all the common names for species in "birds" using loops
Birds_common = []
for species in birds:
    Birds_common.append(species[1])
print (Birds_common)

# Creates a list of all the masses for species in "birds" using loops
Birds_mass = []
for species in birds:
    Birds_mass.append(species[2])
print (Birds_mass)

# Creates a list of all the latin names for species in "birds" 
# using list comprehension
Birds_latin_lc = [species[0] for species in birds]
print (Birds_latin_lc)

# Creates a list of all the common names for species in "birds" 
# using list comprehension
Birds_common_lc = [species[0] for species in birds]
print (Birds_common_lc)

# Creates a list of all the masses for species in "birds" 
# using list comprehension
Birds_mass_lc = [species[0] for species in birds]
print (Birds_mass_lc)