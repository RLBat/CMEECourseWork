#!/usr/bin/env python3

""" Compares two DNA base sequences from two input files
    and finds the position at which they most closely match """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## Imports ##

import csv
import sys

## Constants ##

if len(sys.argv) == 3:
    with open (sys.argv[1]) as f:
        seq1 = [line.rstrip('\n') for line in f]
    
    seq1[0:len(seq1)] = [''.join(seq1[0:len(seq1)])]
    seq1 = seq1[0]

    with open (sys.argv[2]) as g:
        seq2 = [line.rstrip('\n') for line in g]

    seq2[0:len(seq2)] = [''.join(seq2[0:len(seq2)])]
    seq2 = seq2[0]
    #file1 = open(sys.argv[1], 'r')
    #file2 = open(sys.argv[2], "r")
else:
    with open ('../Data/407228326.fasta') as f:
        seq1 = [line.rstrip('\n') for line in f]
    
    seq1[0:len(seq1)] = [''.join(seq1[0:len(seq1)])]
    seq1 = seq1[0]

    with open ('../Data/407228412.fasta') as g:
        seq2 = [line.rstrip('\n') for line in g]

    seq2[0:len(seq2)] = [''.join(seq2[0:len(seq2)])]
    seq2 = seq2[0]



## Functions ##

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    #print("." * startpoint + matched)           
    #print("." * startpoint + s2)
    #print(s1)
    #print(score) 
    #print(" ")

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
    if z > my_best_score:
        my_best_align = "." * i + s2 
        my_best_score = z 
print(my_best_align)
print(s1)
print("Best score:", my_best_score)
