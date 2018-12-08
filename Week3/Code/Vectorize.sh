#!/bin/bash
#Author: Rachel Bates RLB18@Imperial.ac.uk
#Script: Vectorize.sh
#Desc: Compares R and Python run times for two scripts
#Arguments: none
#Date: 24.10.18

# Calculates running time for the R scripts
echo "Vectorize1.R execution time:"
time (Rscript Vectorize1.R &>-)
echo  "Vectorize2.R execution time:"
time (Rscript Vectorize2.R &>-)

# Calculates running time for the python scripts
echo "Vectorize1.py execution time:"
time (ipython3 Vectorize1.py &>-)
echo  "Vectorize2.py execution time:"
time (ipython3 Vectorize2.py &>-)
