library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("darkly"),
                  
                  titlePanel('Analysis of Variance'),
                  tabsetPanel(
                    tabPanel("Description",
                             sidebarLayout(
                               sidebarPanel(
                                 withMathJax(helpText('This module demonstrates ANOVA for this model
                                                      $$Y_{ij}=\\mu_{i}+\\epsilon_{ij}$$ where \\(\\mu\\) is the group
                                                      mean, and \\(\\epsilon\\) is the random error term
                                                      \\(\\sim N(0, \\sigma^2)\\). There are three groups \\(i=1,2,3\\) and n
                                                      individuals \\(j=1,2,\\cdots,n\\) in each group. The goal here is
                                                      to test the hypothesis \\(H_0: \\mu_1=\\mu_2=\\mu_3\\) 
                                                      We can use F-test here: \\(F=MS_{between}/MS_{within}\\).'))
                                 ),
                               mainPanel()
                                 )
                                 ),
                    tabPanel("ANOVA",
                             sidebarLayout(
                               sidebarPanel(
                                 
                                 sliderInput('mu1', 'Group 1 Mean \\(\\mu_1\\)', min = -5, max = 5, value = 1, step = .1),
                                 sliderInput('mu2', 'Group 2 Mean \\(\\mu_2\\)', min = -5, max = 5, value = 1, step = .1),
                                 sliderInput('mu3', 'Group 3 Mean \\(\\mu_3\\)', min = -5, max = 5, value = 1, step = .1),
                                 sliderInput('sigma', '\\(\\sigma\\)', min = 0, max = 10, value = 1, step = .1),
                                 sliderInput('n', '\\(n\\)', min = 2, max = 100, value = 30, step = 1),
                                 sliderInput('sim', 'Number of Simulations', min = 1, max = 1000, value = 1),
                                 h3("Critical F Value"),
                                 verbatimTextOutput('Fcrit')
                                 # plotOutput('Fdist')
                               ),
                               
                               mainPanel(
                                 helpText('The black bars denote group means.'),
                                 plotOutput('aovPlot'),
                                 h3('ANOVA Table'),
                                 verbatimTextOutput('aovSummary'),
                                 plotOutput('pvalueplot')
                               )
                             ))
                    
                                 ),
                  
                  mainPanel()
                                 ))