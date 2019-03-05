## Script to fit and select the glmm models plus build plots for Miniproject

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

## Packages ##

library(lme4)
library(ggplot2)
library(ggpubr)
#require(car)
#require(MASS)

## Load Data ##

Birds <- read.csv("../Data/Birds_diversity.csv")

#################################

## MODEL FITTING AND SELECTION ##

#################################

# Correct a few incorrect data types
print("Assigning data types")
Birds$Year<-as.factor(Birds$Year)
Birds$Latitude<-abs(Birds$Latitude)
Birds$Predominant_land_use<-as.factor(Birds$Predominant_land_use)

## Geographic Bias ##

print("Testing for geographic bias")
#Linear mixed model without weights
not_weighted<-lmer(log(Richness) ~ log(GDP) + Latitude + Predominant_land_use + (1|Source_ID), data=Birds)
#Linear mixed model with weights
weighted<-lmer(log(Richness) ~ log(GDP) + Latitude + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)

anova(not_weighted,weighted)

## Diversity Metrics ##

print("Checking influence of Habitat patch area")

Birds_subset <- subset(Birds, Birds$Habitat_patch_area_square_metres!="NA")
Birds_subset <- subset(Birds_subset, Birds_subset$Habitat_patch_area_square_metres!=-1)
with_area<-lmer(log(Richness) ~ log(GDP) + Latitude + Predominant_land_use + log(Habitat_patch_area_square_metres) + (1|Source_ID), data=Birds_subset, weights = Geog_weight)
without_area<-lmer(log(Richness) ~ log(GDP) + Latitude + Predominant_land_use + (1|Source_ID), data=Birds_subset, weights = Geog_weight)

area<-anova(with_area, without_area)
print("Checking land-use distribution in subset")
table(Birds_subset$Predominant_land_use)

print("Including habitat patch area does explain more of the data and is significantly different to null model, however the land-use classes are to skewed.")

print("Calculating AICs for Species Richness models...")

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

anov_Rich<-anova(Richness_max, Richness_null, Richness_gdp, Richness_land, Richness_latt, Richness_gdp_land, Richness_gdp_latt, Richness_latt_land)

print("Calculating AICs for Simpson's Measure models...")

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

anov_Simp<-anova(Simpson_max, Simpson_null, Simpson_gdp, Simpson_land, Simpson_latt, Simpson_gdp_land, Simpson_gdp_latt, Simpson_latt_land)

print("Calculating AICs for Shannon's Index models...")

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

anov_Shan<-anova(Shannon_max, Shannon_null, Shannon_gdp, Shannon_land, Shannon_latt, Shannon_gdp_land, Shannon_gdp_latt, Shannon_latt_land)

#####################

#### PLOTTING ####

#####################

# plot(log(Richness)~log(Habitat_patch_area_square_metres),data=Birds)
# plot(log(Richness)~Predominant_land_use,data=Birds)
# plot(log(Richness)~log(GDP),data=Birds)

## Land Use Intensity ##


# p1<-ggplot(Birds, aes(x=Predominant_land_use, y=log(Richness), fill=Predominant_land_use)) + geom_boxplot()
# p1<-p1+scale_fill_manual(values=c("darkcyan","lightskyblue","gold", "orange","firebrick4"))
# p1<-p1+scale_x_discrete('Predominant land use', labels=c("Primary","Secondary","Plantation","Agriculture","Urban"))
# p1<-p1+labs(fill='Predominant Land-Use')
p1<-ggplot(Birds)+aes(x=Predominant_land_use, y=log(Richness), fill=Predominant_land_use) + geom_boxplot()
p1<-p1+scale_fill_manual(values=c("darkcyan","lightskyblue","gold", "orange","firebrick4"), labels = c("Primary","Secondary","Plantation","Agriculture","Urban"))
p1<-p1+scale_x_discrete('Predominant land use', labels=c("Primary","Secondary","Plantation","Agriculture","Urban"))
p1<-p1+scale_y_continuous("Species Richness (log)")
p1<-p1+theme(axis.text.x = element_text(size=14,angle = 50, vjust = 0.7, hjust=1), 
    axis.title.x = element_text(size=14,vjust=-7), 
    axis.title.y = element_text(size=14, vjust=5),
    axis.text.y = element_text(size=14),
    plot.margin = margin(10, 10, 40, 30))
p1<-p1+labs(fill='Predominant Land-Use')



p2<-ggplot(Birds)+aes(x=Predominant_land_use, y=log(Simpson), fill=Predominant_land_use) + geom_boxplot()
p2<-p2+scale_fill_manual(values=c("darkcyan","lightskyblue","gold", "orange","firebrick4"), labels = c("Primary","Secondary","Plantation","Agriculture","Urban"))
p2<-p2+scale_x_discrete('Predominant land use', labels=c("Primary","Secondary","Plantation","Agriculture","Urban"))
p2<-p2+scale_y_continuous("Reciprocal Simpson's Diversity Index (log)")
p2<-p2+theme(axis.text.x = element_text(size=14,angle = 50, vjust = 0.7, hjust=1), 
    axis.title.x = element_text(size=14,vjust=-7), 
    axis.title.y = element_text(size=14, vjust=5),
    axis.text.y = element_text(size=14),
    plot.margin = margin(10, 10, 40, 30))
p2<-p2+labs(fill='Predominant Land-Use')

#c("Primary","Secondary","Plantation","Agriculture","Urban")
# p3<-ggplot(Birds)+aes(x=Predominant_land_use, y=Shannon, fill=Predominant_land_use) + geom_boxplot()
# p3<-p3+scale_fill_manual(values=c("darkcyan","lightskyblue","gold", "orange","firebrick4"))
# p3<-p3+scale_x_discrete('Predominant land use', labels=c("Primary","Secondary","Plantation","Agriculture","Urban"))
# p3<-p3+labs(fill='Predominant Land-Use')
p3<-ggplot(Birds)+aes(x=Predominant_land_use, y=Shannon, fill=Predominant_land_use) + geom_boxplot()
p3<-p3+scale_fill_manual(values=c("darkcyan","lightskyblue","gold", "orange","firebrick4"), labels = c("Primary","Secondary","Plantation","Agriculture","Urban"))
p3<-p3+scale_x_discrete('Predominant land use', labels=c("Primary","Secondary","Plantation","Agriculture","Urban"))
p3<-p3+scale_y_continuous("Shannon's Measure of Diversity (log)")
p3<-p3+theme(axis.text.x = element_text(size=14,angle = 50, vjust = 0.7, hjust=1), 
    axis.title.x = element_text(size=14,vjust=-7), 
    axis.title.y = element_text(size=14, vjust=5),
    axis.text.y = element_text(size=14),
    plot.margin = margin(10, 10, 40, 30))
p3<-p3+labs(fill='Predominant Land-Use')

p<-ggarrange(p1, p2,p3, ncol=3, nrow=1, common.legend= TRUE, legend = "bottom")



## GDP ##

p1<-ggplot(Birds, aes(x=log(GDP), y=log(Richness), colour=log(GDP))) + geom_point()
p1<-p1+scale_fill_manual(values=c("darkcyan","lightskyblue","gold", "orange","firebrick4"))
#p<-p+geom_point()
p1

## Lattitude ##




par(mfrow = c(2,2))
plot(log(Richness)~Predominant_land_use,data=Birds)
plot(Shannon~Predominant_land_use,data=Birds)
plot(log(Simpson)~Predominant_land_use,data=Birds)
