library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(dplyr)
library(r2d3)

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
chartstate <- as.data.frame(table(police_kill_df$Body.Camera..Source..WaPo.,police_kill_df$State))

server <- function(input, output){
  output$locationchart <- renderPlotly({
    plot1 <- ggplot(mpvdata2_longer[mpvdata2_longer$City == input$y_input,],aes(City, value, fill = rate)) +
      geom_col(position ="dodge") +
      labs(title = "Police Homicide Rate vs. Violent Crime Rate in Random Major U.S. Cities, 2013-2018", y = "Rate") +
      scale_fill_manual(name = "Rate", 
                        values = c("purple","green"),
                        breaks = c("Avg.Annual.Police.Homicide.Rate", "Violent.Crime.Rate"),
                        labels = c("Avg Annual Police Homicide Rate", "Violent Crime Rate"))
    ggplotly(plot1)
  })
  charged <- table(police_kill_df$Criminal.Charges.) 
  a <-as.data.frame(charged)  #dataset
  output$distPlot <- renderPlot({
    a <- subset(a, a$Var1 == input$whereAt)
    plot(a) 
    
  })
  output$plot <- renderPlot({ggplot(a, aes(Var1, Freq)) + geom_point() +
      theme(axis.text.x=element_text(angle = -90, hjust = 0))})
  
  output$Data <- renderPlot({
    yao <- as.data.frame(table(police_kill_df$Body.Camera..Source..WaPo.== input$where))
    ggplot( yao, aes( x = Freq, y=Var1, fill=Freq ) ) + geom_bar( stat="identity", position="dodge" ) + ylab( "Survailance" ) + ggtitle( "Police killings Survailance By State" )
  })
  output$tab <- renderTable({
    as.data.frame(table(police_kill_df$Body.Camera..Source..WaPo.))
  })
  
  op1 <- reactive({
    chartstate %>% filter(Var2==input$donde)
  })  
  output$Data2 <- renderPlot({
    ggplot(op1(), aes( x = Freq, y=Var1, fill=Freq ) ) + geom_bar( stat="identity", position="dodge" ) + ylab( "Occurances" ) + ggtitle( "Police killings Survailance Activity" )
  })
  
  output$allcities <- renderPlotly({
  plot1a <- ggplot(mpvdata2_longer,aes(City, value, fill = rate)) +
    geom_col(position ="dodge") +
    coord_flip() +
    labs(title = "Police Homicide Rate vs. Violent Crime Rate in Random Major U.S. Cities, 2013-2018", y = "Rate") +
    scale_fill_manual(name = "Rate", 
                      values = c("purple","green"),
                      breaks = c("Avg.Annual.Police.Homicide.Rate", "Violent.Crime.Rate"),
                      labels = c("Avg Annual Police Homicide Rate", "Violent Crime Rate"))
  ggplotly(plot1a)
  })
}
