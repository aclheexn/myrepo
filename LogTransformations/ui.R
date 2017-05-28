#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

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
            "The task in this assignment is to..."),
    tabItem(tabName = "transformations",
            h2("Log Transformation Task"),
            sidebarLayout(
              sidebarPanel(
                selectInput("inputs", "Select Data Set", choices = c('None', 'Animals', 'World')),
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
                checkboxGroupInput("transforms", "Transform X or Y", c("Transform X", "Transform Y"))
              ),
              
              # Show a plot of the generated distribution
              mainPanel(
                conditionalPanel(
                  condition = "input.inputs == 'World'",
                  plotOutput("worldPlot")
                ),
                conditionalPanel(
                  condition = "input.inputs == 'Animals'",
                  plotOutput("animalPlot")
                  # verbatimTextOutput("summary")
                )
              )))
  )
)


shinyUI(dashboardPage(header, sidebar, body))
