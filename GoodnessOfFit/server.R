#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  OnOff = eventReactive(input$truevalues,{
    x = runif(input$bags)
    x/sum(x)
  })
  
  output$proportions = renderText({
    OnOff()
  })
  
  output$image <- renderImage({
    if (is.null(input$picture))
      return(NULL)
    
    if (input$bags == 1) {
      return(list(
        src = "greenjar.png",
        contentType = "image/png",
        alt = "green"
      ))
    } else if (input$bags == 2) {
      return(list(
        src = "orangejar.png",
        filetype = "image/jpeg",
        alt = "orange"
      ))
    }
    
  }, deleteFile = FALSE)
  
  
  
})
