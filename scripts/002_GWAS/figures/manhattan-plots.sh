#!/bin/bash

#SBATCH --job-name=manhattan-plots
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=5-10:0:00
#SBATCH --mem=100000M

cd ~/001_projects/GWAS_bile-acids/
Rscript scripts/003_GWAS/manhattan-plots.R               
