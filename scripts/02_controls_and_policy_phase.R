# File: 02_controls_and_policy_phase.R
# Project: Population Growth Modeling
# Purpose: Engineer growth metrics and policy regime variables for modelling

library(readr)
library(dplyr)
library(zoo)
library(tidyr)
library(here)

clean_china <- read_csv(
  here("data", "clean", "clean_china_wdi.csv"),
  show_col_types = FALSE
)

clean_china <- clean_china %>% 
  arrange(year) %>%
  mutate(
    growth_by_year = round(
      100 * (population - lag(population)) / lag(population),
      digits = 2
    ),
    lagged_growth = lag(growth_by_year),
    rolling_5yr_growth = rollmean(
      growth_by_year,
      k = 5,
      align = "right",
      fill = NA
    )
  )

clean_china <- clean_china %>% 
  mutate(
    policy_phase = factor(
      case_when(
        year < 1981 ~ "pre_policy",
        year < 2016 ~ "one_child_policy",
        year < 2021 ~ "two_child_policy",
        TRUE        ~ "post_policy"
      )
    )
  )

clean_china <- clean_china %>% 
  mutate(
    policy_phase = relevel(policy_phase, ref = "pre_policy")
  ) %>%
  mutate(
    policy_simplified = if_else(
      policy_phase %in% c("one_child_policy", "two_child_policy"),
      1L,
      0L
    )
  )

# Explicitly remove first observation (undefined growth)
clean_china <- clean_china %>%
  filter(!is.na(growth_by_year))

write_csv(
  clean_china,
  here("data", "clean", "base_for_models.csv")
)
