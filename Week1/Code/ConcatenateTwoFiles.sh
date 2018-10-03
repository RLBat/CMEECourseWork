#!/bin/bash
#Author: Rachel Bates RLB18@Imperial.ac.uk
#Script: ConcatenateTwoFiles.sh
#Desc: Adds the contents of two files into one new file
#Arguments: 1-> first imput file 2-> second input file 3-> Output file
#Date: 02.10.18

cat $1 > $3 #Copies file $1 into a new file that is created named $3
cat $2 >> $3 #Adds the contents of file $2 to file $3
echo "Merged File is"
cat $3 #Prints the contents of $3
exit
