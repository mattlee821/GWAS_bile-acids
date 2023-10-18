#!/bin/bash

#SBATCH --job-name=make-PCs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

IN=/home/leem/001_projects/GWAS_bile-acids/data/genetic/pfile/
OUT=/home/leem/001_projects/GWAS_bile-acids/data/genetic/pfile/
FILELIST=/home/leem/001_projects/GWAS_bile-acids/data/genetic/filelist

rm ${FILELIST}
for i in {2..22} X
do
  echo "/home/leem/001_projects/GWAS_bile-acids/data/genetic/pfile/chr$i" >> ${FILELIST}
done
less ${FILELIST}

~/tools/plink2 --pfile ${IN}chr1 --pmerge-list ${FILELIST} --out ${OUT}pfile