require ("tidyr")


help<-as.matrix(read.csv("../Data/Raw/resource.csv", header=T))

colnames(help) #68
nrow(help) #Nearly 4 million rows

unique(help[,16]) #Number of unique study sites
unique(help[,41]) #Wilderness area??
unique(help[,31]) #Predominant land use
sum((help[,31] == "Cannot decide")) # Number of data points with no predominant land use
unique(help[,46])

# Create a df of study site and number of data points
n = aggregate(data.frame(count = help[,16]), list(value = help[,16]), length)

# Create a df of countries and number of data points
n = aggregate(data.frame(count = help[,41]), list(value = help[,41]), length)

############################

Study1<- subset(help, help[,2]=="DI1_2013__deLima")
colnames(Study1)
unique(Study1[,16])
unique(Study1[,41]) #country
length(unique(help[,2]))
##############################

Smaller<-(head(help, 500000))
#write.csv(Smaller, file="../Data/PREDICTS_Subset.csv")
Smaller<-as.matrix(read.csv("../Data/Raw/PREDICTS_Subset.csv", header=T))
Smaller<-subset(Smaller, Smaller[,31]!="Cannot decide") 
Smaller<-subset(Smaller, Smaller[,64]!="") # Remove data points that aren't IDd to species
colnames(Smaller)



sum(Smaller[,16]==" 52")
unique(Smaller[,65] with(Smaller[,16]==" 52"))
################################

# Subset the data to only include data from the UK (down to 56,215 data points)
UK <- subset(help, help[,41]=="United Kingdom")

#Write subsetted data to a csv - nicer to work with!!!
#write.csv(UK, file="PREDICTS16UK.csv")

UK<-as.matrix(read.csv("../Data/PREDICTS16UK.csv", header=T))

#Number of different sites
unique(UK[,17])

# Number of different land intensity uses
unique(UK[,34])

# Different land use types
unique(UK[,32])

# Get rid of species with no land intensity class
UK <- subset(UK, UK[,33]!="Cannot decide")

UKsmol <- data.frame(UK[,1], UK[,15], UK[,34])
names(UKsmol) <- c("ID", "Taxon", "LandUse")
UKs <- spread(UKsmol, LandUse, Taxon)
head(UKs)
