library(readxl)
library(tidyr)
library(dplyr)
library(readr)

raw_data <- read_xlsx("data//raw_china_wdi.xlsx")
head(raw_data)

data <- rename(raw_data, year = ...1)
colnames(data)

data_clean <- data %>% 
  rename(
    population = `Population, total`,
    fertility_rate = `Fertility rate, total (births per woman)`,
    death_rate_per_1000 = `Death rate, crude (per 1,000 people)`,
    net_migration = `Net migration`
  ) %>%
  select (-`...5`)

View(data_clean)

data_clean <- filter(data_clean, !is.na(population)) %>%
  mutate(
    year = as.integer(year),
    population = as.numeric(population),
    fertility_rate = as.numeric(fertility_rate),
    death_rate_per_1000 = as.numeric(death_rate_per_1000),
    net_migration = as.numeric(net_migration)
  ) %>%
  drop_na()

write_csv(data_clean, "data/clean/clean_china_wdi.csv")
