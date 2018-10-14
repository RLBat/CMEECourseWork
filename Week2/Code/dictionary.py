#!/usr/bin/env python3

""" Creates a dictionary of species' latin names sorted by Order """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## Imports ##

# None

## Constants ##

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

## Functions ##

# None

###############
taxa_dic = {} # Creates an empty dictionary
for species in taxa:
        # For each species, appends the Order as a new key if it does not exist
        # Attaches latin name to correct Order 
        taxa_dic.setdefault(species[1], []).append(species[0])
print (taxa_dic)

