library(readr)
library(dplyr)
library(zoo)
library(tidyr)

clean_china <- read_csv("data//clean_china_wdi.csv")
head(clean_china)
clean_china <- clean_china %>% 
  mutate(
    growth_by_year = round(100*(population-lag(population)) / lag(population), digits = 2),
    lagged_growth = lag(growth_by_year),
    rolling_5yr_growth = rollmean(growth_by_year, k=5, align="right", fill=NA)
  )
View(clean_china)                      
clean_china <- clean_china %>% 
  mutate(
    policy_phase = factor(
      case_when(
        year<1981 ~ "pre_policy",
        year<2016 ~ "one_child_policy",
        year<2021 ~ "two_child_policy",
        TRUE ~ "post_policy"
      )
    )
  )
    
clean_china <- clean_china %>% mutate(
  policy_phase = relevel(policy_phase, ref = "pre_policy")
) %>%
  mutate(
    policy_simplified = if_else(policy_phase %in% c("one_child_policy", "two_child_policy"),
                                1,
                                0)
  ) %>% drop_na()
clean_china
write_csv(clean_china, "data//base_for_models.csv")
