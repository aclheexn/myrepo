#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
# Input Inverse Transformation
# Include bar charts
# Have

library(shiny)
library(shinydashboard)

# Define UI for application that draws a histogram
header = dashboardHeader(title = "LogTransformations",
                         dropdownMenu(type = "messages",
                                      messageItem(
                                        from = "Alex",
                                        message = "Learn the different layouts"
                                      )))

sidebar = dashboardSidebar(
  sidebarMenu(
    menuItem("Overview", 
             tabName = "overview", 
             icon = icon("dashboard")),
    menuItem("Transform",
             icon = icon('th'),
             tabName = "transformations",
             badgeLabel = "Task",
             badgeColor = "blue")
  )
)

body = dashboardBody(
  tabItems(
    tabItem(tabName = "overview",
            h3("Overview of task"),
            "The task in this assignment is to attempt to 
            linearize graphs that don't have any obvious 
            trends in their original x vs. y graph."),
    tabItem(tabName = "transformations",
            h2("Log Transformation Task"),
            sidebarLayout(
              sidebarPanel(
                selectInput("inputs", "Select Data Set", choices = c('None', 'Animals', 'World', 'Make your own')),
                conditionalPanel(
                  condition = "input.inputs == 'World'",
                  selectInput("Xworld", 
                              "Select Your X-Axis", 
                              c('none','gdp', 'income', 'literacy', 'military')),
                  selectInput("Yworld",
                              "Select Your Y-Axis",
                              c('none','gdp', 'income', 'literacy', 'military'))
                ),
                conditionalPanel(
                  condition = "input.inputs == 'Animals'",
                  selectInput("Xanimal",
                              "Select Your X-Axis",
                              c('none','body','brain')),
                  selectInput("Yanimal",
                              "Select Your Y-Axis",
                              c('none','body', 'brain')
                  )
                ),
                selectInput("TransformType", "Transformation Type", choices = c("Logarithmic", "Inverse")),
                conditionalPanel(
                  condition = "input.TransformType == 'Logarithmic'",
                checkboxGroupInput("transforms", "Transform X or Y", c("Transform X", "Transform Y"))),
                conditionalPanel(
                  condition = "input.TransformType == 'Inverse'",
                  checkboxGroupInput("invtransforms", "Transform X or Y", c("Transform X", "Transform Y"))
                )
                #selectInput("plottype", "Plot Type", choices = c("Dot Plot", "Histogram"))
              ),
              
              # Show a plot of the generated distribution
              mainPanel(
                conditionalPanel(
                  condition = "input.inputs == 'World'",
                  plotOutput("worldPlot")
                ),
                conditionalPanel(
                  condition = "input.inputs == 'Animals'",
                  plotOutput("animalPlot"),
                  plotOutput("animalBars"),
                  plotOutput("animalBars2")
                  # verbatimTextOutput("summary")
                  # Add in option to make it a histogram
                )
              )))
  )
)

shinyUI(dashboardPage(header, sidebar, body))
