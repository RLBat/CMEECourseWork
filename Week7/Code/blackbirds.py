#!/usr/bin/env python3

""" Searches a text file and extracts the kingdom, phylum and species data """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import re

## CONSTANTS ##

# Read the file (using a different, more python 3 way, just for fun!)
with open('../Data/blackbirds.txt', 'r') as f:
    text = f.read()

## FUNCTIONS ##

#None

################

# replace \t's and \n's with a spaces:
text = text.replace('\t',' ')
text = text.replace('\n',' ')
# You may want to make other changes to the text. 

# In particular, note that there are "strange characters" (these are accents and
# non-ascii symbols) because we don't care for them, first transform to ASCII:

text = text.encode('ascii', 'ignore') # first encode into ascii bytes
text = text.decode('ascii', 'ignore') # Now decode back to string

# Regular expression that finds each instance of Kingdom name, Phylum name, and Species name
match = re.findall(r"Kingdom\s+([A-Z]\w+)\s.*?Phylum\s+([A-Z]\w+)\s.*?Species\s+([A-Z]\w+\s\w+)\s", text)

#Defines a header row
header = "Kingdom Phylum Species"

# Prints the found taxanomic data with headers
print(header + "\n" + "\n".join([" ".join(x) for x in match]))


