#!/bin/bash
#Author: Rachel Bates RLB18@Imperial.ac.uk
#Script: csvtospace.sh
#Desc: Converts CSV files to space delimited ones
#Arguments: none
#Date: 02.10.18

if [ $# -eq 0 ]  #Checks there is an input file
    then
        echo "No input file detected. Please try again"
        exit
    else
        echo "Creating a comma delimited verson of $1 ..."
        cat $1 | tr -s "," " " >> $1.txt | mv $1.txt ../Output/
        #Removes the tabs from the file and replaces them with commas. Creates a new csv file named the same as $1.
        #Moves the resulting file into the Output directory
        echo "Done!"
        exit
fi