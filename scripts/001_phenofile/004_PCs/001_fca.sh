#!/bin/bash

#SBATCH --job-name=PC-fca
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

PFILE=/home/leem/001_projects/GWAS_bile-acids/data/genetic/pfile/pfile
OUT=/home/leem/001_projects/GWAS_bile-acids/data/genetic/PCs/
ID=/home/leem/001_projects/GWAS_bile-acids/data/genetic/PCs/ID/

~/tools/plink2 --pfile ${PFILE} --keep ${ID}female_cases.txt --pca 10 --out ${OUT}/female/case/pca
