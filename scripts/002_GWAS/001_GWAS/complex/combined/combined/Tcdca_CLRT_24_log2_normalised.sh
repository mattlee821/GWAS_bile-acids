#!/bin/bash

#SBATCH --job-name=annotate-filelist1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20-1:0:00
#SBATCH --mem=100000M

DATA=/home/leem/001_projects/GWAS_bile-acids/data/genetic/pfile/
PHENOFILE=/home/leem/001_projects/GWAS_bile-acids/data/data-for-GWAS/combined_combined.txt
SCRATCH=/scratch/leem/GWAS/complex/combined/combined/
VAR=Tcdca_CLRT_24_log2_normalised

rm ${DATA}filelist
ls ${DATA}*psam > ${DATA}filelist
sed -i 's|/home/leem/001_projects/GWAS_bile-acids/data/genetic/pfile/||g; s|.psam||g; s|pfile||g' ${DATA}filelist

cd ${DATA}


for FILE in `cat filelist`; do 
	~/tools/plink2 --pfile ${DATA}${FILE} \
	--pheno ${PHENOFILE} \
	--pheno-name ${VAR} \
	--freq --hardy --linear --covar-variance-standardize \
	--covar ${PHENOFILE} \
    --covar-name Sex, Cncr_Caco_Clrt, Fasting_C, Age_Blood, batch, QgE130301, Diabet, Bmi_C, QE_FAT, QE_FIBT, PC1, PC2, PC3, PC4, PC5, PC6, PC7, PC8, PC9, PC10 \
	--out ${SCRATCH}${VAR}_${FILE}
done

cd ${SCRATCH}

# merge
extensions=$(ls -1 | awk -F. '{print $NF}' | sort -u)

# Iterate over unique extensions
for ext in $extensions; do
    # Create a combined file for each extension
    combined_file="${VAR}.$ext"
    
    # Find the files with the specific extension
    files=(${VAR}_chr*.$ext)
    
    # Check if there are any files with the extension
    if [[ ${#files[@]} -eq 0 ]]; then
        echo "No files with extension .$ext found."
        continue
    fi
    
    # Remove the combined file if it already exists
    rm -f "$combined_file"
    
    # Find the header file for the extension
    header_file="${files[0]}"
    
    # Add the header to the combined file
    cat "$header_file" >> "$combined_file"
    
    # Concatenate files with the same extension (excluding the header)
    for file in "${files[@]}"; do
        if [ "$file" != "$header_file" ]; then
            tail -n +2 "$file" >> "$combined_file"
        fi
    done
    
    echo "Combined files with extension .$ext into $combined_file"
done

# clean
rm ${SCRATCH}${VAR}_chr*
