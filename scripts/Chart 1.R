mpvdata <- read.csv("https://raw.githubusercontent.com/info201b-au20/info201finalGEKK/gh-pages/2013-2019%20Killings%20by%20PD-Table%201.csv")
library(tidyverse)
mpvdata <- mpvdata %>% arrange(desc(Total)) 
mpvdata1<- mpvdata[-(103:106),]
mpvdata2<- mpvdata1[-(31:94),]

#Chart 1: police homicide rate in each city 
ggplot(data = mpvdata2) +
  geom_point(mapping = aes(x = reorder(City, Avg.Annual.Police.Homicide.Rate),
                           y = Avg.Annual.Police.Homicide.Rate),
             col = "red") + theme(axis.text.x = element_text(angle = 90)) + 
  labs(x = "City", y = "Avg Annual Police Homicide Rate per 1M", 
       title = "Police Homicide Rate in Major U.S. Cities, 2013-2018")  

ggplot(data = mpvdata2) +
  geom_point(mapping = aes(x = Violent.Crime.Rate,
                           y = Avg.Annual.Police.Homicide.Rate, col = City))

#violent crime rate plot, probs delete
ggplot(data = mpvdata2) +
geom_point(mapping = aes(x = reorder(City, Avg.Annual.Police.Homicide.Rate), 
                         y = Violent.Crime.Rate),
           col = "black") + theme(axis.text.x = element_text(angle = 90))


#overlay of two plots, probs delete
ggplot(data = mpvdata2) +
  geom_point(mapping = aes(x = reorder(City, Avg.Annual.Police.Homicide.Rate), 
                           y = Violent.Crime.Rate),
             col = "black") + theme(axis.text.x = element_text(angle = 90)) + 
  geom_point(mapping = aes(x = reorder(City, Avg.Annual.Police.Homicide.Rate),
                           y = Avg.Annual.Police.Homicide.Rate),
             col = "red") + theme(axis.text.x = element_text(angle = 90)) +
  scale_y_continuous(name = "Avg Violent Crime Rate per 1k Population",
    sec.axis = sec_axis(~.*3/5,name = "Avg Annual Police Homicide Rate per 1M population")) +
  labs(x = "City")   

