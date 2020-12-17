library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(dplyr)

###### Plot 1: police homicide rate vs violent crime rate data set ##############
mpvdata <- read.csv("https://raw.githubusercontent.com/info201b-au20/info201finalGEKK/gh-pages/2013-2019%20Killings%20by%20PD-Table%201.csv")
police_kill_df <- read.csv("https://raw.githubusercontent.com/info201b-au20/info201finalGEKK/gh-pages/2013-2020%20Police%20Killings-Table%201.csv")
library(tidyverse)
#Order dataset by population size
mpvdata <- mpvdata %>% arrange(desc(Total))
mpvdata1 <- mpvdata[-(103:106),] #take out N/A rows
mpvdata2 <- mpvdata1[-(31:94),] #take out lowest population rows
mpvdata2_longer <- mpvdata2 %>% pivot_longer(
  cols = c(Avg.Annual.Police.Homicide.Rate, Violent.Crime.Rate),
  names_to = "rate"
)
mpvdata2_longer <- mpvdata2_longer %>% subset(select = c(City, value, rate))
mpvdata2_longer <- mpvdata2_longer[-(1:24),] #too many rows, delete
###############################################################################

charged <- table(police_kill_df$Criminal.Charges.) 
a <-as.data.frame(charged)  #dataset2
intro_page <- tabPanel("Introduction",
                       mainPanel(
                         h1("Introduction"),
                         p("Police violence and homicide in the United States
                         have been linked to persisting systemic racism and
                         implicit bias against people of color.
                         For years. the U.S. police have been abusing their
                         power and responsibilities to serve us as we hear
                         innocent citizens of color get killed.
                         After the police killing of George Floyd,
                         a surge of protests occurred across the United States,
                         shedding spotlight on police brutality and the Black
                         Lives Matter movement. We decided to further examine the
                         datasets of police brutality and killings to find out
                         where police brutality is more prominent in the United
                         States, how often police officers get convicted of
                         police homicide and how often police officers use their bodycams."),
                         p("We explored Police Homicide Data Sets from: ", a("https://mappingpoliceviolence.org"),
                         img(src='https://img.onmanorama.com/content/dam/mm/en/news/world/images/2020/6/3/george-floyd-protests-3.jpg', height="75%", width="75%"),
                         h4("This Shiny App was created collaboratively by: Katherine Poch and Eivy Cedeno"),
                         )
                       )
)




###Location Page###
city_names <- unique(mpvdata2_longer$City)


location_page <- tabPanel("Police Homicide Rate vs. Violent Crime Rate",
                          sidebarLayout(
                            sidebarPanel(
                              selectInput(
                                inputId = "y_input",
                                label = "Choose City",
                                choices = city_names,
                                selected = "Oklahoma City"
                              )),
                      
                            mainPanel(
                              h1("Where is Police Brutality More or Less Prominent? "),
                              h3("Purpose"),
                              p("The purpose of this chart is to see the comparison
                                between average rates of violent crimes and average
                                annual rates of police homicide in populated U.S. cities.
                                The average violent crime rate per 1k population is represented
                                in green and the average annual police killings per 1M population is represented in purple "),
                              h3("Findings"),
                              p("This chart reveals where there are high and low
                                police homicide rates in the U.S. Through observing,
                                we see that cities like Memphis and Washington
                                have high violent crime rates, but low police
                                homicide rates. However, cities like Phoenix and
                                Oklahoma City have high police homicide rates,
                                but low violent crime rates. This disparity of values
                                reveals that the levels of violent crimes in the U.S. do not
                                determine rates of police violence."),
                              plotlyOutput("locationchart")
                            )
                          )
                          )
# Eivy
page_two <- tabPanel(
  "Police Homicide Charges",	#title of the page, what will appear as the tab name
  sidebarLayout(
    # Sidebar panel for inputs ----
    sidebarPanel(
      # Input: Slider for the number of bins ----
      selectInput("whereAt", 
                  "select a country", 
                  choices = a$Var1)
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      h1("Do officers get charged for killing a person?"),
      
      p("After a death caused by a police officer there is not much we can do
         for the victim. Raising awareness and praying for the family isn't good
         enough or fair. What really helps is knowing that the officer has been
         charged for the actions commited. Most times the police get away with 
         killing a person without any consequences and this causes them to continue."),
      h3("Conclusion"),
      p("In the chart below we can see the number of charged police officers 
         up to no known charges."),
      # Output: Histogram ----
      plotOutput("distPlot"),
      plotOutput("plot"),
      h5("As you can see, compared to the number of no known charges, basically 
      little to no police get charged after their murder. We have to think about
      the abuse of power that they have and whether killing a person should have 
      exceptions on the penalties for police.")
      
    )
  ))
page_twee <- tabPanel(
  "Police Body Cam Usage",	#title of the page, what will appear as the tab name

  
  sidebarLayout(
    sidebarPanel(
      selectInput("where", "Have the police brutalities been filmed in past 7 
                  years? Select answer.", choices = police_kill_df$Body.Camera..Source..WaPo.)
    ),
    
    mainPanel( 
      h1("Do Police Officers Film?"),
      p("One of the strongest pieces of solid evidence is a film. The police 
         are constantly using the statement of their life being in dangered as an 
         excuse but how do we know that for sure if we can't see what happened? 
         In the plot below you are able to interact with how much of the deaths 
         where recorded by state, beneith that we see a whole view scale of all
        the states."),
      plotOutput("Data"),
      p("In the vast majority of police brutalities there was no video survailance.
         Survailance is not only important to prove if there was a valid cause 
         but also becuase it sends a stronger message seeing rather than just 
        hearing about it.",
        tableOutput("tab"),
        "There have been", nrow(police_kill_df),"deaths by police brutality since
        2013"
        )
    ),
  ),
  sidebarLayout(
    selectInput("donde", "Select State", choices = chartstate$Var2),
    mainPanel(
              h4("Survailance by State"),
              p("It is important to see which states are the ones not recording,
                in this chart you are able to select a specific state."),
              plotOutput("Data2")
    )
)
)

conclusion <- tabPanel("Conclusion",
                       mainPanel(
                         h1("Conclusion"),
                         p("The Police Homicide Rate vs. Violent Crime Rate charts
                         show disparity of values between different locations, which
                         reveals that the levels of violent crimes in the U.S.
                         do not determine rates of police violence. Therefore,
                         there are cities with unnecessary high levels of police
                         violence that are likely targeting minorities. "),
                         plotlyOutput("allcities"),
                         p("In our Police Homicide Charges plots, we see barely
                           any police officers charged for their murder, revealing
                           the abuse of power the police department has executed.
                           In our Police Body Cam Usage plots, we see many police
                           departments in different states partake in not using
                           their cameras, therefore allowing them to commit excessive
                           force, violence, or homicide during arrests without
                           consequences. The body cam video footage is a valuable
                           source of evidence that can be used in court, however,
                           if the police do not turn on their cameras, it is shows
                           an act of abuse of power."),
                         p("We explored Police Homicide Data Sets from: ", a("https://mappingpoliceviolence.org")),
                         h4("Overall, we hope our audience has gained much insight and
                         learned a lot about the issue of Police Violence in the
                         United States. We hope this inspires others to encourage
                         further change in our policing systems and consistently
                         push the Black Lives Matter movement forward.")
                       )
)

ui <- fluidPage(
  includeCSS("style.css"),
  navbarPage(
    inverse = TRUE,
    "Police Brutality",
    intro_page,
    location_page,page_two,page_twee, conclusion))


