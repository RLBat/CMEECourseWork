#!/bin/bash
#Author: Rachel Bates RLB18@Imperial.ac.uk
#Script: run_miniproj.sh
#Desc: Bash script used to compile the workflow for the CMEE miniproject
#Arguments: none
#Date: 01/02/19

start=$SECONDS

# Reduce the downloaded database to a workable sized data file by
# Removing points with missing data, and reducing to only birds with abundance data
echo "Starting Miniproject workflow"
printf "\nRunning DataWrang.py\n"
python3 Datawrang.py
printf "\nRunning ModelBuild.py\n"
python3 Modelbuild.py
printf "\nRunning Modelplot.R\n"
#Rscript Modelplot.R
printf "\nCompiling LaTeX document\n"

echo "Workflow complete. Please see WriteUp directory for finished report."
secs=$((SECONDS-start))
printf '%02dh:%02dm:%02ds elapsed\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))
