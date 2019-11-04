library(tidyverse)

# Imagine you are a freelancer data analyst and your new client hired you to process the 
# results of three questionnaires they conducted separately:
#   1. about demographics and
#   2. about the education of the participants.
#   3. about their income
# You received the answers of both surveys in csv files from your customer.
# Let's analyze those answers!

# 0. Read datasets from csv files. 
demo_raw <- read_csv("data/demographics.csv", col_types = cols(
  id = col_integer(),
  birth_year = col_integer(),
  birth_month = col_integer(), # if you don't specify schema, you figure out errors in the data much later
  birth_day = col_integer(),
  female = col_logical(), # read as boolean
  country_of_residence = col_character(),
  male = col_logical() # read as boolean
))


edu_raw <- read_csv("data/education.csv", col_types=cols(
  id = col_integer(),
  degree_type = col_character(),
  major = col_character()
))

income_raw <- read_csv("data/income.csv", col_types = cols(
  id = col_integer(),
  `2014` = col_integer(),
  `2015` = col_integer(),
  `2016` = col_integer(),
  `2017` = col_integer(),
  `2018` = col_integer()
))

# 1. Tidy them
demo <- demo_raw %>% 
  unite(birth_date,birth_year, birth_month, birth_day, sep = "/") %>% 
  mutate(birth_date=parse_date(birth_date, format = "%Y/%m/%d")) %>%
  mutate(gender=ifelse(male,"male", ifelse(female, "female", "unknown"))) %>% 
  select(id, birth_date,country_of_residence,gender) 

edu <- edu_raw %>% 
  spread(degree_type, major) %>% 
  arrange(id)

inc <- income_raw %>% 
  gather(key="year", "salary", `2014`, `2015`, `2016`, `2017`, `2018`) %>% 
  arrange(id)

# 2. Let's create dataset(s) containing answers from the surveys. Which join should we use? What should we do with the missing values?
data <- full_join(demo,edu) %>% 
  full_join(inc) %>% 
  arrange(id)

# 3. Check survey data quality for obvious errors in data intake. 
#   Are there people with graduate degree but no undergrad? 
#   Are there people more than 100 yo?

# 4. Answer some of these questions below:
# Are there any career changers? (different undergrad and grad major)
# What's the most popular undergrad major?
# How many females have degree in computer science? 
# Which country has most female graduates?
# Plot the median salary of the respondents over time.
# Which country has the highest average salary? What is we use median?
# Do people with graduate degree earn more?
# Do men earn more than women?



