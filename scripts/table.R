df <- read.csv("https://raw.githubusercontent.com/info201b-au20/info201finalGEKK/gh-pages/2013-2020%20Police%20Killings-Table%201.csv")
View(df)
library(tidyverse)
library(ggplot2)
library(dplyr)

grouped <- df %>%
  group_by(Victim.s.race)
  Summarize(Victim.s.age)
View(grouped)
#pull(grouped)
