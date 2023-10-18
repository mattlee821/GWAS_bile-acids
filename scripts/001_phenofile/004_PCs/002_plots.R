rm(list=ls())
set.seed(821)

# environment
library(ggplot2)
library(dplyr)
library(metaboprep)
library(cowplot)
library(tidyverse)

# data ====
## eigenvectors
eigenvalues <- read.table("data/genetic/PCs/combined/case/pca.eigenval", header = F, sep = "\t")
eigenvalues <- eigenvalues %>% mutate(PC = paste0("PC", seq_len(n())))
eigenvalues <- mutate(eigenvalues, label = as.factor(c(1:40)))
eigenvalues <- mutate(eigenvalues, pve = V1/sum(V1))

## eigenvalues
eigenvectors <- read.table("data/genetic/PCs/combined/case/pca.eigenvec", header = F, sep = "\t")
rownames(eigenvectors) <- eigenvectors$V1
eigenvectors <- eigenvectors[, -1]
eigenvectors <- eigenvectors %>%
  rename_with(.cols = starts_with("V"),
              .fn = ~ paste0("PC", as.numeric(gsub("V", "", .)) - 1))
eigenvectors_long <- eigenvectors %>%
  pivot_longer(cols = starts_with("PC"),
               names_to = "PC",
               values_to = "Value")

## combine
eigenvectors_long <- left_join(eigenvectors_long, eigenvalues, by = "PC")

# scree plot ====
sum(eigenvalues$V1)
ggplot(data = eigenvalues, 
       aes(x = label, y = pve)) + 
  geom_point() + 
  geom_line() + 
  ylab("proportion of variance explained") +
  theme_cowplot()

# PC plots
## generate all possible combinations of principal component pairs
pc_pairs <- combn(unique(eigenvectors_long$PC), 2, simplify = FALSE)

## create an empty list to store the scatter plots
scatter_plots <- list()

## iterate over each pair and create scatter plots
for (pair in pc_pairs) {
  pc1 <- pair[1]
  pc2 <- pair[2]
  
  plot_data <- eigenvectors_long %>%
    filter(PC %in% c(pc1, pc2))
  
  a <- subset(plot_data, PC == pc1)
  a <- a %>% rename({{pc1}} := Value)
  pc1_ve <- round(unique(a$V1),2)
  b <- subset(plot_data, PC == pc2)
  b <- b %>% rename({{pc2}} := Value)
  pc2_ve <- round(unique(b$V1),2)
  plot_data <- cbind(a,b)
  plot_data <- plot_data %>% select(!!pc1, !!pc2)
  
  scatter_plot <- 
    ggplot(plot_data, 
           aes(x = !!sym(pc1), y = !!sym(pc2))) +
    geom_point() +
    xlab(paste0(pc1, "(", pc1_ve, "%)" )) +
    ylab(paste0(pc2, "(", pc2_ve, "%)" )) +
    ggtitle(paste("Scatter plot of", pc1, "vs", pc2))
         
         scatter_plots[[paste(pc1, pc2, sep = "_")]] <- scatter_plot
}
scatter_plots_grid <- plot_grid(plotlist = scatter_plots,
                                nrow = 5, ncol = 5)
print(scatter_plots_grid)
