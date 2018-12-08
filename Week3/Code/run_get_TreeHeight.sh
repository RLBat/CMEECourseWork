#!/bin/bash
#Author: Rachel Bates RLB18@Imperial.ac.uk
#Script: run_get_TreeHeight.sh
#Desc: Loads get_TreeHeight.R
#Arguments: none
#Date: 19.10.18

# Runs get_TreeHeight.R with an input
Rscript get_TreeHeight.R ../Data/trees.csv

# Runs get_TreeHeight.py with an input
python3 get_TreeHeight.py ../Data/trees.csv
