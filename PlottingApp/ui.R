#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
#
shinyUI(fluidPage(theme = shinytheme("darkly"),
                  
                  # Application title
                  titlePanel("Graphing of Various Functions"),
                  tabsetPanel(
                    tabPanel("Quadratic",
                             sidebarLayout(
                               sidebarPanel(
                                 sliderInput("CoeffSq",
                                             "Coefficient of x^2",
                                             min = -10,
                                             max = 10,
                                             value = 0,
                                             animate = TRUE),
                                 sliderInput("Coeffx", 
                                             label = "Coefficient of x", 
                                             min = -10, 
                                             max = 10,
                                             value = 0,
                                             animate = TRUE),
                                 sliderInput("CoeffC",
                                             label = "Constant",
                                             min = -10,
                                             max = 10,
                                             value = 0,
                                             animate = TRUE),
                                 numericInput("xValue",
                                              label = "Input an X-value",
                                              value = 0),
                                 verbatimTextOutput("yValue"),
                                 verbatimTextOutput("solution"),
                                 actionButton("reset_input", "Clear")
                               ),
                               mainPanel(
                                 plotOutput("plot")
                               )
                             )
                    ),
                    tabPanel("Other graphing styles",
                             sidebarLayout(
                               sidebarPanel(
                                 selectInput("eqtype", 
                                             label = "Equation Type", 
                                             c(Logarithmic = "logarithm",
                                               Exponential = "exponential")),
                                 conditionalPanel(
                                   condition = "input.eqtype == 'logarithm'",
                                   h3("Given a Log Equation of the form logb(ax+c)"),
                                   radioButtons("inputtype",
                                                "Input Type",
                                                choices = c("Self-Input", "Slider")),
                                   conditionalPanel(
                                     condition = "input.inputtype == 'Self-Input'",
                                     numericInput("base", label = "Input the base", value = 0)
                                   ),
                                   conditionalPanel(
                                     condition = "input.inputtype == 'Slider'",
                                     sliderInput("base2",
                                                 label = "Value of the base",
                                                 min = 2,
                                                 max = 12,
                                                 value = 10,
                                                 animate = TRUE)
                                   ),
                                   sliderInput("a",
                                               label = "Value of a",
                                               min = -10,
                                               max = 10,
                                               value = 0,
                                               animate = TRUE),
                                   sliderInput("c",
                                               label = "Value of c",
                                               min = -10,
                                               max = 10,
                                               value = 1,
                                               animate = TRUE),
                                   actionButton("reset_input2", "Clear")
                                   
                                 ),
                                 conditionalPanel(
                                   condition = "input.eqtype == 'exponential'",
                                   h3("Given a Exp Equation of the form a*b^x+c"),
                                   sliderInput("a2",
                                               label = "Value of a",
                                               min = -10,
                                               max = 10,
                                               value = 0,
                                               animate = TRUE),
                                   sliderInput("b2",
                                               label = "Value of b",
                                               min = -10,
                                               max = 10,
                                               value = 0,
                                               animate = TRUE),
                                   sliderInput("c2",
                                               label = "Value of c",
                                               min = -10,
                                               max = 10,
                                               value = 0,
                                               animate = TRUE),
                                   sliderInput("d2",
                                               label = "Y Range",
                                               min = -1000,
                                               max = 1000,
                                               value = c(-10,10)),
                                   actionButton("reset_input3", "Clear")
                                   
                                 )
                               ),
                               mainPanel(
                                 conditionalPanel(
                                   condition = "input.eqtype == 'exponential'",
                                   plotOutput("plot2")
                                 ),
                                 conditionalPanel(
                                   condition = "input.eqtype == 'logarithm'",
                                   conditionalPanel(
                                     condition = "input.inputtype == 'Self-Input'",
                                     plotOutput("plot3")
                                   ),
                                   conditionalPanel(
                                     condition = "input.inputtype == 'Slider'",
                                     plotOutput("plot4")
                                   )
                                 )
                                 
                               )
                               
                             ))
                    
                  )
                  
                  
                  
)
)

