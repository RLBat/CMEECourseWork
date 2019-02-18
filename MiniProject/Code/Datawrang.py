#!/usr/bin/env python3

""" Initial data inspection and sorting for miniproject work """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import pandas

###########################

## INITIAL DATA HANDLING ##

############################


#Extract data from raw database
print("Reading in initial dataframe")
df = pandas.read_csv('../Data/Raw/resource.csv', sep = ',', header = 0, low_memory=False)

## df has 3,250,404 species over 17,650 sites. Too large for analysis, need to restrict ##

# Creates a new sebsetted df of just chordates
print("Subsetting to only chordates")
df=df[df.Phylum == "Chordata"]

#Subset data to only those using abundance data
print("Subsetting to only studies that collected abundance data")
df=df[df.Diversity_metric == "abundance"]

# Subset to only include bird data
print("Subsetting to only bird data")
df = df[df.Class == "Aves"]

# Remove unclassed land use intensity data
print("Removing all unclassed land uses")
df = df[df.Predominant_land_use != "Cannot decide"]

#Removing all species with abundance values of 0
print("Removing absent species")
df = df[df.Measurement != 0]

## Current df has 51,372 species over 3052 sites - much better size for analysis ##
print("Saving final dataframe to csv")
df.to_csv('../Data/Birds_abund.csv', index=False) #Save to csv
print("Finished data wrangling")

