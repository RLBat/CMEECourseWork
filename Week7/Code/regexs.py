#!/usr/bin/env python3

""" Uses a series of example regex expressions to teach regular expressions """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import re

## CONSTANTS ##

my_string = "a given string"
MyStr = 'an example'

## FUNCTIONS ##

#None

################

match = re.search(r'\s', my_string) # Searches my_string for spaces
print(match) # shows a match has been found

match = re.search(r'\d', my_string)
print(match)


match = re.search(r'\w*\s', MyStr) # what pattern is this?

#Simple statement to avoid error messages and give meaningful outputs
if match:                      
    print('found a match:', match.group()) 
else:
    print('did not find a match')    

#Finds "2"
match = re.search(r'2', 'it takes 2 to tango')
match.group()

#Finds any number
match = re.search(r'\d', 'it takes 2 to tango')
match.group()

#Finds any number and everything after that
match = re.search(r'\d.*', 'it takes 2 to tango')
match.group()

#Finds subsequent alphanumeric characters of length 1-3 between two spaces
match = re.search(r'\s\w{1,3}\s', 'once upon a time')
match.group()

#Matches the last word (alphanumeric string preceeded by a space)
match = re.search(r'\s\w*$', 'once upon a time')
match.group()

#Matches a word of any length, then spaces and numbers and any other character 
# (not required if not found), then ending in a number.
re.search(r'\w*\s\d.*\d', 'take 2 grams of H20').group()

# Starts with any number of alphanumeric characters, then any character any number
# of times, then ending with the final space.
re.search(r'^\w*.*\s', 'once upon a time').group()

# Starts with any number of alphanumeric characters, then one set of any characters
# before a space. (i.e: takes the first word)
re.search(r'^\w*.*?\s', 'once upon a time').group()

# Checks for all characters between first < and last >
re.search(r'<.+>', 'This is a <EM>first</EM> test').group()

# Checks for all characters between first < and first > by making the + "lazy"
# using ?
re.search(r'<.+?>', 'This is a <EM>first</EM> test').group()

# Any number of numbers, then a full stop, then any number of numbers
re.search(r'\d*\.?\d*','1432.75+60.22i').group()

#Searches for any sequences of A,T,C and/or G
re.search(r'[AGTC]+', 'A sequence ATTCGT').group()

# Finds a word of any size after any number of spaces, starting with a capital/s, 
# then a space, then another word of any size
re.search(r'\s+[A-Z]{1}\w+\s\w+', "The bird-shit frog's name is Theloderma asper").group()

