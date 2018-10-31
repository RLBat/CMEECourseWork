## Looks at the correlation between temperatures in FLorida in subsequent years
## Compares these correlations to those between non-sequential years to determine
## how independant they are. 

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

## Packages ##

require(ggplot2)

## Load Data ##

load("../Data/KeyWestAnnualMeanTemperature.RData")

################

summary(ats) # Gives the main descriptive stats for the data
#plot(ats) # Plots a scatter plot for the yearly temps

#cor(ats$Year, ats$Temp, method = c("spearman")) # Produces the spearman's rank correlation coefficient


v <- ats$Temp
v1 <- ats$Temp[2:100]; v1 <- c(v1, ats$Temp[1])
real<-(cor(v, v1))


## Attempt to create random sampling via loops. Non-functional
# Random_temps <- function(){
#     corr<-c()
#     for (i in 1:10000){
#         browser()
#         atsi<-ats[sample(nrow(ats)),]
#         r <- atsi$Temp
#         r1 <- atsi$Temp[2:100]; r1 <- c(r1, atsi$Temp[1])
#         corr[i]<-cor(r,r1)
#         print(corr)
#     }
# return(corr) 
# }

# Creates a list of the correlation coefficients for 10000 randomly re-arranged temperatures
Simulated_corrs<-replicate(10000, 
    {
        atsi<-ats[sample(nrow(ats)),]
        r <- atsi$Temp
        r1 <- atsi$Temp[2:100]; r1 <- c(r1, atsi$Temp[1])
        cor(r,r1)
    })


print(sprintf("There are %s simulated values out of %s that are larger than the value obtained from the real data.", 
sum(Simulated_corrs > real), length(Simulated_corrs)))
print(sprintf("The approximate p-value is therefore: %g", sum(Simulated_corrs > real)/length(Simulated_corrs)))

## Uses base R to make a histogram with a line for the real value
# plot(Simulated_corrs)
# hist(Simulated_corrs, xlim=c(-0.5, 0.4), xaxt="n")
# axis(side=1, at=c(-0.6, -0.4, -0.2, 0, 0.2, 0.4))
# abline(v=real)

## Uses ggplots to create a histogram with a line for the real value
p<-qplot(Simulated_corrs, geom="histogram", ylab="Frequency", xlab="Simulated Correlation Coefficients")+
theme_bw()+
geom_vline(xintercept= real)+
geom_text(aes(x=real-0.02, y=600, label="Real correlation coefficient", angle=90))+
theme(plot.margin=unit(c(2,2,2,2), "cm"))

pdf("../Output/TAutoCorr.pdf", # Open blank pdf page using a relative path
    9, 11.7)
# Prints the created ggplot to the pdf
print(p)
graphics.off()