library(lme4) # loads package lme4
require(lme4) # loads package lme4 only if it's not already loaded



Sparrow <- read.table("../Data/SparrowSize.txt", header=TRUE)

mean(Sparrow$Tarsus, na.rm=TRUE) #na.rm removes all NA values before computation

median(Sparrow$Tarsus, na.rm=TRUE)

par(mfrow = c(2, 2)) # Puts the displays in a 2x2 grid
hist(Sparrow$Tarsus, breaks=3, col="grey")
hist(Sparrow$Tarsus, breaks=10, col="grey")
hist(Sparrow$Tarsus, breaks=30, col="grey")
hist(Sparrow$Tarsus, breaks=100, col="grey")
	
require(modeest)	

mlv(Sparrow$Tarsus, na.rm=TRUE) # Uses modeest to estimate the mode

Sparr2<-subset(Sparrow, Sparrow$Tarsus!="NA") # Makes a new df with Tarsus, removes NA values

SparrWing<-subset(Sparrow, Sparrow$Wing!="NA")
length(SparrWing$Wing)

range(Sparrow$Tarsus, na.rm=TRUE) # Measures range

var(Sparrow$Tarsus, na.rm=TRUE) # Measures varience

sd(Sparrow$Tarsus, na.rm=TRUE) # Mesures st.dev

zTarsus <- (Sparr2$Tarsus - mean(Sparr2$Tarsus))/sd(Sparr2$Tarsus)
summary(zTarsus)
names(Sparrow)
var(Sparrow$Mass, na.rm=TRUE)
head(Sparrow$Bill)

boxplot(Sparrow$Tarsus~Sparrow$Sex.1, col = c("red", "blue"), ylab="Tarsus length (mm)")