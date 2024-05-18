library(dplyr)
library(ggplot2)
library("RSocrata")
library(tidyverse)

crime_data  <- read.socrata("https://data.seattle.gov/resource/tazs-3rd5.csv")

yearly_data <- crime_data %>%
  mutate(Year = format(as.POSIXct(report_datetime, format="%Y-%M-%D"), "%Y"))

year_crime <- select(yearly_data, Year)
year_table <- table(year_crime$Year)
year_total <- as.data.frame(year_table) 
colnames(year_total) <- c("Year", "Amount")

ggplot(year_total, aes(x = Year, y = Amount, group = 1)) + geom_point() + labs(x = "Year", y = "Total Crimes Committed", title = "Total Crimes Commited from 2008 to 2024") + geom_line(group = 1)
