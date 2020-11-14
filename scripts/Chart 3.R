police_kill_df <- read.csv("https://raw.githubusercontent.com/info201b-au20/info201finalGEKK/gh-pages/2013-2020%20Police%20Killings-Table%201.csv")
library(tidyverse)
library(ggplot2)
library(dplyr)
police_kill_df$count <- 1

police_kill_df$Date.of.Incident..month.day.year. <- as.Date(police_kill_df$Date.of.Incident..month.day.year., '%m/%d/%y')
deaths_per_year <- police_kill_df %>% group_by(Date.of.Incident..month.day.year.) %>% summarize(deaths = sum(count, na.rm <- T))
#deaths_per_year <- deaths_per_year %>% drop_na()
plot(deaths~Date.of.Incident..month.day.year.,data<-deaths_per_year)

#ggplot(deaths_per_year, aes(x=Date.of.Incident..month.day.year.)) + stat_count(geom='line', aes(y=deaths))
#ggplot(deaths_per_year, aes(x=Date.of.Incident..month.day.year.))

#ggplot(deaths_per_year, aes(x = factor(Date.of.Incident..month.day.year.))) + geom_bar()
dates <- police_kill_df$Date.of.Incident..month.day.year.
#a <- table(x,format = "%Y")
years <- (format(dates, format = "%Y"))
deaths_per_year2<- as.data.frame(table(years))
ggplot(deaths_per_year2, aes(x = factor(Freq))) + geom_bar()
ggplot(deaths_per_year2, aes(x=years)) + stat_count(geom='line', aes(y=Freq))

ggplot(deaths_per_year2,aes(years)) + geom_bar()
