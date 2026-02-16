library(readr)
library(dplyr)
library(ggplot2)

model_base <- read_csv("data/clean/base_for_models.csv")
View(model_base)

plot(growth_by_year~fertility_rate, data = model_base)
plot(growth_by_year~death_rate_per_1000, data = model_base)
plot(growth_by_year~net_migration, data = model_base)
plot(growth_by_year~year, data = model_base, type = "l")

model1 <- lm(
  growth_by_year ~ fertility_rate + 
    death_rate_per_1000 + 
    net_migration, 
  data = model_base
)
summary(model1)

model2 <- lm(
  growth_by_year ~  fertility_rate + 
    death_rate_per_1000,
  data = model_base
)
summary(model2)

model3 <- lm(
  growth_by_year ~  fertility_rate + 
    death_rate_per_1000 +
    policy_simplified,
  data = model_base
)
summary(model3)

model4 <- lm(
  growth_by_year ~  fertility_rate + 
    death_rate_per_1000 +
    lagged_growth +
    policy_simplified,
  data = model_base
)
summary(model4)
