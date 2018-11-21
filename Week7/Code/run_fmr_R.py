#!/usr/bin/env python3

""" Uses subprocess to run fmr.R via python and displays the R output.
    Also exports the outputs to the Output subdirectory """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import subprocess

## CONSTANTS ##

# None

## FUNCTIONS ##

# None

################

try:
    # Runs the subprocess, giving the output
    subprocess.check_call("/usr/lib/R/bin/Rscript --verbose fmr.R \
    ../Output/fmr.Rout 2> ../Output/fmr_errFile.Rout",\
    shell=True)
    print ("\nExecution Sucessful") #Will only print if no errors are found

except subprocess.CalledProcessError: #If 1 or more error is found
    print ("ERROR: Subprocess not carried out sucessfully")

