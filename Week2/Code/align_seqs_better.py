#!/usr/bin/env python3

""" Compares two DNA base sequences and finds the position at which they most 
    closely match. Where there are multiple best matches, it records all of them.
    The best matches are outputted to a file in ../Output/ """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## Imports ##

import pandas # Imports pandas, a library that interacts with csvs

## Constants ##

# Creates a data frame from the csv with the two sequences in it
seqs = pandas.read_csv('../Data/SeqShort.csv', sep = ',', header = None)

# Assigns each sequence to be matched to a variable
seq1 = seqs.loc[0][0]
seq2 = seqs.loc[0][1]

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

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

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
best_scores = dict() # Creates an empty dictionary

for i in range(l1):
    z = calculate_score(s1, s2, l1, l2, i)
    if z >= my_best_score:
        my_best_align = "." * i + s2 # Makes a visual representation of match position
        my_best_score = z 
        # Best score plus its allignment is added to the dictionary
        best_scores.setdefault(my_best_score, []).append(i)

with open ('../Output/Seq_matches.txt', 'w') as data:
    data.write(str(best_scores)) # Writes the best_scores dictionary to a text file

print(my_best_align)
print(s1)
print("Best score:", my_best_score)