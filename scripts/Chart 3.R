police_kill_df <- read.csv("https://raw.githubusercontent.com/info201b-au20/info201finalGEKK/gh-pages/2013-2020%20Police%20Killings-Table%201.csv")
library(tidyverse)

# changes format of date so its easier to work with
police_kill_df$Date.of.Incident..month.day.year. <- as.Date(
  police_kill_df$Date.of.Incident..month.day.year., '%m/%d/%y')

# pulls the dates from the dataset
# Grabs the years and gets rid of months and days
# creates table with occuracnes per year
dates <- police_kill_df$Date.of.Incident..month.day.year.
years <- (format(dates, format = "%Y"))
deaths_per_year2<- as.data.frame(table(years))

# groups the year and deaths of that year as an array
# plots the deaths per year in a line graph 
a <- table(years)
chart3 <- plot(a, 
     type="o",
     col = "blue",
     main = "police brutality: YEAR vs. DEATHS", 
     xlab = "Year",
     ylab = "Deaths by Cops")
