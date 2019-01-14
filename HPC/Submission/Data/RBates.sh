#!/bin/bash
#PBS -l walltime=12:00:00
#PBS -l select=1:ncpus=1:mem=1gb
module load anaconda3/personal
echo "R is about to run"
R --vanilla < $HOME/RBates.R
mv RLB18_* $HOME/Neutral_full
echo "R has finished running"
