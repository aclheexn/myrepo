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
  titlePanel("Survey Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      numericInput("score",
                   "Input your SAT Math Score(To the nearest 25)",
                   min = 0,
                   max = 800,
                   step = 25,
                   value = 0),
      sliderInput("hours",
                  "Input how many hours you spend on the internet",
                  min = 0,
                  max = 12,
                  value = 0,
                  step = 0.25),
      textInput(inputId = "text", label = "Name", value = "None"),
      selectInput(inputId = "height", label = "Input Your Height(Inches)",
                  choices = seq(48, 78)
      ),
      actionButton("save", label = "Save"),
      actionButton("update", label = "Update Table"),
      actionButton("clear", label = "Clear Table"),
      helpText(textOutput("updated"), style = "color:red")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      verbatimTextOutput("table")
    )
  )
))
