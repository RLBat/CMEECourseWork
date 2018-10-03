#!/bin/bash
#Author: Rachel Bates RLB18@Imperial.ac.uk
#Script: csvtospace.sh
#Desc: Converts CSV files to space delimited ones
#Arguments: 1-> Comma Separated File (CSV) 2-> Output .txt file that will be space delimited
#Date: 02.10.18

echo "Creating a space delimited version of $1 ..."
cat $1 | tr -s "," " " >> $2
echo "Conversion Complete"


#filename=hello.world
# echo "$filename" | cut -f 1 -d '.'
#hello
# filename=hello.hello.hello
# echo "$filename" | cut -f 1 -d '.'
#hello
# filename=hello
# echo "$filename" | cut -f 1 -d '.'
#hello