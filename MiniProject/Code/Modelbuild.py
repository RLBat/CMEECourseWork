#!/usr/bin/env python3

""" Calculate diversity metrics and produce a csv suitable for 
    the modelling process """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import pandas
import numpy as np

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
        shan_tot = shan_tot + ((Community[i]/N)*np.log((Community[i]/N)))
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
        simp_tot = simp_tot + ((Community[i]/N)**2)
    Simpson = 1/simp_tot # Calc final Simpson's value
    return(Simpson)

#######################################

## Calculate Site Biodiversity ##

#######################################
print("Running script to calculate site level diversity metrics and geographic bias")

# Read in subsetted CSV
print("Reading in csv")
birds = pandas.read_csv('../Data/Birds_abund.csv', sep = ',', header = 0, low_memory=False)

# Make a subsetted df with pertinent information for each site
print("Creating dataframe for site level diversity metrics...")
birds_sites=birds.loc[:,['Source_ID','SSBS','Sample_midpoint','Habitat_patch_area_square_metres',\
    'Predominant_land_use','Use_intensity','Km_to_nearest_edge_of_habitat',\
    'Years_since_fragmentation_or_conversion','Longitude',\
    'Latitude','Country','Biome','UN_subregion','Realm','site_counts']]
# Condense each site into one row (all individual species information has been removed)
birds_sites=birds_sites.groupby('SSBS').max()
# Rename site_counts to Richness as it is a count of species
birds_sites.rename(columns={'site_counts':'Richness'},inplace = True)

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
print("Merging dataframes")
birds_sites=pandas.merge(birds_sites, site_diversity, on=['SSBS'])

# change sample_midpoint to only show year
print("Converting sample date to year only")
birds_sites['Sample_midpoint'] = birds_sites['Sample_midpoint'].str[0:4]
birds_sites.rename(columns={'Sample_midpoint':'Year'},inplace = True)

# Read in gdp df
print("Reading in dataframe with GPD data")
gdp = pandas.read_csv('../Data/Country_GDP.csv', sep = ',', header = 0, low_memory=False)

# Calculate country gdps
print("Calculating GDP for each country for year of sampling")
birds_sites['GDP'] = np.nan #Creates a column of nans
for i in range(0,len(birds_sites)):
    #Fetches the GDP for that country in that year and places in df
    try:
        birds_sites.iloc[i,17] = gdp.loc[gdp['Country_Name']==birds_sites.iloc[i,10],birds_sites.iloc[i,2]].item()
    except:
        birds_sites.iloc[i,17] = np.nan
birds_sites = birds_sites.dropna(subset=['GDP'])
birds_sites['GDP'] = birds_sites['GDP'].apply(lambda x: x/1000000) #convert to $

# Assign values to land use classes
print("Assigning land use intensity scores")
land_use = {'Primary vegetation': 1,'Mature secondary vegetation': 2,'Intermediate secondary vegetation': 2,\
    'Secondary vegetation (indeterminate age)':2,'Young secondary vegetation':2,\
    'Plantation forest':3,'Pasture':4,'Cropland':4,'Urban':5}
birds_sites.replace({'Predominant_land_use': land_use},inplace = True)

#Calc geographic bias
print("Weighting sites based on geograpic bias")
#realm_eq=len(birds)/(birds['Realm'].nunique()) #Work out no. of studies if split equally
weights = birds_sites['Realm'].value_counts() #Series of realms and no. of studies
weights = weights.reset_index() #Change index to column
weights.rename(columns={'index':'Realm','Realm':'Value'}, inplace=True)
birds_sites['Geog_weight'] = np.nan #create column of nans

max = weights.iloc[weights['Value'].idxmax(),1]

for i in range(len(birds_sites)):
    #Add weight from weights to main df
    birds_sites.iloc[i,18] = max/weights.loc[weights['Realm']==birds_sites.iloc[i,13]].iloc[0,1]

# Save csv
print("Saving to csv")
birds_sites.to_csv('../Data/Birds_diversity.csv', index=False) #Save to csv
print("Finished calculating diversity metrics and bias")

#birds = pandas.read_csv('../Data/Birds_diversity.csv', sep = ',', header = 0, low_memory=False)
