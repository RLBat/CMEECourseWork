#!/usr/bin/env python3

""" Uses subprocess and regular expressions to find files/directories 
    named in certain ways """

__author__ = 'Rachel Bates r.bates18@imperial.ac.uk'
__version__ = '0.0.1'

## IMPORTS ##

import subprocess
import re

## CONSTANTS ##

home = subprocess.os.path.expanduser("~")

## FUNCTIONS ##

# None

#################################

# Use the subprocess.os module to get a list of files and  directories 
# in your ubuntu home directory 

p = subprocess.Popen(["ls", "-l", "~"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = p.communicate()
# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions

#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here:

# Create a list to store the results.
FileC = []

# Use a for loop to walk through the home directory.
for (directory, subdir, files) in subprocess.os.walk(home):
    # Use lc to check for subdirs starting with C
    FileC += [name for name in subdir if re.match(r"^C+", name)!=None]

for (directory, subdir, files) in subprocess.os.walk(home):
    # Use lc to check for files starting with C
    FileC += [name for name in files if re.match(r"^C+", name)!=None]

#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'

# Type your code here:

FileCc = []

for (directory, subdir, files) in subprocess.os.walk(home):
    FileCc += [name for name in subdir if re.match(r"^[Cc]+", name)!=None]

for (directory, subdir, files) in subprocess.os.walk(home):
    FileCc += [name for name in files if re.match(r"^[Cc]+", name)!=None]

#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:

DirCc = []

for (directory, subdir, files) in subprocess.os.walk(home):
    DirCc += [name for name in subdir if re.match(r"^[Cc]+", name)!=None]