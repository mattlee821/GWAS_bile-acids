#!/bin/bash

#SBATCH --job-name=make-pfiles
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

# environment
IN=/data/Epic_Gwas_Export/files/Clrt_01/
OUT=/home/leem/001_projects/GWAS_bile-acids/data/genetic/
OUT_VCF=/home/leem/001_projects/GWAS_bile-acids/data/genetic/vcf/
OUT_PFILE=/home/leem/001_projects/GWAS_bile-acids/data/genetic/pfile/
SCRATCH=/scratch/leem/

# make filelist
ls ${IN}*zip > ${OUT}filelist
sed -i 's|/data/Epic_Gwas_Export/files/Clrt_01/||' ${OUT}filelist

cd ${OUT}

# make pfiles
for FILE in `cat filelist`; do
  FILE_NAME="${FILE%.zip}"

  # cp
  cp ${IN}${FILE} ${OUT_VCF}

  # unzip
  cd $OUT_VCF
  unzip ${OUT_VCF}${FILE}
  rm ${OUT_VCF}${FILE}

  # gunzip to scratch
  cd $OUT_VCF
  for f in *.gz; do
    NAME=$(basename "${f}" .gz)
    gunzip -c "${f}" > ${SCRATCH}"${NAME}"
  done

  # convert
  ~/tools/plink2 --vcf ${SCRATCH}*vcf --make-pgen --out ${OUT_PFILE}${FILE_NAME}

  # clean-uo
  rm ${OUT_VCF}${FILE_NAME}* ${SCRATCH}${FILE_NAME}*
done