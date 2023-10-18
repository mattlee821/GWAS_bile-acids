#!/bin/bash

#SBATCH --job-name=compress_GWAS
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

cd /scratch/leem/GWAS/basic/combined/
tar -zcvf basic_combined_combined.tar.gz combined
tar -zcvf basic_combined_case.tar.gz case
tar -zcvf basic_combined_control.tar.gz control

cd /scratch/leem/GWAS/basic/female/
tar -zcvf basic_female_combined.tar.gz combined
tar -zcvf basic_female_case.tar.gz case
tar -zcvf basic_female_control.tar.gz control

cd /scratch/leem/GWAS/basic/male/
tar -zcvf basic_male_combined.tar.gz combined
tar -zcvf basic_male_case.tar.gz case
tar -zcvf basic_male_control.tar.gz control

cd /scratch/leem/GWAS/complex/combined/
tar -zcvf complex_combined_combined.tar.gz combined
tar -zcvf complex_combined_case.tar.gz case
tar -zcvf complex_combined_control.tar.gz control

cd /scratch/leem/GWAS/complex/female/
tar -zcvf complex_female_combined.tar.gz combined
tar -zcvf complex_female_case.tar.gz case
tar -zcvf complex_female_control.tar.gz control

cd /scratch/leem/GWAS/complex/male/
tar -zcvf complex_male_combined.tar.gz combined
tar -zcvf complex_male_case.tar.gz case
tar -zcvf complex_male_control.tar.gz control
