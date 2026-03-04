# File: 06_implied_growth.R
# Project: Population Growth Modeling
# Purpose: Compute next-period implied population using final model

library(readr)
library(here)

# Load modelling dataset
clean_china <- read_csv(
  here("data", "clean", "base_for_models.csv"),
  show_col_types = FALSE
)

# Load final model
final_model <- readRDS(
  here("outputs", "model4.rds")
)

# Extract most recent observation
last_row <- clean_china[nrow(clean_china), ]

# Predict next-period growth
predicted_growth <- predict(
  final_model,
  newdata = last_row
)

# Compute implied next-period population
implied_population <- last_row$population * 
  (1 + predicted_growth / 100)

# Create output table
implied_projection <- data.frame(
  year = last_row$year + 1,
  implied_population = implied_population,
  implied_growth = predicted_growth
)

# Save projection
write_csv(
  implied_projection,
  here("outputs", "implied_population_projection.csv")
)
