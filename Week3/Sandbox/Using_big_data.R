MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")
dim(MyDF) #check the size of the data frame you loaded



plot(MyDF$Predator.mass,MyDF$Prey.mass)



plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass))

plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass),pch=20) # Change marker using pch

plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass),pch=20, xlab = "Log(Predator Mass (kg))", ylab = "Log(Prey Mass (kg))") # Add labels


## HISTOGRAMS ##

hist(MyDF$Predator.mass)

hist(log(MyDF$Predator.mass), xlab = "Predator Mass (kg)", ylab = "Count", main = "Histogram of Predators by mass (kg)") # include labels

hist(log(MyDF$Predator.mass),xlab="Predator Mass (kg)",ylab="Count", main = "Histogram of Predators by mass (kg)",
    col = "lightblue", border = "pink") # Change bar and borders colors


## Creates a double plot comparing predators and prey

par(mfcol=c(2,1)) #initialize multi-paneled plot
par(mfg = c(1,1)) # specify which sub-plot to use first 
hist(log(MyDF$Predator.mass),
    xlab = "Predator Mass (kg)", ylab = "Count", 
    col = "lightblue", border = "pink", 
    main = 'Predator') # Add title
par(mfg = c(2,1)) # Second sub-plot
hist(log(MyDF$Prey.mass),
    xlab="Prey Mass (kg)",ylab="Count", 
    col = "lightgreen", border = "pink", 
    main = 'prey')

## Overlaps the predator/prey plots

hist(log(MyDF$Predator.mass), # Predator histogram
    xlab="Body Mass (kg)", ylab="Count", 
    col = rgb(1, 0, 0, 0.5), # Note 'rgb', fourth value is transparency
    main = "Predator-prey size Overlap") 
hist(log(MyDF$Prey.mass), col = rgb(0, 0, 1, 0.5), add = T) # Plot prey
legend('topleft',c('Predators','Prey'),   # Add legend
    fill=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5))) # Define legend colors

## BOXPLOTS ##

boxplot(log(MyDF$Predator.mass), xlab = "Location", ylab = "Predator Mass", main = "Predator mass")

# Sorts mass by location
boxplot(log(MyDF$Predator.mass) ~ MyDF$Location, # Why the tilde?
    xlab = "Location", ylab = "Predator Mass",
    main = "Predator mass by location")


boxplot(log(MyDF$Predator.mass) ~ MyDF$Type.of.feeding.interaction,
    xlab = "Location", ylab = "Predator Mass",
    main = "Predator mass by feeding interaction type")

## COMBINED PLOTS ##

par(fig=c(0,0.8,0,0.8)) # specify figure size as proportion
 plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass), xlab = "Predator Mass (kg)", ylab = "Prey Mass (kg)") # Add labels
 par(fig=c(0,0.8,0.4,1), new=TRUE)
 boxplot(log(MyDF$Predator.mass), horizontal=TRUE, axes=FALSE)
 par(fig=c(0.55,1,0,0.8),new=TRUE)
 boxplot(log(MyDF$Prey.mass), axes=FALSE)
 mtext("Fancy Predator-prey scatterplot", side=3, outer=TRUE, line=-3)

 ## SAVING PLOTS AS PDFS ##

pdf("../Output/Pred_Prey_Overlay.pdf", # Open blank pdf page using a relative path
    11.7, 8.3) # These numbers are page dimensions in inches
hist(log(MyDF$Predator.mass), # Plot predator histogram (note 'rgb')
    xlab="Body Mass (kg)", ylab="Count", col = rgb(1, 0, 0, 0.5), main = "Predator-Prey Size Overlap") 
hist(log(MyDF$Prey.mass), # Plot prey weights
    col = rgb(0, 0, 1, 0.5), 
    add = T)  # Add to same plot = TRUE
legend('topleft',c('Predators','Prey'), # Add legend
    fill=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5))) 
graphics.off(); #you can also use dev.off()

## GGPLOT2 ##

require(ggplot2)

qplot(Prey.mass, Predator.mass, data = MyDF) # qplot = quick plot
# or
qplot(MyDF$Prey.mass, MyDF$Predator.mass)

# Shown mass for type of predator
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, colour = Type.of.feeding.interaction)

qplot(log(Prey.mass), log(Predator.mass), data = MyDF, shape = Type.of.feeding.interaction)


qplot(log(Prey.mass), log(Predator.mass), 
    data = MyDF, colour = "red") # Way of putting one line of code over two lines

#Manually set colour
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, colour = I("red"))