library(broom)
library(dplyr)
library(tidyr)
library(purrr)

models <- list(
  model1 = model1,
  model2 = model2,
  model3 = model3,
  model4 = model4
)

coeffs <- purrr::map_dfr(
  models,
  tidy,
  .id = "model"
)
View(coeffs)
coeff_table <- coeffs %>%
  select(model, term, estimate, p.value, std.error) %>%
  pivot_wider(
    names_from = model,
    values_from = estimate
  )
View(coeff_table)

stats <- purrr::map_dfr(
  models,
  glance,
  .id = "model"
)
View(stats)
model_fit_table <- stats %>%
  select(
    model,
    adj.r.squared,
    sigma,
    statistic
  )
View(model_fit_table)
