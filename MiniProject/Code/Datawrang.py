#!/usr/bin/env python3

""" Initial data inspection and sorting for miniproject work """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import pandas
import math

###########################

## INITIAL DATA HANDLING ##

############################

#Extract data from raw database
df = pandas.read_csv('../Data/Raw/resource.csv', sep = ',', header = 0)

## df has 3,250,404 species over 17,650 sites. Too large for analysis, need to restrict ##

df.columns #Gives a list of column names

# Gives number of unique kingdoms
df['Kingdom'].nunique()

#Counts number of data for each phyla
print("Investigate df for phyla")
df.groupby(['Phylum']).size()

# Creates a new sebsetted df of just chordates
print("Subsetting to only chordates")
vert=df.query('Phylum=="Chordata"')

vert.columns #List column names
# Examine number of data points using each measurement metric
print("Investigate df for measured diversity units")
vert.groupby(['Diversity_metric_unit']).size()
#Subset data to only those using abundance data
print("Subsetting to only studies that collected abundance data")
vert2=vert.query('Diversity_metric=="abundance"')

# Look at classes in dataframe
print("Investigate Classes present in the df")
vert2.groupby(['Class']).size()

# Subset to only include bird data
print("Subsetting to only bird data")
birds = vert2.query('Class=="Aves"')

# Check land use classes
print("Investigate Land use data")
birds.columns
birds.groupby(['Predominant_land_use']).size()
birds.groupby(['Predominant_land_use', 'Use_intensity']).size()

# Remove unclassed land use intensity data
print("Removing all unclassed land uses")
birds = birds.query('Predominant_land_use!="Cannot decide"')


#Removing all species with abundance values of 0
birds = birds[birds.Measurement != 0]

len(birds.Site_number.unique())
len(birds.SS.unique()) #number of study sites
birds.iloc[0] #look at row 1

## Current df has 51,372 species over 3052 sites - much better size for analysis ##

birds.to_csv('../Data/Birds_abund.csv', index=False) #Save to csv

##########################################################

## Calculate Site Biodiversity ##

#################################

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

# Read in subsetted CSV
birds = pandas.read_csv('../Data/Birds_abund.csv', sep = ',', header = 0)

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
birds_sites=birds.loc[:,['SSBS','Sample_midpoint','Habitat_patch_ares_square_metres','Predominant_land_use','Use_intensity','Km_to_nearest_edge_of_habitat','Years_since_fragmentation_or_conversion','Coordinates_method','Longitude','Latitude','Country','Biome','site_counts','Simpson','Shannon']]
birds_sites=birds_sites.groupby('SSBS').max()
birds_sites['Richness'] = birds_sites['site_counts']

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
    index = site_names[i]
    site_diversity.loc['SSBS' == site_names[i],'Shannon'] = Shan(community)
    site_diversity.loc['SSBS' == site_names[i],'Simpson'] = Simp(community)


