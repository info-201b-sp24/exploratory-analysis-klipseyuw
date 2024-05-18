library(dplyr)
library(ggplot2)
library("RSocrata")
library(tidyverse)

crime_data  <- read.socrata("https://data.seattle.gov/resource/tazs-3rd5.csv")

number_of_unique_offense <- crime_data %>% 
  count(offense, name = "num_observations")

total_crimes <-sum(number_of_unique_offense$n)

most_frequent_offense <- crime_data %>% 
  count(offense, name = "num_observations") %>%
  filter(num_observations == max(num_observations))
  
most_frequent_crime_against <- crime_data %>%
  count(crime_against_category, name = "num_observations") %>%
  filter(num_observations == max(num_observations))

highest_crime_location <- crime_data %>% 
  count(mcpp, name = "num_observations") %>% 
  filter(num_observations == max(num_observations))

year_most_crime_reported <- crime_data %>%
  mutate(Year = format(as.POSIXct(report_datetime, format="%Y-%M-%D"), "%Y")) %>%
  count(Year, name = "num_observations") %>%
  filter(num_observations == max(num_observations))

print(nrow(number_of_unique_offense))

print(total_crimes)

print(most_frequent_offense$offense)

print(most_frequent_crime_against$crime_against_category)

print(highest_crime_location$mcpp)

print(year_most_crime_reported$Year)
