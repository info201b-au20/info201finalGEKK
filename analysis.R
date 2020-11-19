mpvdata <- read.csv("https://raw.githubusercontent.com/info201b-au20/info201finalGEKK/gh-pages/2013-2019%20Killings%20by%20PD-Table%201.csv")
killings_df <- read.csv("https://raw.githubusercontent.com/info201b-au20/info201finalGEKK/gh-pages/2013-2019%20Killings%20by%20State-Table%201.csv")
police_kill_df <- read.csv("https://raw.githubusercontent.com/info201b-au20/info201finalGEKK/gh-pages/2013-2020%20Police%20Killings-Table%201.csv")
library(tidyverse)
library(ggplot2)
#Order dataset by population size
mpvdata <- mpvdata %>% arrange(desc(Total))
mpvdata1 <- mpvdata[-(103:106),] #take out N/A rows
mpvdata2 <- mpvdata1[-(31:94),] #take out lowest population rows

#####
#Chart 1: police homicide rate vs violent crime rate

mpvdata2_longer <- mpvdata2 %>% pivot_longer(
  cols = c(Avg.Annual.Police.Homicide.Rate, Violent.Crime.Rate),
  names_to = "rate"
)
mpvdata2_longer <- mpvdata2_longer %>% subset(select = c(City, value, rate))
mpvdata2_longer <- mpvdata2_longer[-(1:24),] #too many rows, delete

chart1 <- ggplot(mpvdata2_longer,aes(City, value, fill = rate)) +
  geom_col(position ="dodge") +
  coord_flip() +
  labs(
    title = "Police Homicide Rate vs. Violent Crime Rate in Random Major U.S. Cities, 2013-2018")
#####

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
chart2 <- ggplot(killings_df1, aes(x = factor(1), y=total_deaths,fill=races))+
  geom_col(position = 'stack', 
           show.legend = T) +
  geom_text(aes(label = paste(total_deaths)), 
            position = position_stack(vjust = .50)) +
  coord_polar(theta = "y") +
  theme_void() +
  labs(title = "Total Deaths of Individuals in Each Race from Random Major U.S. Cities, 2013-2018")

###

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


###

