killings_df <- read.csv("https://raw.githubusercontent.com/info201b-au20/info201finalGEKK/gh-pages/2013-2019%20Killings%20by%20State-Table%201.csv")
library(tidyverse)
library(ggplot2)

#Gathered the killings dataframes 
killings_df1 <- killings_df %>% 
  select(ends_with("people.killed"))

#Converted column into rows and got the sum of killings of each race
killings_df1 <- data.frame(mapply(sum,killings_df1[,-7], na.rm = T))

#Added the race and number of total deaths
killings_df1$race <- rownames(killings_df1)
colnames(killings_df1) <- c("total_deaths", "race")

#Made a sentence using the race and kills
killings_df1 <- killings_df1 %>%
  unite(races, race, total_deaths, sep = " = ", na.rm = T, remove = F) %>% 
  mutate(races = str_sub(races, 4))


#Chart 2: Total deaths/kills for each race
ggplot(killings_df1, aes(x = factor(1), y=total_deaths,fill=races))+
  geom_col(position = 'stack', 
           show.legend = T) +
  coord_polar(theta = "y") +
  theme_void() +
  labs(title = "Total deaths of individuals in each race")

