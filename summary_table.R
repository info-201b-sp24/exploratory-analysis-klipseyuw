library(dplyr)
library(ggplot2)
library("RSocrata")
library(tidyverse)

crime_data  <- read.socrata("https://data.seattle.gov/resource/tazs-3rd5.csv")

table_summary <- select(crime_data, report_datetime, offense, mcpp) %>%
  filter(mcpp != "<Null>") %>% 
  filter(mcpp != "") %>%
  filter(mcpp != "NULL") %>%
  group_by(Location = mcpp) %>%
  summarise(Offenses_Reported = n(), Highest_Type_Of_Offense_Committed = filter(count(crime_data, offense), n == max(n))$offense)

print(arrange(table_summary, Offenses_Reported))
