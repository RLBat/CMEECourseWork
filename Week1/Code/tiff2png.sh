#!/bin/bash
#Author: Rachel Bates RLB18@Imperial.ac.uk
#Script: tiff2png.sh
#Desc: Converts a .tif file to a .png
#Arguments: 
#Date: 06.10.18

for f in ../Sandbox/*.tif; 
    do  
        echo "Converting $f"; 
        convert "$f"  "$(basename "$f" .tif).jpg";
        mv $f.tif.jpg ../Code/ ../Sandbox/
        echo "Conversion complete"
    done