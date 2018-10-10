#!/bin/bash
#Author: Rachel Bates RLB18@Imperial.ac.uk
#Script: tiff2png.sh
#Desc: Creates .png versions of any .tif file in the Data directory and places them in the output directory
#Arguments: None
#Date: 06.10.18

for f in ../Data/*.tif; 
    do  
        echo "Converting $f"; 
        convert "$f"  "$(basename "$f" .tif).png";
        mv *.png ../Output/ #Moves the created png to the output directory
        echo "Conversion complete, files placed in ../Output/"
    done