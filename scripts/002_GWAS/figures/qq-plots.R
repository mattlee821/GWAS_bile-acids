library(data.table)
# devtools::install_github("mattlee821/functions")
library(functions)
library(tools)
library(ggplot2)
library(cowplot)

# List all files with the suffix ".linear" in the specified directory
files <- list.files(path = "/scratch/leem/GWAS/", pattern = "filtered", full.names = TRUE, recursive = TRUE)
files <- files[!grepl("manhattan", files, ignore.case = TRUE)]
files <- files[!grepl("qqplot", files, ignore.case = TRUE)]

# Function to process a single file and save the output
process_file_and_save_output <- function(file_path) {
  # Read the data from the file
  df <- fread(file_path)
  
  # lambda
  chisq <- qchisq(1-df$P, 1)
  lambda <- round(median(chisq)/qchisq(0.5,1),2)

  # Generate the plot using the 'manhattan' function
  tiff(paste0(file_path, ".qqplot.tiff"), units = "px", width = 500, height = 500)
  qqplot(df = a$P, 
                    title = paste("λ = ", lambda),
                    ci = NA)
  dev.off()

    # Remove the data frame from the environment to free up memory
  rm(df)

}

# Process each file one at a time
for (file_path in files) {
  process_file_and_save_output(file_path)
}
