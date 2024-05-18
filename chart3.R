library(dplyr)
library(ggplot2)
library("RSocrata")
library(tidyverse)

crime_data  <- read.socrata("https://data.seattle.gov/resource/tazs-3rd5.csv")

summarized <- filter(crime_data, offense != "") %>% 
  group_by(offense) %>% 
  summarize(count = n()) %>% 
  mutate(percent = count / sum(count) * 100)

ggplot(summarized, 
       aes(x = count, y = reorder(offense, count))) + 
  theme(axis.text.y = element_text(size = 6)) +
  geom_bar(stat="identity") +
  labs(title = "Amount of Unique Crimes Committed in Seattle", x = "Amount", y = "Offense Type")
