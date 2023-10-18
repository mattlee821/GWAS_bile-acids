library(data.table)
library(functions)
library(tools)

# List all files with the suffix ".linear" in the specified directory
files <- list.files(path = "/scratch/leem/GWAS/", pattern = "filtered", full.names = TRUE, recursive = TRUE)
files <- files[!grepl("qqplot", files, ignore.case = TRUE)]
files <- files[!grepl("manhattan", files, ignore.case = TRUE)]

# Function to process a single file and save the output
process_file_and_save_output <- function(file_path) {
  # Read the data from the file
  df <- fread(file_path)
  
  # Modify the '#CHROM' column as per the provided code
  df$`#CHROM` <- gsub("X", "23", df$`#CHROM`)
  df$`#CHROM` <- as.numeric(df$`#CHROM`)
  
  # Generate the plot using the 'manhattan' function
  tiff(paste0(file_path, ".manhattan.tiff"), units = "px", width = 2400, height = 800)
  manhattan(df = df, chr = "#CHROM", bp = "POS", p = "P", snp = "ID")
  dev.off()
  
  # Remove the data frame from the environment to free up memory
  rm(df)
}

# Process each file one at a time
for (file_path in files) {
  process_file_and_save_output(file_path)
}
