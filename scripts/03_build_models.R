# File: 03_build_models.R
# Project: Population Growth Modeling
# Purpose: Specify and estimate regression models

library(readr)
library(dplyr)
library(here)

# Load modelling dataset
model_base <- read_csv(
  here("data", "clean", "base_for_models.csv"),
  show_col_types = FALSE
)

# Model 1: Full demographic drivers
model1 <- lm(
  growth_by_year ~ 
    fertility_rate + 
    death_rate_per_1000 + 
    net_migration,
  data = model_base
)

# Model 2: Excluding migration
model2 <- lm(
  growth_by_year ~ 
    fertility_rate + 
    death_rate_per_1000,
  data = model_base
)

# Model 3: Add policy dummy
model3 <- lm(
  growth_by_year ~ 
    fertility_rate + 
    death_rate_per_1000 +
    policy_simplified,
  data = model_base
)

# Model 4: Dynamic specification
model4 <- lm(
  growth_by_year ~ 
    fertility_rate + 
    death_rate_per_1000 +
    lagged_growth +
    policy_simplified,
  data = model_base
)

# Save individual models
saveRDS(model1, here("outputs", "model1.rds"))
saveRDS(model2, here("outputs", "model2.rds"))
saveRDS(model3, here("outputs", "model3.rds"))
saveRDS(model4, here("outputs", "model4.rds"))

# Save model list for comparison stage
model_list <- list(
  model1 = model1,
  model2 = model2,
  model3 = model3,
  model4 = model4
)

saveRDS(model_list, here("outputs", "model_list.rds"))
