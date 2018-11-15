
import subprocess
#Runs R through bash! Sends any regular output to one file and errors to another
subprocess.Popen("/usr/lib/R/bin/Rscript --verbose TestR.R > \
../Output/TestR.Rout 2> ../Output/TestR_errFile.Rout",\
 shell=True).wait() #Wait makes sure you run all of the processes before exiting

