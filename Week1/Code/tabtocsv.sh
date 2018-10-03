#!/bin/bash
#Author: Rachel Bates RLB18@Imperial.ac.uk
#Script: tabtocsv.sh
#Desc: sub tabs in a file to commas and saves the output to a csv
#Arguments: 1-> tab delimited file
#Date: 02.10.18

echo "Creating a comma delimited verson of $1 ..."
cat $1 | tr -s "\t" "," >> $1.csv #Removes the tabs from the file and replaces them with commas. Creates a new csv file named the same as $1.
echo "Done!"
exit