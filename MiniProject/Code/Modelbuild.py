#!/usr/bin/env python3

""" Calculate diversity metrics and produce a csv suitable for 
    the modelling process """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import pandas
import math

##########################################################

## Functions to calculate diversity metrics ##

#################################################

## Shannon's Index ##
# Takes a vector of abundances as input

def Shan(Community=[2,6,5,3,1,8]):
    # Define N as total no of individuals
    N = sum(Community)
    shan_tot = 0
    for i in range(0,len(Community)): # For each species in the community
        # Calculates shannon value for each species and sums
        shan_tot = shan_tot + ((Community[i]/N)*math.log((Community[i]/N)))
    Shannon = -shan_tot
    return(Shannon)

## Simpson's Value ##
# Takes a vector of abundances as input

def Simp(Community=[2,6,5,3,1,8]):
    # Define N as total no of individuals
    N = sum(Community)
    simp_tot = 0
    for i in range(0,len(Community)): # Goes through each species of the community
        #Simpson's calculation to get the summed portion of the equation
        simp_tot = simp_tot + (Community[i]/N)**2 
    Simpson = 1 - simp_tot # Calc final Simpson's value
    return(Simpson)

#######################################

## Calculate Site Biodiversity ##

#######################################
print("Running script to calculate site level diversity metrics")

# Read in subsetted CSV
print("Reading in csv")
birds = pandas.read_csv('../Data/Birds_abund.csv', sep = ',', header = 0, low_memory=False)

# Count number of species from each site and stores as series
sites=birds['SSBS'].value_counts()
print("The number of sites is:", len(sites))
print("Removing sites with fewer than 20 species...")
# Removes sites that have fewer than 20 species from overall db
birds['site_counts'] = birds.groupby('SSBS')['SSBS'].transform('count')
birds = birds[birds.site_counts >= 20]
print("The number of sites is now:", len(birds['SSBS'].value_counts()))

# Make a subsetted df with pertinent information for each site
print("Creating dataframe for site level diversity metrics...")
birds_sites=birds.loc[:,['SSBS','Sample_midpoint','Habitat_patch_area_square_metres',\
    'Predominant_land_use','Use_intensity','Km_to_nearest_edge_of_habitat',\
    'Years_since_fragmentation_or_conversion','Longitude',\
    'Latitude','Country','Biome','site_counts']]
# Condense each site into one row (all individual species information has been removed)
birds_sites=birds_sites.groupby('SSBS').max()
# Rename site_counts to Richness as it is a count of species
birds_sites=birds_sites.drop('site_counts',axis=1)

## Calculate diversity metrics per site ##
print("Calculating diversity metrics...")
# Create a list of site names
site_names = birds['SSBS'].value_counts().index.values.tolist()
# Create a df to fill with diversity metrics
site_diversity = pandas.DataFrame(columns=['SSBS','Shannon','Simpson'])
# add site names to df
site_diversity['SSBS'] = site_names
# For each site, calculate diversity
for i in range(0,len(site_names)):
    community = list(birds.loc[birds['SSBS']==site_names[i]].Measurement)
    site_diversity.loc[site_diversity['SSBS'] == site_names[i],'Shannon'] = Shan(community)
    site_diversity.loc[site_diversity['SSBS'] == site_names[i],'Simpson'] = Simp(community)

# merge diversity df with subsetted df
print("Creating final df")
birds_sites=pandas.merge(birds_sites, site_diversity, on=['SSBS'])

print("Saving to csv")
birds_sites.to_csv('../Data/Birds_diversity.csv', index=False) #Save to csv
print("Finished calculating diversity metrics")