## Script to fit and select the glmm models plus build plots for Miniproject

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())
graphics.off()

## Packages ##

library(lme4)
library(ggplot2)
library(ggpubr)
library(xtable)

## Load Data ##

Birds <- read.csv("../Data/Birds_diversity.csv")

#################################

## MODEL FITTING AND SELECTION ##

#################################

# Correct a few incorrect data types
print("Assigning data types")
Birds$Year<-as.factor(Birds$Year)
Birds$Latitude<-abs(Birds$Latitude)
Birds$Predominant_land_use<-as.integer(Birds$Predominant_land_use)

## Check normality ##

print("Checking diversity metrics for normality")
#Create q-q plots for each metric

Rich_norm<-ggqqplot(Birds$Richness) #not normal, check log
LogRich_norm<-ggqqplot(log(Birds$Richness))

Simp_norm<-ggqqplot(Birds$Simpson) #not normal, check log
LogSimp_norm<-ggqqplot(log(Birds$Simpson))

Shann_norm<-ggqqplot(Birds$Shannon)

## Geographic Bias ##

print("Testing for geographic bias")
#Linear mixed model without weights
not_weighted<-lmer(log(Richness) ~ log(GDP) + Latitude + Predominant_land_use + (1|Source_ID), data=Birds)
#Linear mixed model with weights
weighted<-lmer(log(Richness) ~ log(GDP) + Latitude + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)

#Check difference
weights<-anova(not_weighted,weighted)

## Site Random Factor ##

#With random effect
site_effect<-lmer(log(Richness) ~ log(GDP) + Latitude + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
#Without random effect
no_site_effect<-lm(log(Richness) ~ log(GDP) + Latitude + Predominant_land_use, data=Birds, weights = Geog_weight)

#Check difference
random<-anova(site_effect, no_site_effect)

## Habitat Patch Area ##

print("Checking influence of Habitat patch area")

#Remove NA values and invalid values for habitat area
Birds_subset <- subset(Birds, Birds$Habitat_patch_area_square_metres!="NA")
Birds_subset <- subset(Birds_subset, Birds_subset$Habitat_patch_area_square_metres!=-1)

#Create null and test linear models
with_area<-lmer(log(Richness) ~ log(GDP) + Latitude + Predominant_land_use + log(Habitat_patch_area_square_metres) + (1|Source_ID), data=Birds_subset, weights = Geog_weight)
without_area<-lmer(log(Richness) ~ log(GDP) + Latitude + Predominant_land_use + (1|Source_ID), data=Birds_subset, weights = Geog_weight)

#Check difference
area<-anova(with_area, without_area)

print("Checking land-use distribution in subset")
table(Birds_subset$Predominant_land_use)#Non-even land-use pattern

print("Including habitat patch area does explain more of the data and is significantly different to null model,
\n however the land-use classes are too skewed for it to be useable.")

## Diversity Metrics ##

print("Model fitting and selection")

#Create empty df with variable combinations as index
AIC_Values<- data.frame(row.names = c("Null Model", "GDP", "Land-use", "Latitude", "GDP + Land-use", "GDP + Latitude",
 "Latitude + Land-use", "Maximal Model"), check.rows = FALSE, check.names = TRUE, stringsAsFactors = default.stringsAsFactors())

print("Calculating AICs for Species Richness models")

#Fit Richness linear mixed models
Richness_max<-lmer(log(Richness) ~ log(GDP) + Latitude + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)

Richness_null<-lmer(log(Richness) ~ (1|Source_ID), data=Birds, weights = Geog_weight)

#one factor
Richness_gdp<-lmer(log(Richness) ~ log(GDP)+ (1|Source_ID), data=Birds, weights = Geog_weight)
Richness_latt<-lmer(log(Richness) ~ Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Richness_land<-lmer(log(Richness) ~ Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
#two factors
Richness_gdp_land<-lmer(log(Richness) ~ log(GDP) + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Richness_gdp_latt<-lmer(log(Richness) ~ log(GDP) + Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Richness_latt_land<-lmer(log(Richness) ~ Latitude + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)

#Create list of models and calculate AIC of each
Richness_lm <- list(Richness_null, Richness_gdp, Richness_land, Richness_latt, Richness_gdp_land, Richness_gdp_latt, Richness_latt_land, Richness_max)
# Add richness AIC values to df
AIC_Values['Richness'] =  sapply(X = Richness_lm, FUN = AIC)

print("Calculating AICs for Simpson's Measure models")

#Fit Simpson linear mixed models
Simpson_max<-lmer(log(Simpson) ~ log(GDP) + Latitude + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)

Simpson_null<-lmer(log(Simpson) ~ (1|Source_ID), data=Birds, weights = Geog_weight)

#one factor
Simpson_gdp<-lmer(log(Simpson) ~ log(GDP)+ (1|Source_ID), data=Birds, weights = Geog_weight)
Simpson_latt<-lmer(log(Simpson) ~ Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Simpson_land<-lmer(log(Simpson) ~ Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
#two factors
Simpson_gdp_land<-lmer(log(Simpson) ~ log(GDP) + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Simpson_gdp_latt<-lmer(log(Simpson) ~ log(GDP) + Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Simpson_latt_land<-lmer(log(Simpson) ~ Latitude + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)

#Create list of models and calculate AIC of each
Simpson_lm<-list(Simpson_null, Simpson_gdp, Simpson_land, Simpson_latt, Simpson_gdp_land, Simpson_gdp_latt, Simpson_latt_land, Simpson_max)
# Add Simpson AIC values to df
AIC_Values['Simpson'] = sapply(X = Simpson_lm, FUN = AIC)

print("Calculating AICs for Shannon's Index models")

#Fit Shannon linear mixed models
Shannon_max<-lmer(Shannon ~ log(GDP) + Latitude + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)

Shannon_null<-lmer(Shannon ~ (1|Source_ID), data=Birds, weights = Geog_weight)

#one factor
Shannon_gdp<-lmer(Shannon ~ log(GDP)+ (1|Source_ID), data=Birds, weights = Geog_weight)
Shannon_latt<-lmer(Shannon ~ Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Shannon_land<-lmer(Shannon ~ Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
#two factors
Shannon_gdp_land<-lmer(Shannon ~ log(GDP) + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Shannon_gdp_latt<-lmer(Shannon ~ log(GDP) + Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Shannon_latt_land<-lmer(Shannon ~ Latitude + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)

#Create list of models and calculate AIC of each
Shannon_lm<-list(Shannon_null, Shannon_gdp, Shannon_land, Shannon_latt, Shannon_gdp_land, Shannon_gdp_latt, Shannon_latt_land, Shannon_max)
# Add Shannon AIC values to df
AIC_Values['Shannon'] = sapply(X = Shannon_lm, FUN = AIC)

print("Making table of AIC values")
AIC_min<-min(AIC_Values) #Find minimum AIC value
AIC_Values<-AIC_Values-AIC_min #Make all values relative
AIC_Values<-round(AIC_Values) #Round AIC values to nearest int
#Find index of minimum value for Shannon and Simpson
simp_min=which.min(AIC_Values$Simpson)
shan_min=which.min(AIC_Values$Shannon)
#Add an "*" to the best fitting model for Richness 
AIC_Values$Richness[which.min(AIC_Values$Richness)]=paste(AIC_Values$Richness[which.min(AIC_Values$Richness)],"*",sep="")
#Place Simpson relative values in brackets after the overall relative value
AIC_Values$Simpson=paste(round(AIC_Values$Simpson),"(",round(AIC_Values$Simpson-min(AIC_Values$Simpson)),")",sep="")
#Add an "*" to the best fitting model for Simpson 
AIC_Values$Simpson[simp_min]=paste(AIC_Values$Simpson[simp_min],"*",sep="")
#Place Shannon relative values in brackets after the overall relative value
AIC_Values$Shannon=paste(round(AIC_Values$Shannon),"(",round(AIC_Values$Shannon-min(AIC_Values$Shannon)),")",sep="")
#Add an "*" to the best fitting model for Shannon 
AIC_Values$Shannon[shan_min]=paste(AIC_Values$Shannon[shan_min],"*",sep="")

#Create AIC values table
AIC_table<-print(xtable(AIC_Values),floating=FALSE,latex.environments=NULL,booktabs=TRUE)

#####################

#### PLOTTING ####

#####################

## Land Use Intensity ##

print("Creating graphics")

#Set land-use intensity as a factor for plotting
Birds$Predominant_land_use<-as.factor(Birds$Predominant_land_use)

# Create bar plot of land-use intensity for species richness 
p1<-ggplot(Birds)+aes(x=Predominant_land_use, y=log(Richness), fill=Predominant_land_use) + geom_boxplot()
p1<-p1+scale_fill_manual(values=c("darkcyan","lightskyblue","gold", "orange","firebrick4"), labels = c("Primary","Secondary","Plantation","Agriculture","Urban"))
p1<-p1+scale_x_discrete('Predominant land use', labels=c("Primary","Secondary","Plantation","Agriculture","Urban"))
p1<-p1+scale_y_continuous("Species Richness (log)")
p1<-p1+theme(axis.text.x = element_text(size=20,angle = 50, vjust = 0.7, hjust=1), 
    axis.title.x = element_text(size=22,vjust=-12), 
    axis.title.y = element_text(size=22, vjust=5),
    axis.text.y = element_text(size=20),
    legend.title = element_text(size=22),
    legend.text = element_text(size=20),
    plot.margin = margin(10, 10, 70, 50))
p1<-p1+labs(fill='Predominant Land-Use')

# Create bar plot of land-use intensity for Simpson's reciprocal index 
p2<-ggplot(Birds)+aes(x=Predominant_land_use, y=log(Simpson), fill=Predominant_land_use) + geom_boxplot()
p2<-p2+scale_fill_manual(values=c("darkcyan","lightskyblue","gold", "orange","firebrick4"), labels = c("Primary","Secondary","Plantation","Agriculture","Urban"))
p2<-p2+scale_x_discrete('Predominant land use', labels=c("Primary","Secondary","Plantation","Agriculture","Urban"))
p2<-p2+scale_y_continuous("Reciprocal Simpson's Diversity Index (log)")
p2<-p2+theme(axis.text.x = element_text(size=20,angle = 50, vjust = 0.7, hjust=1), 
    axis.title.x = element_text(size=22,vjust=-12), 
    axis.title.y = element_text(size=22, vjust=5),
    axis.text.y = element_text(size=20),
    legend.title = element_text(size=22),
    legend.text = element_text(size=20),
    plot.margin = margin(10, 10, 70, 50))
p2<-p2+labs(fill='Predominant Land-Use')

# Create bar plot of land-use intensity for Shannon's diversity measure 
p3<-ggplot(Birds)+aes(x=Predominant_land_use, y=Shannon, fill=Predominant_land_use) + geom_boxplot()
p3<-p3+scale_fill_manual(values=c("darkcyan","lightskyblue","gold", "orange","firebrick4"), labels = c("Primary","Secondary","Plantation","Agriculture","Urban"))
p3<-p3+scale_x_discrete('Predominant land use', labels=c("Primary","Secondary","Plantation","Agriculture","Urban"))
p3<-p3+scale_y_continuous("Shannon's Measure of Diversity")
p3<-p3+theme(axis.text.x = element_text(size=20,angle = 50, vjust = 0.7, hjust=1), 
    axis.title.x = element_text(size=22,vjust=-12), 
    axis.title.y = element_text(size=22, vjust=5),
    axis.text.y = element_text(size=20),
    legend.title = element_text(size=22),
    legend.text = element_text(size=20),
    plot.margin = margin(10, 10, 70, 50))
p3<-p3+labs(fill='Predominant Land-Use')

#Create composite plot
p<-ggarrange(p1, p2,p3, ncol=3, nrow=1, common.legend= TRUE, legend = "bottom", labels=c("A","B","C"))

pdf("../Output/Land_use.pdf", # Open blank pdf page using a relative path
    16, 9)
# Prints the created ggplot to the pdf
print(p)
graphics.off()

print("Finished model fitting and plotting")