#!/usr/bin/env python3

""" Generates an food web with random body masses and associations
    then plots a network map using networkx """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import networkx as nx
import scipy as sc 
import matplotlib.pyplot as p 

## CONSTANTS ##

MaxN = 30
C = 0.75

## FUNCTIONS ##

def GenRdmAdjList(N=2, C=0.5):
    """ Creates a list of connected species (N) using a given 
        probability of connection (C) """
    Ids = range(N) # makes a new list of 0-N inclusive
    AList = []
    for i in Ids:
        if sc.random.uniform(0,1,1) < C:
            #sc works with numpy arrays so need to coerce to list
            Lnk = sc.random.choice(Ids,2).tolist() 
            if Lnk[0] !=Lnk[1]:
                AList.append(Lnk)
    return AList

################

# Runs the connectedness function and places the output into an array
AdjL = sc.array(GenRdmAdjList(MaxN, C))

# Assigns each species an ID
Sps = sc.unique(AdjL)

# Creates an array of numbers between -10 and 10 n=MaxN
Sizes = sc.random.uniform(-10, 10, MaxN)

# Creates a histogram of the sizes
#p.hist(Sizes)

# Ensures all matplotlib devices are closed 
p.close("all")

# Indicates the node layout on the graph
pos = nx.circular_layout(Sps)

#Generates a network graph
G = nx.Graph()

# Places the species as nodes
G.add_nodes_from(Sps)
# Add connecting lines
G.add_edges_from(tuple(AdjL))

#Make the sizes match the randomly generated sizes (scaled up to be viewable)
NodSizes = 1000 * (Sizes-min(Sizes))/(max(Sizes)-min(Sizes))

plot = p.figure()
# Draw the network
nx.draw_networkx(G, pos, node_size=NodSizes)

#Save as pdf
plot.savefig('../Output/RndNetwork.pdf')