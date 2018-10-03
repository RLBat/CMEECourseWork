#!/bin/bash
#Author: Rachel Bates RLB18@Imperial.ac.uk
#Script: variables.sh
#Desc: Prompts the user to input some values, stores and displays one and sums the other two
#Arguments: none
#Date: 02.10.18

MyVar='some string' #Creates a variable and gives it the value "some string"
echo 'the current value of the variable is' $MyVar #Prints the contents of MyVar
echo 'Please enter a new string' 
read MyVar #Prompts a user input and replaces "some string" with the user's input
echo 'the current value of the variable is' $MyVar #Prints the new value of MyVar
echo 'enter two numbers separated by space(s)'
read a b #Prompts the user to input two numbers separated by a space and creates two variables, a and b
echo 'you entered' $a 'and' $b '. Their sum is:' #Displays the two new variables
mysum=`expr $a + $b` #Sums the two variables
echo $mysum #Displays the sum of the two variables