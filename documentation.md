# Project Documentation  
Project: Demographic Modelling of Population Dynamics  
Scope: This document is intended for technical reviewers and focuses on modelling logic, data transformation decisions, and statistical assumptions rather than interpretative findings.

---
## Overview  

This document provides technical documentation for the demographic modelling pipeline. The project analyses annual population growth using structured feature engineering and regression modelling.

The workflow is divided into:

1. Data ingestion and cleaning  
2. Feature engineering  
3. Model construction  
4. Model comparison  
5. Diagnostic validation  
6. One-step-ahead projection  

The objective is not descriptive exploration alone, but structured model fitting and evaluation under different demographic and policy specifications.

---
## Data Processing Logic

> Steps performed in `01_load_and_clean.R`

### Raw Data Source  
The project uses a static World Development Indicators (WDI) extract for China.  
Variables used:  
- Year  
- Total population  
- Fertility rate (births per woman)  
- Crude death rate (per 1,000 people)  
- Net migration  

The raw file is included in: `data/raw/raw_china_wdi.xlsx`

### Cleaning Phase  
- Renaming of WDI column headers to concise variable names.
- Explicit type coercion to numeric and integer formats.
- Removal of rows with missing variable values that are structurally invalid.

Cleaned dataset saved into: `data/clean/clean_china_wdi.csv`

---
## Feature Engineering  

> Implemented in `02_controls_and_policy_phase.R`

### Dynamic Components  
- Annual growth is computed as percentage
- Lagged growth is constructed using lag()
- A five-year rolling growth average is computed using `rollmean()` from the `zoo` package.
- This enables dynamic regression specification.

### Policy Regime Construction  
Policy regimes are defined using structural break thresholds:
- Pre-policy (before 1981)  
- One-child policy (1981–2015)  
- Two-child policy (2016–2020)  
- Post-policy (2021 onward)  

Two representations are created:
1. Multi-level factor (`policy_phase`)
 - Reference level: `pre_policy`
2. Binary dummy (`policy_simplified`)
 - years with active policy: 1  
 - years with no active policy: 0

>*These policy periods are designed based on active policy years.*   
>*The current policy (2021 onwards) allows upto 3 children. But since the fines for having 4 or more children was abolished, it is considered to be 'post-policy' period as there is no legal framework that condemns number of children in a family.*   
>*This research was done on various Wikipedia pages and important ones have been listed under sources.*  

Design rationale:
- Enables both categorical and simplified structural modelling.  
- Allows testing of regime-based structural effects.

The first observation is removed due to undefined lagged growth.  
Multi-level policy factor and rolling 5 year mean growth are only retained for modelling flexibility and future extension, though not required by all specifications.  

---
## Model Construction  

> Implemented in `03_build_models.R`

Four regression specifications are estimated using `lm()`:

### Model 1 — Baseline Demographic Model
(growth ~ fertility + death_rate + net_migration)
*Key drivers obtained from WDI*

### Model 2 — Reduced Specification  
(growth ~ fertility + death_rate)
*Migration removed to assess explanatory contribution.*
*Found to have insignificant impact*

### Model 3 — Policy-Augmented  
(growth ~ fertility + death_rate + policy_simplified)
*Adds structural policy dummy to retained baseline demographic drivers.*

### Model 4 — Dynamic Specification  
(growth ~ fertility + death_rate + lagged_growth + policy_simplified)
*Adds lagged growth term*
*Modelling considers the growth carried forward from last year*

Design rationale:
- Progressive model building.
- Explicit testing of structural and dynamic dependence.
- Clear nesting across specifications.

All models are saved as `.rds` objects in `/outputs`.

---
## Model Comparison  

> Implemented in `04_compare_models.R`.

Two types of outputs are generated:
1. Coefficient comparison table (tidy extraction using `broom::tidy`)
2. Model fit statistics (using `broom::glance`)

Comparison metrics:
- Adjusted R²  
- Residual standard error (`sigma`)  
- F-statistic  

*Emphasises comparative evaluation rather than single-model reporting.*  
*Encourages structural interpretation of specification changes.*  

---
## Diagnostic Validation  

> Implemented in `05_residual_diagnostics.R`.

Diagnostics include:
- Residual vs fitted plot (linearity and homoskedasticity)
- Histogram of residuals (distribution inspection)
- Q–Q plot (normality check)
- Autocorrelation function (ACF) plot (serial dependence)

Purpose:
- Validate classical OLS assumptions.
- Identify dynamic misspecification.
- Assess time-series residual structure.

Outputs saved in: `outputs/diagnostics/`

---
## Projection Logic  

> Implemented in `06_implied_growth.R`.

The final model (dynamic specification) is used to generate a one-step-ahead prediction.

Steps:
1. Extract most recent observation.
2. Predict growth using `predict()`.
3. Convert predicted percentage growth into implied next-period population.

This produces a conditional projection rather than a recursive simulation.

Output saved to: `outputs/implied_population_projection.csv`

---
## Assumptions and Limitations  

- Linear functional form is assumed.
- No explicit stationarity testing is conducted.
- OLS estimation assumes exogeneity of regressors.
- Serial correlation is inspected visually but not formally tested.
- Policy breakpoints are imposed deterministically, not statistically estimated.
- Forecast is one-step conditional, not multi-period dynamic.

---
## Reproducibility  

The full modelling workflow can be executed from a fresh R session by running:

```r
source("scripts/run_all/run_all.R")

The project is deterministic under identical data and package versions.
