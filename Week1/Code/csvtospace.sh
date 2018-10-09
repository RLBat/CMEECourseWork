#!/bin/bash
#Author: Rachel Bates RLB18@Imperial.ac.uk
#Script: csvtospace.sh
#Desc: Converts CSV files to space delimited ones
#Arguments: none
#Date: 02.10.18

echo "Creating a space delimited versions of temperature files ..."
cat ../Data/1800.csv | tr -s "," " " >> ../Output/1800.txt
cat ../Data/1801.csv | tr -s "," " " >> ../Output/1801.txt
cat ../Data/1802.csv | tr -s "," " " >> ../Output/1802.txt
cat ../Data/1803.csv | tr -s "," " " >> ../Output/1803.txt
echo "Conversion Complete. Please find the new files in the Output folder"
exit