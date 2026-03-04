# Demographic Modelling of Population Dynamics — Analysis Report

## Abstract
This project presents a structured regression-based analysis of demographic drivers of annual population growth. Using a cleaned extract of World Development Indicators (WDI) data, the study examines how fertility, mortality, net migration, and policy regimes interact to explain population growth dynamics.

The modelling framework progresses through multiple regression specifications, beginning with baseline demographic drivers and gradually incorporating structural policy indicators and dynamic components. The final specification introduces lagged population growth to capture demographic inertia.

Model comparison, coefficient inspection, and residual diagnostics are used to evaluate the explanatory strength and statistical validity of each specification. While the project includes a one-step-ahead projection of population growth, the primary objective is model fitting and structural interpretation rather than forecasting.

---
## Objectives

The main objectives of this project are:
- Identify key demographic drivers of annual population growth
- Examine whether migration meaningfully contributes to growth dynamics
- Assess the influence of population control policies on growth behaviour
- Evaluate dynamic dependence in population growth through lagged terms
- Demonstrate a structured statistical modelling workflow in R

---
## Dataset Description

- **Source:** World Development Indicators (World Bank)
- **Country:** China
- **Frequency:** Annual observations
- **Variables Used:**

| Variable | Description |
|---|---|
| Year | Observation year |
| Population | Total population |
| Fertility rate | Births per woman |
| Death rate | Crude death rate per 1,000 people |
| Net migration | Net migration count |

The dataset is provided as a single Excel file and processed using an R-based data pipeline.

---
## Modelling Framework

The modelling strategy follows a progressive specification approach.

### Model 1 — Baseline Demographic Model
*growth ~ fertility + death_rate + net_migration*

This model represents the basic demographic accounting framework where population change depends on births, deaths, and migration.

### Model 2 — Reduced Demographic Model
*growth ~ fertility + death_rate*

Migration is removed to evaluate whether it contributes significantly to explaining population growth.

### Model 3 — Policy-Augmented Model
*growth ~ fertility + death_rate + policy_simplified*

A policy dummy variable is introduced to capture the structural effect of China's population control policies.

### Model 4 — Dynamic Specification
*growth ~ fertility + death_rate + lagged_growth + policy_simplified*

A lagged growth term is added to capture demographic persistence, recognising that population dynamics often exhibit temporal inertia.

---
## Model Comparison

Models are compared using three key statistics:
- Adjusted R²
- Residual Standard Error
- F-statistic

These metrics allow evaluation of explanatory power while accounting for model complexity.

The progressive modelling structure highlights how explanatory power changes when migration is removed, or policy regimes, and lagged growth are incorporated.

---
## Key Findings

### Migration Contribution

Removing migration from the baseline specification results in minimal change in explanatory power, suggesting that migration contributes little to explaining aggregate population growth in this dataset.

### Policy Regime Effects

Introducing the policy dummy variable improves interpretability by separating demographic drivers from structural policy periods. The effect indicates that policy interventions coincide with changes in population growth behaviour.

### Dynamic Dependence

The dynamic specification including lagged growth demonstrates that population growth exhibits persistence across periods. This indicates that demographic momentum plays an important role in shaping observed growth patterns.

---
## Diagnostic Assessment

Residual diagnostics are performed on the final specification to evaluate model assumptions.

The diagnostics include:
- Residual vs fitted inspection
- Residual distribution analysis
- Q–Q normality assessment
- Residual autocorrelation analysis

These diagnostics suggest that the model broadly captures the central structure of the data, though further formal testing could strengthen statistical validation.

---
## One-Step Population Projection

The final model is used to generate a conditional one-step-ahead projection.

Steps performed:
1. Extract the most recent observation
2. Predict next-period growth using the fitted model
3. Convert predicted growth into an implied population value

This produces a conditional estimate of next-period population assuming current structural relationships remain unchanged.

---
## Limitations

Several modelling limitations should be noted:
- The project assumes linear relationships between drivers and population growth.
- Stationarity of time-series variables is not formally tested.
- Regressors are assumed to be exogenous.
- Structural breakpoints are imposed rather than statistically estimated.
- Residual autocorrelation is inspected visually rather than formally tested.
- Projection is limited to a single-step conditional estimate.

---
## Potential Extensions

Future work could extend this analysis through:
- Introducing extra drivers; `rolling_5yr_growth` and `policy_phase` instead of the simplified policy structure.
- Formal structural break testing
- Stationarity testing and time-series modelling
- Alternative functional forms (log transformations)
- Instrumental variable approaches for potential endogeneity

---
## Conclusion
This project demonstrates a structured demographic modelling workflow combining data cleaning, feature engineering, regression specification, and diagnostic validation. The analysis highlights the relative importance of demographic drivers and the persistence of growth dynamics across time.

Rather than focusing on forecasting, the project emphasises the process of model construction, comparison, and interpretation within a reproducible analytical pipeline.

---
## References
- World Bank — World Development Indicators  
- Population policy information obtained from publicly available historical summaries of China's family planning policies
