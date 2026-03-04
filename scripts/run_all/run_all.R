# File: run_all.R
# Project: Population Growth Modeling
# Purpose: Execute full modelling pipeline sequentially

source("scripts/00_setup.R")
source("scripts/01_load_and_clean.R")
source("scripts/02_controls_and_policy_phase.R")
source("scripts/03_build_models.R")
source("scripts/04_compare_models.R")
source("scripts/05_residual_diagnostics.R")
source("scripts/06_implied_growth.R")
