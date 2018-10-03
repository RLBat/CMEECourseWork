#!/bin/bash
#Author: Rachel Bates RLB18@Imperial.ac.uk
#Script: MyExampleScript.sh
#Desc: Says Hello to the user by name
#Arguments: none
#Date: 02.10.18

msg1='Hello' #Creates a variable with the value "Hello"
msg2=$USER #Creates a variable that is the same as the current user's name
echo "$msg1 $msg2" #Prints both variables, resulting in "Hello user"
echo "Hello $USER" #Prints "Hello" followed by the user's name