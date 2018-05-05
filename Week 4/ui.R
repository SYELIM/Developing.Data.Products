#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
Sys.setlocale("LC_TIME","C")

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Assault Arrest prediction from Urban Population Percentage"),
        br(),
 
  sidebarLayout(
    sidebarPanel(
            sliderInput("sliderUP", "What is the urban population percentage?", 1, 100, value=50),
            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
    ),
    mainPanel(
            h2("Data Summary"),
            h4("Violent Crime Rates by US State dataset was obtained from datasets package. It contains number of arrests per 100,000 residents for assault, murder, and rape in each 50 US states in 1973. Also it contains the percentage of the urban area population."),
            br(),
            h2("App Explanation"),
            h4("For this project, I specifically focused on number of assault arrests. This application predicts the assault arrests number given the urban population percentage. Move the slidebar on the left to change the urban population percentage. Assault arrests number will be shown on the bottom right of the page."),
            plotOutput("plot1"),
            h3("Predicted Hoursepower from Model 1:"),
            textOutput("pred1"),
            h3("Predicted Hoursepower from Model 2:"),
            textOutput("pred2")
    )
  )
))
            

    
