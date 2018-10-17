#!/usr/bin/env python3

""" Several blocks of script demonsrating the ways to input and output data
        from files into python, or to files out of python """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import pickle

#######################

###################
# FILE INPUT
###################

# Open a file for reading
f = open('../Sandbox/test.txt', 'r') ## r = read
# use implicit for loop:
# if the object is a file, python will cycle over lines
for line in f: # Prints each line separately
    print(line)

# Close the file
f.close()

# Same example, skip blank lines
f = open('../Sandbox/test.txt', 'r')
for line in f:
    if len(line.strip()) > 0: ## Strips the line of all\
        ## spaces/newline characters then checks the length
        print(line) # Prints only lines containing non-space charcters

f.close()

##################
# FILE OUTPUT
##################

# Save the elements of a list to a file
list_to_save = range(100)

# Creates a file to save the list to
f = open('../Sandbox/testout.txt', 'w') ## w = write
for i in list_to_save:
    f.write(str(i) + '\n') ## Converts each object to a string, adds a new line\
    # at the end and writes it to the file

f.close()

###################
# STORING OBJECTS
###################

# To save an object (even complex) for later use

my_dictionary = {"a key": 10, "another key": 11}

#requires pickles (imported at the top of the script)

f = open('../Sandbox/testp.p', 'wb') ## note the b: accept binary files
pickle.dump(my_dictionary, f) # Places the dictionary in pickle (essentially a\
# temporary file)

f.close()

## Load the data again
f = open('../Sandbox/testp.p', 'rb')
another_dictionary = pickle.load(f) # Places the contents of pickle in a new dictionary
f.close()

print(another_dictionary)