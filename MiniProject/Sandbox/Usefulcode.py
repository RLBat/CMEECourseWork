import pandas

df = pandas.read_csv('../Data/Raw/resource.csv', sep = ',', header = 0)

df.columns #Gives a list of column names

# Gives number of unique kingdoms
df['Kingdom'].nunique()

#Counts number of data for each phyla
print("Investigate df for phyla")
df.groupby(['Phylum']).size()