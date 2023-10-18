rm(list=ls())
set.seed(821)

# environment
library(data.table)
library(dplyr)
library(tidyverse)

# combined control ====
phenofile <- fread("data/phenotypes/phenofile/combined_controls.txt", header = T, sep = "\t")
head(phenofile)
eigenvectors <- read.table("data/genetic/PCs/PC_10/combined/control/pca.eigenvec", header = F, sep = "\t")
head(eigenvectors)
rownames(eigenvectors) <- eigenvectors$V1
eigenvectors <- eigenvectors[, -1]
eigenvectors <- eigenvectors %>%
  rename_with(.cols = starts_with("V"),
              .fn = ~ paste0("PC", as.numeric(gsub("V", "", .)) - 1))
eigenvectors <- rownames_to_column(eigenvectors, var = "#IID")
data <- left_join(phenofile, eigenvectors, by = "#IID")

## check for duplicate
duplicates <- data[duplicated(data$`#IID`) | duplicated(data$`#IID`, fromLast = TRUE), ]
## remove one instance of each duplicate row
data <- data[!duplicated(data), ]
## save
write.table(data, "data/data-for-GWAS/PC_10/combined_controls.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# combined case ====
phenofile <- fread("data/phenotypes/phenofile/combined_cases.txt", header = T, sep = "\t")
head(phenofile)
eigenvectors <- read.table("data/genetic/PCs/PC_10/combined/case/pca.eigenvec", header = F, sep = "\t")
head(eigenvectors)
rownames(eigenvectors) <- eigenvectors$V1
eigenvectors <- eigenvectors[, -1]
eigenvectors <- eigenvectors %>%
  rename_with(.cols = starts_with("V"),
              .fn = ~ paste0("PC", as.numeric(gsub("V", "", .)) - 1))
eigenvectors <- rownames_to_column(eigenvectors, var = "#IID")
data <- left_join(phenofile, eigenvectors, by = "#IID")

## check for duplicate
duplicates <- data[duplicated(data$`#IID`) | duplicated(data$`#IID`, fromLast = TRUE), ]
## remove one instance of each duplicate row
data <- data[!duplicated(data), ]
## save
write.table(data, "data/data-for-GWAS/PC_10/combined_cases.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# combined combined ====
phenofile <- fread("data/phenotypes/phenofile/combined_combined.txt", header = T, sep = "\t")
head(phenofile)
eigenvectors <- read.table("data/genetic/PCs/PC_10/combined/combined/pca.eigenvec", header = F, sep = "\t")
head(eigenvectors)
rownames(eigenvectors) <- eigenvectors$V1
eigenvectors <- eigenvectors[, -1]
eigenvectors <- eigenvectors %>%
  rename_with(.cols = starts_with("V"),
              .fn = ~ paste0("PC", as.numeric(gsub("V", "", .)) - 1))
eigenvectors <- rownames_to_column(eigenvectors, var = "#IID")
data <- left_join(phenofile, eigenvectors, by = "#IID")

## check for duplicate
duplicates <- data[duplicated(data$`#IID`) | duplicated(data$`#IID`, fromLast = TRUE), ]
## remove one instance of each duplicate row
data <- data[!duplicated(data), ]
## save
write.table(data, "data/data-for-GWAS/PC_10/combined_combined.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


# female combined ====
phenofile <- fread("data/phenotypes/phenofile/female_combined.txt", header = T, sep = "\t")
head(phenofile)
eigenvectors <- read.table("data/genetic/PCs/PC_10/female/combined/pca.eigenvec", header = F, sep = "\t")
head(eigenvectors)
rownames(eigenvectors) <- eigenvectors$V1
eigenvectors <- eigenvectors[, -1]
eigenvectors <- eigenvectors %>%
  rename_with(.cols = starts_with("V"),
              .fn = ~ paste0("PC", as.numeric(gsub("V", "", .)) - 1))
eigenvectors <- rownames_to_column(eigenvectors, var = "#IID")
data <- left_join(phenofile, eigenvectors, by = "#IID")

## check for duplicate
duplicates <- data[duplicated(data$`#IID`) | duplicated(data$`#IID`, fromLast = TRUE), ]
## remove one instance of each duplicate row
data <- data[!duplicated(data), ]
## save
write.table(data, "data/data-for-GWAS/PC_10/female_combined.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


# female case ====
phenofile <- fread("data/phenotypes/phenofile/female_cases.txt", header = T, sep = "\t")
head(phenofile)
eigenvectors <- read.table("data/genetic/PCs/PC_10/female/case/pca.eigenvec", header = F, sep = "\t")
head(eigenvectors)
rownames(eigenvectors) <- eigenvectors$V1
eigenvectors <- eigenvectors[, -1]
eigenvectors <- eigenvectors %>%
  rename_with(.cols = starts_with("V"),
              .fn = ~ paste0("PC", as.numeric(gsub("V", "", .)) - 1))
eigenvectors <- rownames_to_column(eigenvectors, var = "#IID")
data <- left_join(phenofile, eigenvectors, by = "#IID")

## check for duplicate
duplicates <- data[duplicated(data$`#IID`) | duplicated(data$`#IID`, fromLast = TRUE), ]
## remove one instance of each duplicate row
data <- data[!duplicated(data), ]
## save
write.table(data, "data/data-for-GWAS/PC_10/female_cases.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


# female control ====
phenofile <- fread("data/phenotypes/phenofile/female_controls.txt", header = T, sep = "\t")
head(phenofile)
eigenvectors <- read.table("data/genetic/PCs/PC_10/female/control/pca.eigenvec", header = F, sep = "\t")
head(eigenvectors)
rownames(eigenvectors) <- eigenvectors$V1
eigenvectors <- eigenvectors[, -1]
eigenvectors <- eigenvectors %>%
  rename_with(.cols = starts_with("V"),
              .fn = ~ paste0("PC", as.numeric(gsub("V", "", .)) - 1))
eigenvectors <- rownames_to_column(eigenvectors, var = "#IID")
data <- left_join(phenofile, eigenvectors, by = "#IID")

## check for duplicate
duplicates <- data[duplicated(data$`#IID`) | duplicated(data$`#IID`, fromLast = TRUE), ]
## remove one instance of each duplicate row
data <- data[!duplicated(data), ]
## save
write.table(data, "data/data-for-GWAS/PC_10/female_controls.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


# male combined ====
phenofile <- fread("data/phenotypes/phenofile/male_combined.txt", header = T, sep = "\t")
head(phenofile)
eigenvectors <- read.table("data/genetic/PCs/PC_10/male/combined/pca.eigenvec", header = F, sep = "\t")
head(eigenvectors)
rownames(eigenvectors) <- eigenvectors$V1
eigenvectors <- eigenvectors[, -1]
eigenvectors <- eigenvectors %>%
  rename_with(.cols = starts_with("V"),
              .fn = ~ paste0("PC", as.numeric(gsub("V", "", .)) - 1))
eigenvectors <- rownames_to_column(eigenvectors, var = "#IID")
data <- left_join(phenofile, eigenvectors, by = "#IID")

## check for duplicate
duplicates <- data[duplicated(data$`#IID`) | duplicated(data$`#IID`, fromLast = TRUE), ]
## remove one instance of each duplicate row
data <- data[!duplicated(data), ]
## save
write.table(data, "data/data-for-GWAS/PC_10/male_combined.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


# male case ====
phenofile <- fread("data/phenotypes/phenofile/male_cases.txt", header = T, sep = "\t")
head(phenofile)
eigenvectors <- read.table("data/genetic/PCs/PC_10/male/case/pca.eigenvec", header = F, sep = "\t")
head(eigenvectors)
rownames(eigenvectors) <- eigenvectors$V1
eigenvectors <- eigenvectors[, -1]
eigenvectors <- eigenvectors %>%
  rename_with(.cols = starts_with("V"),
              .fn = ~ paste0("PC", as.numeric(gsub("V", "", .)) - 1))
eigenvectors <- rownames_to_column(eigenvectors, var = "#IID")
data <- left_join(phenofile, eigenvectors, by = "#IID")

## check for duplicate
duplicates <- data[duplicated(data$`#IID`) | duplicated(data$`#IID`, fromLast = TRUE), ]
## remove one instance of each duplicate row
data <- data[!duplicated(data), ]
## save
write.table(data, "data/data-for-GWAS/PC_10/male_cases.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")


# male control ====
phenofile <- fread("data/phenotypes/phenofile/male_controls.txt", header = T, sep = "\t")
head(phenofile)
eigenvectors <- read.table("data/genetic/PCs/PC_10/male/control/pca.eigenvec", header = F, sep = "\t")
head(eigenvectors)
rownames(eigenvectors) <- eigenvectors$V1
eigenvectors <- eigenvectors[, -1]
eigenvectors <- eigenvectors %>%
  rename_with(.cols = starts_with("V"),
              .fn = ~ paste0("PC", as.numeric(gsub("V", "", .)) - 1))
eigenvectors <- rownames_to_column(eigenvectors, var = "#IID")
data <- left_join(phenofile, eigenvectors, by = "#IID")

## check for duplicate
duplicates <- data[duplicated(data$`#IID`) | duplicated(data$`#IID`, fromLast = TRUE), ]
## remove one instance of each duplicate row
data <- data[!duplicated(data), ]
## save
write.table(data, "data/data-for-GWAS/PC_10/male_controls.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

