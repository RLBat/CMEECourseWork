import subprocess

# Send the command as separate elements of a list for conveinience
p = subprocess.Popen(["echo", "I'm talkin' to you, bash!"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)

# Outputs the returned result of p into stderr
stdout, stderr = p.communicate()

stderr #bit object

stdout #Gives the written output of p

print(stdout.decode()) # Output printed as a string (decoded from bits)

#universal_newlines = True # Means all outputs will be strings not bits

# Checks all files in the subdirectory
p = subprocess.Popen(["ls", "-l"], stdout=subprocess.PIPE)
stdout, stderr = p.communicate()
print(stdout.decode())

# Uses python to open a python script
p = subprocess.Popen(["python", "boilerplate.py"], stdout=subprocess.PIPE, stderr=subprocess.PIPE) # A bit silly! 
stdout, stderr = p.communicate()
print(stdout.decode())

# Creates a model directory path - works will all OSs!!! Good for workflows
subprocess.os.path.join('directory', 'subdirectory', 'file')

MyPath = subprocess.os.path.join('directory', 'subdirectory', 'file')
MyPath


