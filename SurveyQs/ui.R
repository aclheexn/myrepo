#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
# input a class code
# Get classes or everybody's data
# Collecting, saving, Download
# Number of responses per quesiton
# Question bank of 10 then giving options to add another question
# Age Gender Major <-- Important Qs(Need 20.  Get info Qs from other groups)


library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Survey Data"),
  numericInput("code",
               "Class Code",
               value = 000),
  
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
                  choices = seq(48, 78)),
      sliderInput("age",
                  "What is your age",
                  min = 0,
                  max = 100,
                  value = 0),
      selectInput("major",
                  "What college are you in",
                  choices = c("Engineering", 
                              "Science", 
                              "Agricultural Sciences",
                              "Arts & Architecture",
                              "Communications",
                              "Earth & Mineral Sciences",
                              "Education",
                              "Health & Human Development",
                              "IST",
                              "Liberal Arts",
                              "DUS",
                              "Business")),
      radioButtons("gender",
                   "Gender",
                   choices = c("Female", "Male")),
      actionButton("save", label = "Save"),
      actionButton("update", label = "Update Table"),
      actionButton("clear", label = "Clear Table"),
      actionButton("show", label = "Show All Data"),
      actionButton("show2", label = "Show Class Data"),
      helpText(textOutput("Updated"), style = "color:red"),
      br(),
      downloadButton("downloadData",
                     "Download All Existing Data")
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      verbatimTextOutput("table"),
      tableOutput("tote")
    )
  )
))
