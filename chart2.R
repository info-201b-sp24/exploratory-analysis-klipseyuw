library(dplyr)
library(ggplot2)
library("RSocrata")
library(tidyverse)

crime_data  <- read.socrata("https://data.seattle.gov/resource/tazs-3rd5.csv")

summarized <- filter(crime_data, mcpp != "<Null>") %>% 
  filter(mcpp != "") %>%
  group_by(mcpp) %>% 
  summarize(count = n()) %>% 
  mutate(percent = count / sum(count) * 100) %>%
  filter(percent >= 1)

ggplot(summarized, aes(x = "", y = percent, fill = mcpp)) +
  geom_col(color = "black") + 
  scale_fill_viridis_d() +
  theme_void() +
  theme(legend.position = 'top', legend.key.size = unit(1, "line"), legend.text = element_text(size = 6)) +
  geom_text(aes(x = 1.6, label = round(percent, digits = 2)), position = position_stack(vjust = 0.5), size = 3) +
  coord_polar(theta = "y") +
  labs(fill = "Category") +
  guides(fill = guide_legend(title = "Location")) +
  labs(title="Different Types of Crimes Committed in Seattle")

