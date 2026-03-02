# File: 01_load_and_clean.R
# Project: Population Growth Modeling
# Purpose: Load raw WDI data and produce cleaned dataset

library(readxl)
library(dplyr)
library(readr)
library(here)

# Load raw data
raw_data <- read_xlsx(
  here("data", "raw", "raw_china_wdi.xlsx")
)

# Rename and clean variables
data_clean <- raw_data %>%
  rename(
    year = ...1,
    population = `Population, total`,
    fertility_rate = `Fertility rate, total (births per woman)`,
    death_rate_per_1000 = `Death rate, crude (per 1,000 people)`,
    net_migration = `Net migration`
  ) %>%
  select(
    year,
    population,
    fertility_rate,
    death_rate_per_1000,
    net_migration
  ) %>%
  mutate(
    year = as.integer(year),
    population = as.numeric(population),
    fertility_rate = as.numeric(fertility_rate),
    death_rate_per_1000 = as.numeric(death_rate_per_1000),
    net_migration = as.numeric(net_migration)
  ) %>%
  filter(!is.na(population))

# Save cleaned dataset
write_csv(
  data_clean,
  here("data", "clean", "clean_china_wdi.csv")
)
