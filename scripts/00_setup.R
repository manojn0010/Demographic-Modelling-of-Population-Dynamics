# File: 00_setup.R
# Project: Population Growth Modelling
# Purpose: Install and load required R packages

required_packages <- c(
  "tidyverse",
  "zoo",
  "broom",
  "modelsummary",
  "here",
  "lubridate",
  "patchwork",
  "readxl"
)

installed_packages <- rownames(installed.packages())

for (pkg in required_packages) {
  if (!pkg %in% installed_packages) {
    install.packages(
      pkg,
      ask = FALSE
    )
  }
}


