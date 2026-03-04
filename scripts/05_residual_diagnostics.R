# File: 05_residual_diagnostics.R
# Project: Population Growth Modeling
# Purpose: Perform residual diagnostics on final model

library(here)

# Load final model
final_model <- readRDS(
  here("outputs", "model4.rds")
)

residuals <- resid(final_model)
fitted_values <- fitted(final_model)

# Create diagnostics directory if it does not exist
dir.create(
  here("outputs", "diagnostics"),
  showWarnings = FALSE
)

# 1. Residuals vs Fitted
png(here("outputs", "diagnostics", "residuals_vs_fitted.png"))
plot(
  fitted_values,
  residuals,
  xlab = "Fitted Values",
  ylab = "Residuals",
  main = "Residuals vs Fitted"
)
abline(h = 0, lty = 2)
dev.off()

# 2. Histogram of Residuals
png(here("outputs", "diagnostics", "residual_histogram.png"))
hist(
  residuals,
  breaks = 20,
  main = "Distribution of Residuals",
  xlab = "Residuals"
)
dev.off()

# 3. Q-Q Plot
png(here("outputs", "diagnostics", "qq_plot.png"))
qqnorm(residuals)
qqline(residuals, col = "red")
dev.off()

# 4. Autocorrelation Function
png(here("outputs", "diagnostics", "acf_residuals.png"))
acf(
  residuals,
  main = "ACF of Residuals"
)
dev.off()
