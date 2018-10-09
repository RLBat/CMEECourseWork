#!/bin/bash
#Author: Rachel Bates RLB18@Imperial.ac.uk
#Script: tabtocsv.sh
#Desc: sub tabs in a file to commas and saves the output to a csv
#Arguments: 1-> tab delimited file
#Date: 02.10.18

echo "Creating a comma delimited verson of $1 ..."
if [ $# -eq 0 ]
    then
        echo "No input file entered. Please try again"
        exit
    else
#        File=$(echo "$1" | cut -f 1 -d '.')
#        cat $File | tr -s "\t" "," >> $File.csv
        cat $1 | tr -s "\t" "," >> $1.csv
        #Removes the tabs from the file and replaces them with commas. Creates a new csv file named the same as $1.
        mv $1.csv ../Output/
        #Moves the resulting file into the Output directory
        echo "Done!"
        exit
fi