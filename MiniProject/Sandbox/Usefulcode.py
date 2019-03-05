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

df.reset_index() #creates a numbered index and shifts current index to a column

#Change all instances of a str to a numeric value
birds_sites.loc[birds_sites['Predominant_land_use'] == 'Primary vegetation'] = 1

#Counts each column based on differing realm
birds.groupby('Realm').count()
birds['Realm'].value_counts() #probably better

 np.unique(c, return_counts=True) # same but with a np array

 ### bootstrapping ###

 realms=list(birds['Realm'])
c=np.random.choice(realms, replace=True, size=len(realms))

realm_orig=birds['Realm'].value_counts()#.values

realm_boot=np.zeros((birds['Realm'].nunique()), dtype=int) #array of 0s
for i in range(100):
    boot=np.random.choice(realms, replace=True, size=len(realms)) #the actual bootstrap (sampling with replacement)
    realm_boot = realm_boot + np.unique(boot, return_counts=True)[1] #convert to an array of values and sum
realm_boot=realm_boot/100

#convert series to dictionary
series.to_dict()
