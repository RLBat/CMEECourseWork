import pandas

df = pandas.read_csv('../Data/Raw/resource.csv', sep = ',', header = 0)

df.columns #Gives a list of column names

# Gives number of unique kingdoms
df['Kingdom'].nunique()

#Counts number of data for each phyla
print("Investigate df for phyla")
df.groupby(['Phylum']).size()

#gives counts for combined values (e.g minimal pasture, impacted primary forest, etc)
birds.groupby(['Predominant_land_use', 'Use_intensity']).size()

# can use to subset data
df=df.query('Phylum=="Chordata"')

# drop a column entirely
birds_sites=birds_sites.drop('site_counts',axis=1)