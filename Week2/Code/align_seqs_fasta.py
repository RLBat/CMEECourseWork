#!/usr/bin/env python3

""" Compares two DNA base sequences from two input files
    and finds the position at which they most closely match """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## Imports ##

import csv
import sys

## Constants ##

if len(sys.argv) == 3: # If user has entered two files
    with open (sys.argv[1]) as f: # Opens first file as a list\
        #and removes newline characters
        seq1 = [line.rstrip('\n') for line in f]
    
    seq1[0:len(seq1)] = [''.join(seq1[0:len(seq1)])] # Merges all list items
    seq1 = seq1[0] # Makes an object be just the string in the list

    with open (sys.argv[2]) as g:# Opens second file as a list\
        #and removes newline characters
        seq2 = [line.rstrip('\n') for line in g]

    seq2[0:len(seq2)] = [''.join(seq2[0:len(seq2)])] # Merges all list items
    seq2 = seq2[0]# Makes an object be just the string in the list

else: #If no user inputs or incorrect number of inputs
    with open ('../Data/407228326.fasta') as f:# Opens first default file as a \
        #list and removes newline characters
        seq1 = [line.rstrip('\n') for line in f]
    
    seq1[0:len(seq1)] = [''.join(seq1[0:len(seq1)])] # Merges all list items
    seq1 = seq1[0]# Makes an object be just the string in the list

    with open ('../Data/407228412.fasta') as g:# Opens second default file as a\ 
        #list and removes newline characters
        seq2 = [line.rstrip('\n') for line in g]

    seq2[0:len(seq2)] = [''.join(seq2[0:len(seq2)])] # Merges all list items
    seq2 = seq2[0]# Makes an object be just the string in the list



## Functions ##

def calculate_score(s1, s2, l1, l2, startpoint):
    """ Computes a score by returning the number of matches between two sequences
    starting an from arbitrary startpoint (chosen by user)"""
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2): # Runs the loop as many times as the l2
        if (i + startpoint) < l1: # Checks to see if l1 has been exceeded
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    return score

###############

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swaps the two lengths

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

for i in range(l1): # Note that you just take the first alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score: # Only runs if the best score is exceeded
        my_best_align = "." * i + s2 # Makes a visual representation of match position
        my_best_score = z 
print(my_best_align)
print(s1)
print("Best score:", my_best_score)
