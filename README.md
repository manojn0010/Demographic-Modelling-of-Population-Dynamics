# Demographic Modelling of Population Dynamics
A regression-based modelling project analysing demographic drivers of annual population growth.

---
## Description
This project analyses population growth dynamics through a structured demographic modelling framework. It examines the interaction between key demographic drivers- fertility, mortality, and net migration- and structural policy regimes to understand long-run population behavior.

Using R for data transformation, statistical modelling, and diagnostic validation, the analysis focuses on growth-by-year estimation, regression-based model fitting, and structural interpretation of policy phases. The workflow integrates exploratory visualisation, coefficient analysis, and residual diagnostics to assess model validity and demographic inertia across different policy periods.

### Tools Used
**Statistical Modelling and Analysis:** Base R (`stats`, graphics)  
**Data Manipulation and Visualisation:** `tidyverse`, `broom`, `zoo`, `here` packages  

---
## How to Run

1. Clone the repository. Extract project folder to a preferred location.

2. Create R project  
  - Open RStudio > File > New Project > Existing Directory  
  - Browse to the project directory  
  - Select **Create Project**  

3. Execute the full pipeline
  - Create a new R script and run: `source("scripts/run_all/run_all.R")`
  - This sequentially executes:
    - Package installation (if required)
    - Data loading and cleaning
    - Feature engineering
    - Model estimation
    - Model comparison
    - Residual diagnostics
    - Population projection

4. All outputs are written to `/outputs`.

---
## Data

The project uses a static extract of World Development Indicators (WDI) data.  
The raw dataset is included in the repository; `data/raw/raw_china_wdi.xlsx`.  
Cleaned datasets are generated automatically by the pipeline.

---
## Model Specifications

Drivers of the four regression models built:  
- Baseline demographic model
  - Fertility rate  
  - Death rate  
  - Net migration  
- Reduced demographic model
  - Fertility rate  
  - Death rate  
- Policy-augmented model
  - Fertility rate  
  - Death rate  
  - Policy dummy  
- Dynamic specification
  - Fertility rate  
  - Death rate  
  - Policy dummy  
  - Lagged growth  

Models are compared using:
  - Adjusted R²
  - Residual standard error
  - F-statistic

---
## Project Notes

- Each script is self-contained and loads required inputs explicitly.
- No global environment dependencies are assumed.
- The full pipeline runs from a fresh R session.
- Feature engineering and modelling are separated for clarity and reproducibility.
- Additional project decisions and implementation notes are documented in `/documentation.md`.
- The `/report.md` file summarises the findings and key results of the analysis.
