library(stats)

final_model <- model4
residuals <- resid(final_model)
fitted <- fitted(final_model)

plot(
  fitted,
  residuals,
  xlab = "Fitted Values",
  ylab = "Residuals",
  main = "Residuals vs Fitted"
)
abline(h = 0, lty = 2)

hist(
  residuals,
  breaks = 20,
  main = "Distribution of Residuals",
  xlab = "Residuals"
)

qqnorm(residuals)
qqline(residuals, col = "red")

acf(residuals, main = "ACF of Residuals")