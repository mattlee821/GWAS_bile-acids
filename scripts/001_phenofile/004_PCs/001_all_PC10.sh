#!/bin/bash

#SBATCH --job-name=make-PCs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

IN=/home/leem/001_projects/GWAS_bile-acids/data/genetic/pfile/
PFILE=/home/leem/001_projects/GWAS_bile-acids/data/genetic/pfile/pfile
OUT=/home/leem/001_projects/GWAS_bile-acids/data/genetic/PCs/PC_10/
ID=/home/leem/001_projects/GWAS_bile-acids/data/genetic/PCs/ID/

~/tools/plink2 --pfile ${PFILE} --keep ${ID}combined_combined.txt --pca 10 --out ${OUT}/combined/combined/pca
~/tools/plink2 --pfile ${PFILE} --keep ${ID}combined_casess.txt --pca 10 --out ${OUT}/combined/case/pca
~/tools/plink2 --pfile ${PFILE} --keep ${ID}combined_controls.txt --pca 10 --out ${OUT}/combined/control/pca

~/tools/plink2 --pfile ${PFILE} --keep ${ID}male_combined.txt --pca 10 --out ${OUT}/male/combined/pca
~/tools/plink2 --pfile ${PFILE} --keep ${ID}male_cases.txt --pca 10 --out ${OUT}/male/case/pca
~/tools/plink2 --pfile ${PFILE} --keep ${ID}male_controls.txt --pca 10 --out ${OUT}/male/control/pca

~/tools/plink2 --pfile ${PFILE} --keep ${ID}female_combined.txt --pca 10 --out ${OUT}/female/combined/pca
~/tools/plink2 --pfile ${PFILE} --keep ${ID}female_cases.txt --pca 10 --out ${OUT}/female/case/pca
~/tools/plink2 --pfile ${PFILE} --keep ${ID}female_controls.txt --pca 10 --out ${OUT}/female/control/pca

