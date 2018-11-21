#!/usr/bin/env python3

""" Example use of subprocess to run an R script and capture the output """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import subprocess

## CONSTANTS ##

# None

## FUNCTIONS ##

# None

################

#Runs R through bash! Sends any regular output to one file and errors to another
subprocess.Popen("/usr/lib/R/bin/Rscript --verbose TestR.R > \
../Output/TestR.Rout 2> ../Output/TestR_errFile.Rout",\
 shell=True).wait() #Wait makes sure you run all of the processes before exiting

