# File: 00_setup.R
# Project: Demographic Modelling of Population Dynamics
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
      dependencies = TRUE,
      ask = FALSE
    )
  }
}
