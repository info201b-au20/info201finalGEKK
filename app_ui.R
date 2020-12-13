library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)


intro_page <- tabPanel("Introduction",
                       mainPanel(
                         h2("Introduction"),
                         p("Police violence and homicide in the United States have been linked to
                         persisting systemic racism and implicit bias against people of color.
                         For years. the U.S. police have been abusing their
                         power and responsibilities to serve us as we hear innocent citizens of color get killed.
                         After the police killing of George Floyd, a surge of protests occurred across the United States, shedding
                         spotlight on police brutality and the Black Lives Matter movement. We decided to further examine the datasets
                         of police brutality and killings to find out about trends of police killings over time, who (what groups) have been the main victims of police homicides,
                         and where police brutality is more prominent in the United States. "),
                         img(src='https://img.onmanorama.com/content/dam/mm/en/news/world/images/2020/6/3/george-floyd-protests-3.jpg', height="75%", width="75%"),
                         h4("This Shiny App was created collaboratively by: Katherine Poch, Eivy Cedeno, Kennett Vera, Garsin Zhan"),
                         p("We explored Police Homicide Data Sets from: ", a("https://mappingpoliceviolence.org"))
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
                              h2("Where is Police Brutality More or Less Prominent? "),
                              h3("Purpose"),
                              p("The purpose of this chart is to see the comparison
                                between average rates of violent crimes and average
                                annual rates of police homicide in populated U.S. cities.
                                The average violent crime rate per 1k population is represented
                                in green and the average annual police killings per 1M population is represented in purple "),
                              h3("Findings"),
                              p("This chart reveals where there are high and low
                                police homicide rates in the U.S. Through observing,
                                we see that cities like Memphis and Washington have high
                                violent crime rates, but low police homicide rates.
                                However, cities like Phoenix and Oklahoma City have high police
                                homicide rates, but low violent crime rates. This disparity of values
                                reveals that the levels of violent crimes in the U.S. do not
                                determine rates of police violence."),
                              plotlyOutput("locationchart")
                            )
                          )
                          )
# Eivy
page_two <- tabPanel(
  "interactive visualization page",	#title of the page, what will appear as the tab name
  
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
      
      h4("After a death caused by a police officer there is not much we can do
         for the victim. Raising awareness and praying for the family isn't good
         enough or fair. What really helps is knowing that the officer has been
         charged for the actions commited. Most times the police get away with 
         killing a person without any consequences and this causes them to continue."),
      h4("In the chart below we can see the number of charged police officers 
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
  "interactive visualization page",	#title of the page, what will appear as the tab name

  titlePanel("Do police officers film?"),
  sidebarLayout(
    sidebarPanel(
      selectInput("where", "select a state", choices = police_kill_df$State)
    ),
    
    mainPanel(
      plotOutput("Data")
    )
  )
)



ui <- fluidPage(
  navbarPage(
    inverse = TRUE,
    "Police Brutality",
    intro_page,
    location_page,page_two,page_twee))


