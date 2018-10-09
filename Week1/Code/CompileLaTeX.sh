#!/bin/bash
#Author: Rachel Bates RLB18@Imperial.ac.uk
#Script: CompileLaTeX.sh
#Desc: Allows a LaTeX script to be converted to a PDF and a bibtex 
    #file of the same name to be added as a bibliography to the document.
#Arguments: 1 <- LaTeX script minus the .tex extension
#Date: 06.10.18

pdflatex $1.tex
pdflatex $1.tex
bibtex $1
pdflatex $1.tex
pdflatex $1.tex
evince $1.pdf &

# Cleanup - removes unnessesary files
rm *~
rm *.aux
rm *.dvi
rm *.log
rm *.nav
rm *.out
rm *.snm
rm *.toc