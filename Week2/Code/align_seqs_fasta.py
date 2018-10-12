#!/usr/bin/env python3

""" Compares two base sequences and finds the position at which they most closely match """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## Imports ##

#import pandas

## Constants ##

if len(sys.argv) == 3:
    file1 = open(sys.argv[1], 'r')
    file2 = open(sys.argv[2], "r")
else:
    file1 = open('../Data/407228326.fasta', 'r')
    file2 = open('../Data/407228412.fasta', 'r')




seq1 = 
# Creates a data frame from the csv with the two sequences in it
#seqs = pandas.read_csv('../Data/SeqShort.csv', sep = ',', header = None)

# Assigns each sequence to be matched to a variable
#seq1 = seqs.loc[0][0]
#seq2 = seqs.loc[0][1]

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

for i in range(l1): # Note that you just take the first alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2 
        my_best_score = z 
print(my_best_align)
print(s1)
print("Best score:", my_best_score)
