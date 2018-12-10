#!/usr/bin/env python3

""" Runs scripts detailing various versions of Lotka-Volterra 
    models with required user inputs """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

# None

## CONSTANTS ##

# None

## FUNCTIONS ##

# None

################

# Runs LV1 with profiling
run -p LV1.py
# Runs LV2 with given inputs for parameters, with profiling
run -p LV2.py 1 0.1 1.5 0.75
# Runs LV3 with given inputs for parameters, with profiling
run -p LV3.py 1 0.1 1.5 0.75
# Runs LV3 with given inputs for parameters, with profiling
run -p LV4.py 1 0.1 1.5 0.75