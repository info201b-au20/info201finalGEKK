# Load libraries #
library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)
library(dplyr)

source("app_ui.R")
source("app_server.R")

# Run the app through this file.
# Create a new `shinyApp()` using the loaded `ui` and `server` variables
shinyApp(ui = ui, server = server) 