#!/bin/bash
#SBATCH --job-name=filter-GWAS
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

cd /scratch/leem/GWAS/
ls /scratch/leem/GWAS/basic/combined/combined/*linear > filelist
sed -i 's|/scratch/leem/GWAS/basic/combined/combined/||g' filelist

FILELIST=/scratch/leem/GWAS/filelist

cd /scratch/leem/GWAS/basic/combined/combined
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
	awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"

cd /scratch/leem/GWAS/basic/combined/control
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
	awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"

cd /scratch/leem/GWAS/basic/combined/case
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
	awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"

cd /scratch/leem/GWAS/basic/female/combined
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
	awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"

cd /scratch/leem/GWAS/basic/female/control
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
	awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"

cd /scratch/leem/GWAS/basic/female/case
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
	awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"

cd /scratch/leem/GWAS/basic/male/combined
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
	awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"

cd /scratch/leem/GWAS/basic/male/case
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
	awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"

cd /scratch/leem/GWAS/basic/male/control
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
	awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"


cd /scratch/leem/GWAS/complex/combined/combined
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
    awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"

cd /scratch/leem/GWAS/complex/combined/control
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
    awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"

cd /scratch/leem/GWAS/complex/combined/case
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
    awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"

cd /scratch/leem/GWAS/complex/female/combined
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
    awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"

cd /scratch/leem/GWAS/complex/female/control
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
    awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"

cd /scratch/leem/GWAS/complex/female/case
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
    awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"

cd /scratch/leem/GWAS/complex/male/combined
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
    awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"

cd /scratch/leem/GWAS/complex/male/case
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
    awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"

cd /scratch/leem/GWAS/complex/male/control
# Read each line from the file using the while loop
while IFS= read -r FILE; do

    # Create a new file with the same name as the string in the row
    echo -e "#CHROM\tPOS\tID\tREF\tALT\tPROVISIONAL_REF?\tA1\tOMITTED\tA1_FREQ\tTEST\tOBS_CT\tBETA\tSE\tT_STAT\tP\tERRCODE" > "${FILE}.filtered"

    # Use awk to filter the rows based on the conditions and write the output to the output file
    awk -F'\t' '$10=="ADD" && $16=="." {print}' "${FILE}" >> "${FILE}.filtered"

done < "$FILELIST"

