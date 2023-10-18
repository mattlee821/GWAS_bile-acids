#!/bin/bash

#SBATCH --job-name=make-PCs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

PFILE=/home/leem/001_projects/GWAS_bile-acids/data/genetic/pfile/pfile
OUT=/home/leem/001_projects/GWAS_bile-acids/data/genetic/PCs/
ID=/home/leem/001_projects/GWAS_bile-acids/data/genetic/PCs/ID/

~/tools/plink2 --pfile ${PFILE} --keep ${ID}pca_IDs.txt --pca 40 --out ${OUT}/combined/combined/pca
~/tools/plink2 --pfile ${PFILE} --keep ${ID}pca_cases_IDs.txt --pca 40 --out ${OUT}/combined/case/pca
~/tools/plink2 --pfile ${PFILE} --keep ${ID}pca_controls_IDs.txt --pca 40 --out ${OUT}/combined/control/pca

~/tools/plink2 --pfile ${PFILE} --keep ${ID}pca_male_IDs.txt --pca 40 --out ${OUT}/male/combined/pca
~/tools/plink2 --pfile ${PFILE} --keep ${ID}pca_cases_male_IDs.txt --pca 40 --out ${OUT}/male/case/pca
~/tools/plink2 --pfile ${PFILE} --keep ${ID}pca_controls_male_IDs.txt --pca 40 --out ${OUT}/male/control/pca

~/tools/plink2 --pfile ${PFILE} --keep ${ID}pca_female_IDs.txt --pca 40 --out ${OUT}/female/combined/pca
~/tools/plink2 --pfile ${PFILE} --keep ${ID}pca_cases_female_IDs.txt --pca 40 --out ${OUT}/female/case/pca
~/tools/plink2 --pfile ${PFILE} --keep ${ID}pca_controls_female_IDs.txt --pca 40 --out ${OUT}/female/control/pca
