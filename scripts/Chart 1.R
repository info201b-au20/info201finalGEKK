mpvdata <- read.csv("https://raw.githubusercontent.com/info201b-au20/info201finalGEKK/gh-pages/2013-2019%20Killings%20by%20PD-Table%201.csv")
library(tidyverse)
#Order dataset by population size
mpvdata <- mpvdata %>% arrange(desc(Total)) 
mpvdata1 <- mpvdata[-(103:106),] #take out N/A rows
mpvdata2 <- mpvdata1[-(31:94),] #take out lowest population rows 





#Chart 1: police homicide rate vs violent crime rate

mpvdata2_longer <- mpvdata2 %>% pivot_longer(
  cols = c(Avg.Annual.Police.Homicide.Rate, Violent.Crime.Rate),
  names_to = "rate"
)
mpvdata2_longer <- mpvdata2_longer %>% subset(select = c(City, value, rate))
mpvdata2_longer <- mpvdata2_longer[-(1:24),] #too many rows, delete

ggplot(mpvdata2_longer,aes(City, value, fill = rate)) +
  geom_col(position ="dodge") +
  coord_flip() + 
  labs(
    title = "Police Homicide Rate vs. Violent Crime Rate in Random Major U.S. Cities, 2013-2018")

#Describe the purpose of including the chart:
#The purpose of this chart is to see the comparison between average rates of violent 
#crimes and average annual rates of police homicide in populated U.S. cities. 
#This chart also reveals where there are high and low police homicide rates in the U.S. 

#Describe any notable observations and insights from the chart:
#Cities like Memphis and Washington have high violent crime rates, but low 
#police homicide rates. Cities like Phoenix and Oklahoma City have high police homicide rates,
#but low violent crime rates. 
#This disparity of values reveals that the levels of violent crimes in the U.S. 
#do not determine rates of police violence. 
