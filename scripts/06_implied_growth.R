last_row <- clean_china[nrow(clean_china), ]
last_row

predicted_growth <- predict(
  final_model,
  newdata=last_row
)
predicted_growth

last_population <- last_row$population
implied_population <- last_population * (1 + predicted_growth / 100)
data.frame(
  year = last_row$year + 1,
  implied_population = implied_population,
  implied_growth = predicted_growth
)
