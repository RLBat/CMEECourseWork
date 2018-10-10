#!/bin/bash
#Author: Rachel Bates RLB18@Imperial.ac.uk
#Script: CountLines.sh
#Desc: Counts the number of lines in a file
#Arguments: 1-> file with lines to be counted
#Date: 02.10.18

if [ $# -eq 0 ] #Checks there is an input file
    then
        echo "No input file detected. Please try again"
        exit
    else
        NumLines=`wc -l < $1` #Creates a variable containing the number of lines in a file
        echo "The file $1 has $NumLines lines" #Prints the name of the file and the number of lines within it
fi