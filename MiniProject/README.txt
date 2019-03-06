Miniproject work for CMEE
Author: Rachel Bates
Date:/11/18

This directory contains the whole workflow for the miniproject, from data wrangling to model fitting and plotting through to creation of the final write up in LaTeX. 

----------------------

R Version Used: 3.4.4
Required R packages:
	-lme4
	-ggplot2
	-ggpubr

Python Version Used: 3.5.2
Required Python packages:
	-pandas
	-numpy
	-math

Bash version used: 4.3.48(1)

----------------------

Sub-directories:

Code: All python, R and bash scripts
Data: All data, both raw and any created csv files
Output: Where any graphs/tables etc. that are created will be placed.
Sandbox: Place for any test code
WriteUp: All componants for the write up. Includes the LaTeX script as well as bibTeX references and final PDF.

-----------------------

Scripts:

Datawrang.py - Does the initial data cleaning and subsetting to get only sites with avian abundance data. Removes sites with missing data/too few data.

Modelbuild.py - Calculates diversity metrics, geographic weighting, land-use intensity scores, and country GDP for they year of study.

Modelplot.R - Fits linear mixed models to the data. Test impacts of weighting by geographic realm and feasibility of including habitat area. Fits models to all combination of potential factors, and then calculates the AIC values to determine the best model. 

run_miniproj.sh - Runs all the parts of the workflow to make the project reproducible.




