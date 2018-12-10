#!/usr/bin/env python3

""" Builds a network of links between institutions. Translated from an R script. """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'


## IMPORTS ##

import networkx as nx
import scipy as sc 
import matplotlib.pyplot as p 
import pandas as pd

## CONSTANTS ##

# Reads in the files as pandas dfs
links = pd.read_csv("../Data/QMEE_Net_Mat_edges.csv", header=0)
nodes = pd.read_csv("../Data/QMEE_Net_Mat_nodes.csv", header=0)

################

p.close("all") #Close any open graphics

################

# Makes the column names the same as the row names
links.columns = list(range(0,6))

w_links = list() #initialise list

# Creates a list of tuples, of position and weight of link
for i in range(0,6):
    for j in range(0,6):
        if links[i][j]>0:
            w_links.append((i,j,links[i][j]))

# Creates a list of colours for plot
color_map=["blue", "blue", "green", "green", "green", "red"]

# Create the network plot
pos = nx.random_layout(nodes.index.values)
G = nx.Graph()
G.add_nodes_from(nodes.index.values)
G.add_weighted_edges_from(w_links, arrows=True)


# Initialise figure
plot = p.figure()

# Draw the plot
nx.draw_networkx(G, pos, node_color = color_map, node_size=5000, with_labels=False)
nx.draw_networkx_labels(G, pos, nodes["id"])

plot.savefig('../Output/pyNets.svg') #Save the output