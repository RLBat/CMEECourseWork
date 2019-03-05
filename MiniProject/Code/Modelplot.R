## Script to fit and select the glmm models plus build plots for Miniproject

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

## Packages ##

library(lme4)
library(ggplot2)
#require(car)
#require(MASS)

## Load Data ##

Birds <- read.csv("../Data/Birds_diversity.csv")

############

# Correct a few incorrect data types
print("Assigning data types")
Birds$Year<-as.factor(Birds$Year)
Birds$Latitude<-abs(Birds$Latitude)

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

anova(with_area, without_area)

table(Birds$Predominant_land_use)

print("Including habitat patch area does explain more of the data and is significantly different to null model, however the land-use classes are to skewed.")

print("Calculating AICs for Species Richness models...")

Richness_max<-lmer(log(Richness) ~ log(GDP) + Latitude + Predominant_land_use + log(Habitat_patch_area_square_metres) + (1|Source_ID), data=Birds, weights = Geog_weight)

Richness_null<-lmer(log(Richness) ~ (1|Source_ID), data=Birds, weights = Geog_weight)

#one factor
Richness_gdp<-lmer(log(Richness) ~ log(GDP)+ (1|Source_ID), data=Birds, weights = Geog_weight)
Richness_latt<-lmer(log(Richness) ~ Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Richness_land<-lmer(log(Richness) ~ Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Richness_area<-lmer(log(Richness) ~ log(Habitat_patch_area_square_metres) + (1|Source_ID), data=Birds, weights = Geog_weight)
#two factors
Richness_gdp_land<-lmer(log(Richness) ~ log(GDP) + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Richness_gdp_latt<-lmer(log(Richness) ~ log(GDP) + Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Richness_latt_land<-lmer(log(Richness) ~ Latitude + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Richness_area_latt<-lmer(log(Richness) ~ Latitude + log(Habitat_patch_area_square_metres) + (1|Source_ID), data=Birds, weights = Geog_weight)
Richness_area_land<-lmer(log(Richness) ~ log(Habitat_patch_area_square_metres) + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Richness_area_gdp<-lmer(log(Richness) ~ log(Habitat_patch_area_square_metres) + log(GDP) + (1|Source_ID), data=Birds, weights = Geog_weight)
#three factors
Richness_area_gdp_land<-lmer(log(Richness) ~ log(Habitat_patch_area_square_metres) + log(GDP) + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Richness_area_gdp_latt<-lmer(log(Richness) ~ log(Habitat_patch_area_square_metres) + log(GDP) + Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Richness_area_land_latt<-lmer(log(Richness) ~ log(Habitat_patch_area_square_metres) + Predominant_land_use + Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Richness_gdp_land_latt<-lmer(log(Richness) ~ log(GDP) + Predominant_land_use + Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)

anov_Rich<-anova(Richness_max, Richness_null, Richness_gdp, Richness_land, Richness_latt,Richness_area, Richness_area_gdp, Richness_area_land, Richness_area_latt,
     Richness_gdp_land, Richness_gdp_latt, Richness_latt_land, Richness_area_gdp_land, Richness_area_gdp_latt, Richness_area_land_latt, Richness_gdp_land_latt)

print("Calculating AICs for Simpson's Measure models...")

Simpson_max<-lmer((1-Simpson) ~ log(GDP) + Latitude + Predominant_land_use + log(Habitat_patch_area_square_metres) + (1|Source_ID), data=Birds, weights = Geog_weight)

Simpson_null<-lmer((1-Simpson) ~ (1|Source_ID), data=Birds, weights = Geog_weight)

#one factor
Simpson_gdp<-lmer((1-Simpson) ~ log(GDP)+ (1|Source_ID), data=Birds, weights = Geog_weight)
Simpson_latt<-lmer((1-Simpson) ~ Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Simpson_land<-lmer((1-Simpson) ~ Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Simpson_area<-lmer((1-Simpson) ~ log(Habitat_patch_area_square_metres) + (1|Source_ID), data=Birds, weights = Geog_weight)
#two factors
Simpson_gdp_land<-lmer((1-Simpson) ~ log(GDP) + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Simpson_gdp_latt<-lmer((1-Simpson) ~ log(GDP) + Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Simpson_latt_land<-lmer((1-Simpson) ~ Latitude + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Simpson_area_latt<-lmer((1-Simpson) ~ Latitude + log(Habitat_patch_area_square_metres) + (1|Source_ID), data=Birds, weights = Geog_weight)
Simpson_area_land<-lmer((1-Simpson) ~ log(Habitat_patch_area_square_metres) + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Simpson_area_gdp<-lmer((1-Simpson) ~ log(Habitat_patch_area_square_metres) + log(GDP) + (1|Source_ID), data=Birds, weights = Geog_weight)
#three factors
Simpson_area_gdp_land<-lmer((1-Simpson) ~ log(Habitat_patch_area_square_metres) + log(GDP) + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Simpson_area_gdp_latt<-lmer((1-Simpson) ~ log(Habitat_patch_area_square_metres) + log(GDP) + Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Simpson_area_land_latt<-lmer((1-Simpson) ~ log(Habitat_patch_area_square_metres) + Predominant_land_use + Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Simpson_gdp_land_latt<-lmer((1-Simpson) ~ log(GDP) + Predominant_land_use + Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)

anov_Simp<-anova(Simpson_max, Simpson_null, Simpson_gdp, Simpson_land, Simpson_latt,Simpson_area, Simpson_area_gdp, Simpson_area_land, Simpson_area_latt,
     Simpson_gdp_land, Simpson_gdp_latt, Simpson_latt_land, Simpson_area_gdp_land, Simpson_area_gdp_latt, Simpson_area_land_latt, Simpson_gdp_land_latt)

print("Calculating AICs for Shannon's Index models...")

Shannon_max<-lmer(Shannon ~ log(GDP) + Latitude + Predominant_land_use + log(Habitat_patch_area_square_metres) + (1|Source_ID), data=Birds, weights = Geog_weight)

Shannon_null<-lmer(Shannon ~ (1|Source_ID), data=Birds, weights = Geog_weight)

#one factor
Shannon_gdp<-lmer(Shannon ~ log(GDP)+ (1|Source_ID), data=Birds, weights = Geog_weight)
Shannon_latt<-lmer(Shannon ~ Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Shannon_land<-lmer(Shannon ~ Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Shannon_area<-lmer(Shannon ~ log(Habitat_patch_area_square_metres) + (1|Source_ID), data=Birds, weights = Geog_weight)
#two factors
Shannon_gdp_land<-lmer(Shannon ~ log(GDP) + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Shannon_gdp_latt<-lmer(Shannon ~ log(GDP) + Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Shannon_latt_land<-lmer(Shannon ~ Latitude + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Shannon_area_latt<-lmer(Shannon ~ Latitude + log(Habitat_patch_area_square_metres) + (1|Source_ID), data=Birds, weights = Geog_weight)
Shannon_area_land<-lmer(Shannon ~ log(Habitat_patch_area_square_metres) + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Shannon_area_gdp<-lmer(Shannon ~ log(Habitat_patch_area_square_metres) + log(GDP) + (1|Source_ID), data=Birds, weights = Geog_weight)
#three factors
Shannon_area_gdp_land<-lmer(Shannon ~ log(Habitat_patch_area_square_metres) + log(GDP) + Predominant_land_use + (1|Source_ID), data=Birds, weights = Geog_weight)
Shannon_area_gdp_latt<-lmer(Shannon ~ log(Habitat_patch_area_square_metres) + log(GDP) + Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Shannon_area_land_latt<-lmer(Shannon ~ log(Habitat_patch_area_square_metres) + Predominant_land_use + Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)
Shannon_gdp_land_latt<-lmer(Shannon ~ log(GDP) + Predominant_land_use + Latitude + (1|Source_ID), data=Birds, weights = Geog_weight)

anov_Shan<-anova(Shannon_max, Shannon_null, Shannon_gdp, Shannon_land, Shannon_latt,Shannon_area, Shannon_area_gdp, Shannon_area_land, Shannon_area_latt,
     Shannon_gdp_land, Shannon_gdp_latt, Shannon_latt_land, Shannon_area_gdp_land, Shannon_area_gdp_latt, Shannon_area_land_latt, Shannon_gdp_land_latt)

########################################



plot(log(Richness)~log(Habitat_patch_area_square_metres),data=Birds)
plot(log(Richness)~Predominant_land_use,data=Birds)
plot(log(Richness)~log(GDP),data=Birds)



par(mfrow = c(2,2))
plot(log(Richness)~Predominant_land_use,data=Birds)
plot(Shannon~Predominant_land_use,data=Birds)
plot(Simpson~Predominant_land_use,data=Birds)
plot((1-Simpson)~Predominant_land_use,data=Birds)

plot(lm(log(Richness)~Predominant_land_use,data=Birds))
plot(lm(Shannon~Predominant_land_use,data=Birds))
lm(Simpson~Predominant_land_use,data=Birds)


plot(Richness~Latitude,data=Birds)

lm(Richness ~ Predominant_land_use, data=Birds)
