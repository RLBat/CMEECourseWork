rm(list=ls())

Sparrow<- read.table("../Data/SparrowSize.txt", header=T)

fix(Sparrow)

plot(Sparrow$Mass~Sparrow$Tarsus, ylab="Mass (g)", xlab="Tarsus (mm)", 
pch=19, cex=0.9, ylim=c(-5,38), xlim=c(0,22)) #cex shows symbol size

summary(lm(Sparrow$Mass~Sparrow$Tarsus))

#not needed, lm discards NA values automatically
# d1<-subset(Sparrow, Sparrow$Mass!="NA")
# d2<-subset(d1, d1$Mass!="NA")
# lm(d2$Mass~d2$Tarsus)

length(Sparrow$Tarsus)

summary(lm(Sparrow$Mass~scale(Sparrow$Tarsus)))
par(mfrow=c(2,2))
plot(lm(Sparrow$Mass~scale(Sparrow$Tarsus)))


summary(lm(Sparrow$Bill~Sparrow$Tarsus * Sparrow$Sex))
names(Sparrow)


Sparrow$Sex<-as.factor(Sparrow$Sex)

plot(Sparrow$Bill ~ Sparrow$Tarsus, col=Sparrow$Sex, pch=20)

abline(lm(Sparrow$Bill~Sparrow$Tarsus * Sparrow$Sex))
abline(lm(d1$Bill~d1$Tarsus), col="red")
abline(lm(d2$Bill~d2$Tarsus), col="black")

plot(d1$Bill~d1$Tarsus)
d1<-subset(Sparrow, Sparrow$Sex.1!="male")
d2<-subset(Sparrow, Sparrow$Sex.1!="female")