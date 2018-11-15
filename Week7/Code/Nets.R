## Build a network

# Author: Rachel Bates (r.bates18@imperial.ac.uk)
# Version: 0.0.1

## Clear the directory ##

rm(list=ls())

## Packages ##

library(igraph)

## Load Data ##

links <- read.csv("../Data/QMEE_Net_Mat_edges.csv", header=T, as.is=T)
nodes <- read.csv("../Data/QMEE_Net_Mat_nodes.csv", header=T, row.names = 1)

###############

#Create graph object
net <- graph.adjacency(as.matrix(links), mode = "directed", weighted=TRUE, diag=F)
        
# Generate colors based on partner type:
colrs <- c("green", "red", "blue")
V(net)$color <- colrs[nodes$Type]

V(net)$size <- 50

# Set edge width based on weight (PhD Students):
E(net)$width <- E(net)$weight

#change arrow size and edge color:
E(net)$arrow.size <- 1
E(net)$edge.color <- "gray80"

E(net)$width <- 1+E(net)$weight/10

graphics.off()

svg("../Output/QMEENet.svg",width=7,height=7)

plot(net, edge.curved=0, vertex.label.color="black") 

legend(x=-1.5, y=-0.1, c("Hosting Partner", "Non-hosting Partner","University"), pch=21,
       col="#777777", pt.bg=colrs, pt.cex=2, cex=.8, bty="n", ncol=1)

dev.off()
