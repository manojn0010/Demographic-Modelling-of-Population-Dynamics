# File: 04_compare_models.R
# Project: Population Growth Modeling
# Purpose: Compare model coefficients and goodness-of-fit statistics

library(broom)
library(dplyr)
library(tidyr)
library(purrr)
library(readr)
library(here)

# Load saved model list
models <- readRDS(
  here("outputs", "model_list.rds")
)

# Extract coefficients
coeffs <- map_dfr(
  models,
  tidy,
  .id = "model"
)

coeff_table <- coeffs %>%
  select(model, term, estimate, std.error, p.value) %>%
  pivot_wider(
    names_from = model,
    values_from = estimate
  )

# Extract model fit statistics
stats <- map_dfr(
  models,
  glance,
  .id = "model"
)

model_fit_table <- stats %>%
  select(
    model,
    adj.r.squared,
    sigma,
    statistic
  )

# Save comparison outputs
write_csv(
  coeff_table,
  here("outputs", "model_coefficients_comparison.csv")
)

write_csv(
  model_fit_table,
  here("outputs", "model_fit_statistics.csv")
)
