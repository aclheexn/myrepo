#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("bags",
                  "Number of bags:",
                  min = 1,
                  max = 5,
                  value = 1),
      sliderInput("n",
                  "Bag Count",
                  min = 5,
                  max = 500,
                  value = 50),
      sliderInput("sims",
                  "Simulations",
                  min = 1,
                  max = 1000,
                  value = 1),
      actionButton("truevalues", "Show True Values")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      verbatimTextOutput("proportions"),
      imageOutput("image")
    )
  )
))
