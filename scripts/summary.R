mpvdata <- read.csv("https://raw.githubusercontent.com/info201b-au20/info201finalGEKK/gh-pages/2013-2019%20Killings%20by%20PD-Table%201.csv")
library(tidyverse)

summary_info <- list()
summary_info$num_observations <- nrow(mpvdata) # number of rows
summary_info$num_features <- ncol(mpvdata) # number of columns
columns <- colnames(mpvdata)


#What was the highest police homicide rate in a police department?
summary_info$highest_homicide_rate <- mpvdata %>%
  filter(Avg.Annual.Police.Homicide.Rate == max(Avg.Annual.Police.Homicide.Rate,
                                                na.rm = T)) %>%
  pull(Avg.Annual.Police.Homicide.Rate)

#What was the highest police homicide rate for Black people in a police department?
summary_info$highest_homicide_forblack <- mpvdata %>%
  filter(Avg.Annual.Police.Homicide.Rate.for.Black.People ==
           max(Avg.Annual.Police.Homicide.Rate.for.Black.People, na.rm = T)) %>%
  pull(Avg.Annual.Police.Homicide.Rate.for.Black.People)

#Which city has the highest violent crime rate?
summary_info$highest_violent_rate <- mpvdata %>%
  filter(Violent.Crime.Rate == max(Violent.Crime.Rate, na.rm = T)) %>%
  pull(City)

#Which city has the highest estimated average annual arrests?
summary_info$highest_annual_arrests <- mpvdata %>%
  filter(Estimated.Average.Arrests.per.Year 
         == max(Estimated.Average.Arrests.per.Year,
                                                   na.rm = T)) %>%
  pull(City)

#What is the nationwide average for police killings?
summary_info$nation_police_killings <- mpvdata %>%
  filter(City == "Nationwide Average") %>%
  pull(All.People.Killed.by.Police..1.1.2013.12.31.2019.)
