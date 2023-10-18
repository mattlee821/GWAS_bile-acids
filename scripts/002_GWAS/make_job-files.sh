PHENOFILE=/home/leem/001_projects/GWAS_bile-acids/data/phenotypes/bile_acids.txt

cd /home/leem/001_projects/GWAS_bile-acids/scripts/003_GWAS/complex/male/case/

## create multiple .sh qsub scripts from a single file with names in based on a master_sub script in which line (NR == ??) holds the variable name
cat ${PHENOFILE} | while read i; do echo ${i}; awk '{ if (NR == 12) print "VAR='${i}'"; else print $0}' master > ${i}.sh; done 

## check its added the variables
find  -type f -name "*.sh" -exec sed -n '12p' {} \;
