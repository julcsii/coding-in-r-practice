library(tidyverse)
# %>% : Ctrl + Shift + m

# Set seed to create reproducible data
set.seed(42)

# Create demographics dataset
demographics <- tibble(id = sample(1:25, 20), birth_year= sample(1975:1996, 20, replace=T), birth_month= sample(3:12, 20, replace=T), birth_day= sample(1:31, 20, replace=T), female = sample(c(0,1, NA), 20, replace=T), country_of_residence=sample(c("Hungary", "Italy", "Pakistan", "Germany", "Austria", "Spain"), 20, replace = T)) %>% 
  mutate(male=abs(female-1)) 

# Create eductaion dataset
undergrad <- tibble(id = sample(1:20, 20), degree_type = sample(c("undergraduate"), 20, replace=T), major= sample(c("computer science", "mathematics", "business", "law", "medicine", NA), 20, replace=T))
grad <- tibble(id = sample(1:20, 8), degree_type = sample(c("graduate"), 8, replace=T), major= sample(c("computer science", "mathematics", "business", "law", "medicine", NA), 8, replace=T))
education <- full_join(undergrad, grad) %>% arrange(id) 

# Create income dataset
income <- tibble(id=sample(1:20, 20), `2014`= sample(18000:55000, 20, replace=T), `2015`= sample(15000:50000, 20, replace=T), `2016`= sample(18000:55000, 20, replace=T), `2017`= sample(17000:55000, 20, replace=T), `2018`= sample(17000:55000, 20, replace=T))

# Save to csv
demographics %>% 
  write_csv("data/demographics.csv")

education %>% 
  write_csv("data/education.csv")

income %>% 
  write_csv("data/income.csv")
