rm(list=ls())
set.seed(821)

# environment ====
library(tidyverse)
library(haven)
library(reshape2)
library(data.table)

# data ====

## phenotypes - N = 15836
data <- read_stata("data/phenotypes/EPIC/clrt_caco.dta") 
data <- select(data, Idepic, Match_Caseset, Typ_Tumo, Age_Blood, Sex, Fasting_C, Diabet, Bmi_C, QgE130301, QE_FAT, QE_FIBT, Idepic_Bio, Cncr_Caco_Clrt, Ca_CLRT_24, Cdca_CLRT_24, Dca_CLRT_24, Gca_CLRT_24, Gcdca_CLRT_24, Gdca_CLRT_24, Ghca_CLRT_24, Glca_CLRT_24, Gudca_CLRT_24, Hca_CLRT_24, Tamca_CLRT_24, Tca_CLRT_24, Tcdca_CLRT_24, Tdca_CLRT_24, Thca_CLRT_24, Tudca_CLRT_24, Udca_CLRT_24)
table(data$Cncr_Caco_Clrt) # 5119 cases / 10717 controls

## bile acids - N = 1091
data_bile_acids <- data[complete.cases(data$Ca_CLRT_24), ]
data_bile_acids <- select(data_bile_acids, Idepic, Ca_CLRT_24, Cdca_CLRT_24, Dca_CLRT_24, Gca_CLRT_24, Gcdca_CLRT_24, Gdca_CLRT_24, Ghca_CLRT_24, Glca_CLRT_24, Gudca_CLRT_24, Hca_CLRT_24, Tamca_CLRT_24, Tca_CLRT_24, Tcdca_CLRT_24, Tdca_CLRT_24, Thca_CLRT_24, Tudca_CLRT_24, Udca_CLRT_24)
data_bile_acids <- data_bile_acids[complete.cases(data_bile_acids), ]
duplicate_rows <- data_bile_acids[duplicated(data_bile_acids$Idepic) | duplicated(data_bile_acids$Idepic, fromLast = TRUE), ] # fine to exclude
id_bile_acids <- unique(data_bile_acids$Idepic)

## genetic data - N = 4449 
id_genetic <- read.table("data/genetic/pfile/chr1.psam", header = F, sep = "\t")
id_genetic <- unique(id_genetic$V1)

## filter - 226 genetic IDs missing in data
id_missing <- setdiff(id_genetic, data$Idepic)
data <- data[data$Idepic %in% id_genetic, ] # 4266
table(data$Cncr_Caco_Clrt) # 2026 cases / 2240 controls
data <- data[data$Idepic %in% id_bile_acids, ] # 988
table(data$Cncr_Caco_Clrt) # 486 cases / 502 controls
id <- unique(data$Idepic)

# join bile acid lab data ====
data_lab <- read_stata("data/phenotypes/EPIC/clrt_caco_biom_lod_loq.dta")
data_lab <- data_lab[data_lab$Idepic %in% id, ] # 4266
data_lab <- select(data_lab, Idepic, contains("CLRT_24_Bch"))
batch <- apply(data_lab[, -1], 1, function(x) paste(unique(x), collapse = ", ")) # make single batch variable
data_lab$batch <- batch
data_lab <- select(data_lab, Idepic, batch)
data <- left_join(data, data_lab, by = "Idepic")

# exclusions ====
## remove duplicate samples
data <- data[!duplicated(data$Idepic) | duplicated(data$Idepic, fromLast = TRUE), ] # 6
## exclude inelligible tumours
data <- subset(data, Typ_Tumo != "Exc-Morphology excluded") # 5
data <- subset(data, Typ_Tumo != "Exc-Morphology ineligible") # 1
## exclude all individuals without a matched caseset
level_counts <- table(data$Match_Caseset)
data <- data[!data$Match_Caseset %in% names(level_counts)[level_counts < 2], ] # 92
## exclude all matched casesets with more than two people
level_counts <- table(data$Match_Caseset)
data <- data[!data$Match_Caseset %in% names(level_counts)[level_counts > 2], ] # 0

# transformations ====
## natural log transform the bile acid metabolites
data <- data %>%
  mutate(across(
    .cols = contains('Ca_CLRT'), # columns to transform contains CLRT - issue with case/control column being included...
    .fns = list(log2), # apply log2 transformation to each column
    .names = "{.col}_log2")) # name the new columns, original, followed by the log transformation

par(mfrow = c(1, 2))
hist(data$Ca_CLRT_24)
hist(data$Ca_CLRT_24_log2)

## inverse rank normal transform 
variables_to_normalize <- c("Ca_CLRT_24_log2", "Cdca_CLRT_24_log2", "Dca_CLRT_24_log2", "Gca_CLRT_24_log2", "Gcdca_CLRT_24_log2", "Gdca_CLRT_24_log2", "Ghca_CLRT_24_log2", "Glca_CLRT_24_log2", "Gudca_CLRT_24_log2", "Hca_CLRT_24_log2", "Tamca_CLRT_24_log2", "Tca_CLRT_24_log2", "Tcdca_CLRT_24_log2", "Tdca_CLRT_24_log2", "Thca_CLRT_24_log2", "Tudca_CLRT_24_log2", "Udca_CLRT_24_log2")
for (variable in variables_to_normalize) {
  data[[paste0(variable, "_normalised")]] <- qnorm((rank(data[[variable]], na.last = "keep") - 0.5) / sum(!is.na(data[[variable]])))  # INT formula
}

par(mfrow = c(1, 3))
hist(data$Ca_CLRT_24)
hist(data$Ca_CLRT_24_log2)
hist(data$Ca_CLRT_24_log2_normalised)

# remove unused cols
data <- select(data, -Typ_Tumo, -Idepic_Bio, 
               -Ca_CLRT_24, -Cdca_CLRT_24, -Dca_CLRT_24, -Gca_CLRT_24, -Gcdca_CLRT_24, -Gdca_CLRT_24, -Ghca_CLRT_24, -Glca_CLRT_24, -Gudca_CLRT_24, -Hca_CLRT_24, -Tamca_CLRT_24, -Tca_CLRT_24, -Tcdca_CLRT_24, -Tdca_CLRT_24, -Thca_CLRT_24, -Tudca_CLRT_24, -Udca_CLRT_24,
               -Ca_CLRT_24_log2, -Cdca_CLRT_24_log2, -Dca_CLRT_24_log2, -Gca_CLRT_24_log2, -Gcdca_CLRT_24_log2, -Gdca_CLRT_24_log2, -Ghca_CLRT_24_log2, -Glca_CLRT_24_log2, -Gudca_CLRT_24_log2, -Hca_CLRT_24_log2, -Tamca_CLRT_24_log2, -Tca_CLRT_24_log2, -Tcdca_CLRT_24_log2, -Tdca_CLRT_24_log2, -Thca_CLRT_24_log2, -Tudca_CLRT_24_log2, -Udca_CLRT_24_log2)

# save ====
write.table(data, "data/phenotypes/phenofile.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

matching_columns <- as.data.frame(names(data)[grep("log2_normalised", names(data))])
write.table(matching_columns, "data/phenotypes/bile_acids.txt", 
            row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")


# make individual phenofiles ====
## rename columns for PLINK format
data <- data %>% 
  dplyr::rename('#FID' = `Idepic`)
data$'#IID' <- data$`#FID`
data <- data[,c(30,1:29)]

# data <- cbind(data[, 1], data)
# names(data)[2] <- '#IID'

## subset 
phenofile_combined_combined <- data # 884
phenofile_combined_cases <- phenofile_combined_combined %>% filter(Cncr_Caco_Clrt == 1) # 442
phenofile_combined_controls <- phenofile_combined_combined %>% filter(Cncr_Caco_Clrt == 0) # 442

phenofile_male_combined <- data %>% filter(Sex == 1) # 346
phenofile_male_cases <- phenofile_male_combined %>% filter(Cncr_Caco_Clrt == 1) # 173
phenofile_male_controls <- phenofile_male_combined %>% filter(Cncr_Caco_Clrt == 0) # 173

phenofile_female_combined <- data %>% filter(Sex == 2) # 538
phenofile_female_cases <- phenofile_female_combined %>% filter(Cncr_Caco_Clrt == 1) # 269
phenofile_female_controls <- phenofile_female_combined %>% filter(Cncr_Caco_Clrt == 0) # 269

## save
write.table(phenofile_combined_combined, "data/phenotypes/phenofile/combined_combined.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(phenofile_combined_cases, "data/phenotypes/phenofile/combined_cases.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(phenofile_combined_controls, "data/phenotypes/phenofile/combined_controls.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

write.table(phenofile_male_combined, "data/phenotypes/phenofile/male_combined.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(phenofile_male_cases, "data/phenotypes/phenofile/male_cases.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(phenofile_male_controls, "data/phenotypes/phenofile/male_controls.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

write.table(phenofile_female_combined, "data/phenotypes/phenofile/female_combined.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(phenofile_female_cases, "data/phenotypes/phenofile/female_cases.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(phenofile_female_controls, "data/phenotypes/phenofile/female_controls.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# extract ID for PCA ====
phenofile_combined_combined <- select(phenofile_combined_combined, `#IID`, `#FID`)
phenofile_combined_cases <- select(phenofile_combined_cases, `#IID`, `#FID`) 
phenofile_combined_controls <- select(phenofile_combined_controls, `#IID`, `#FID`) 

phenofile_male_combined <- select(phenofile_male_combined, `#IID`, `#FID`) 
phenofile_male_cases <- select(phenofile_male_cases, `#IID`, `#FID`) 
phenofile_male_controls <- select(phenofile_male_controls, `#IID`, `#FID`) 

phenofile_female_combined <- select(phenofile_female_combined, `#IID`, `#FID`) 
phenofile_female_cases <- select(phenofile_female_cases, `#IID`, `#FID`) 
phenofile_female_controls <- select(phenofile_female_controls, `#IID`, `#FID`) 

## save 
write.table(phenofile_combined_combined, "data/genetic/PCs/ID/combined_combined.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(phenofile_combined_cases, "data/genetic/PCs/ID/combined_cases.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(phenofile_combined_controls, "data/genetic/PCs/ID/combined_controls.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

write.table(phenofile_male_combined, "data/genetic/PCs/ID/male_combined.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(phenofile_male_cases, "data/genetic/PCs/ID/male_cases.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(phenofile_male_controls, "data/genetic/PCs/ID/male_controls.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

write.table(phenofile_female_combined, "data/genetic/PCs/ID/female_combined.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(phenofile_female_cases, "data/genetic/PCs/ID/female_cases.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")
write.table(phenofile_female_controls, "data/genetic/PCs/ID/female_controls.txt", 
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

# notes ====
## 8 of the 10 potential covarites present in the main data set;
# age at blood sample = Age_Blood
# sex = Sex
# analytical batch = missing
# fasting duration = Fasting_C
# lipid lowering medication = missing
# prevalent diabetes = Diabet
# body mass index (continuous variable) = Bmi_C
# coffee consumption = QgE130301
# fat intake = QE_FAT
# fibre intake = QE_FIBT
# colorectal cancer case/control status = Cncr_Caco_Clrt

## 17 bile acid measurements present in the main data set; Primary/Secondary/Tertiary, conjugated/unconjugated
# Ca_CLRT_24	Cholic acid (nmol/l)
# Cdca_CLRT_24	Chenodeoxycholic acid (nmol/l)
# Dca_CLRT_24	Deoxycholic acid (nmol/l)
# Gca_CLRT_24	Glycocholic acid (nmol/l)
# Gcdca_CLRT_24	Glycochenodeoxycholic acid (nmol/l)
# Gdca_CLRT_24	Glycodeoxycholic acid (nmol/l)
# Ghca_CLRT_24	Glycohyocholic acid (nmol/l)
# Glca_CLRT_24	Glycolithocholic acid (nmol/l)
# Gudca_CLRT_24	Glycoursodeoxycholic acid (nmol/l)
# Hca_CLRT_24	Hyocholic acid (nmol/l)
# Tamca_CLRT_24	Tauro-alpha-muricholic acid (nmol/l)
# Tca_CLRT_24	Taurocholic acid (nmol/l)
# Tcdca_CLRT_24	Taurochenodeoxycholic acid (nmol/l)
# Tdca_CLRT_24	Taurodeoxycholic acid (nmol/l)
# Thca_CLRT_24	Taurohyocholic acid (nmol/l)
# Tudca_CLRT_24	Tauroursodeoxycholic acid (nmol/l)
# Udca_CLRT_24	Ursodeoxycholic acid (nmol/l)
