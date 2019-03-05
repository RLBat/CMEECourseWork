#!/bin/bash
#Author: Rachel Bates RLB18@Imperial.ac.uk
#Script: run_miniproj.sh
#Desc: Bash script used to compile the workflow for the CMEE miniproject
#Arguments: none
#Date: 01/02/19

# Reduce the downloaded database to a workable sized data file by
# Removing points with missing data, and reducing to only birds with abundance data
python3 Datawrang.py
python3 Modelbuild.py