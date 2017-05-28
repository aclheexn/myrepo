library(shiny)
library(shinythemes)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  #newForm = reactive({input$CoeffSq*x^2 + 
  # input$Coeffx* x +
  #input$CoeffC})
  # Creating Plot
  
  newVar = reactive({
    value = input$CoeffSq * input$xValue * input$xValue + 
      input$Coeffx * input$xValue +
      input$CoeffC
  })
  
  output$plot <- renderPlot({
    #value = newForm()
    curve(input$CoeffSq*x^2 + 
            input$Coeffx* x +
            input$CoeffC, 
          xlab = 'x', 
          ylab = 'y', 
          main = 'Graph of 2nd Degree Function',
          type = 'l',
          ylim = c(-10, 10),
          xlim = c(-10, 10),
          from = -10,
          to = 10,
          col = randomcoloR::randomColor(count = 3)
    )
  })
  output$plot2 <- renderPlot({
    curve(input$a2*input$b2^x + input$c2,
          xlab = 'x', 
          ylab = 'y', 
          main = 'Graph of Exponential Function',
          type = 'l',
          ylim = input$d2,
          xlim = c(-10, 10),
          from = -50,
          to = 50,
          col = randomcoloR::randomColor(count = 3)
    )
  })
  output$plot3 <- renderPlot({
    
    curve(log(input$a * x + input$c, base = input$base), 
          xlab = 'x', 
          ylab = 'y', 
          main = 'Graph of Logarithm Function',
          type = 'l',
          ylim = c(-10, 10),
          xlim = c(-10, 10),
          from = -10,
          to = 10,
          col = randomcoloR::randomColor(count = 3)
    )
  })
  output$plot4 <- renderPlot({
    
    curve(log(input$a * x + input$c, base = input$base2), 
          xlab = 'x', 
          ylab = 'y', 
          main = 'Graph of Logarithm Function',
          type = 'l',
          ylim = c(-10, 10),
          xlim = c(-10, 10),
          from = -10,
          to = 10,
          col = randomcoloR::randomColor(count = 3)
    )
  })
  observeEvent(input$reset_input, {
    updateNumericInput(session, "xValue", value = 0)
    updateSliderInput(session, "CoeffSq", value = 0)
    updateSliderInput(session, "Coeffx", value = 0)
    updateSliderInput(session, "CoeffC", value = 0)
  })
  
  observeEvent(input$reset_input2, {
    updateSliderInput(session, "base2", value = 10)
    updateNumericInput(session, "base", value = 10)
    
    updateSliderInput(session, "a", value = 0)
    updateSliderInput(session, "c", value = 1)
  })
  observeEvent(input$reset_input3, {
    updateSliderInput(session, "a2", value = 0)
    updateNumericInput(session, "b2", value = 0)
    updateSliderInput(session, "c2", value = 0)
    updateSliderInput(session, "d2", value = c(-10,10))
  })
  
  # Outputting the Y-Value given X-Value
  output$yValue = renderPrint({
    value = newVar()
    paste("Given X-Value and equation, the Y-Value is: ", value)
  })
  
  sol = reactive({
    value = c((-input$Coeffx + sqrt(input$Coeffx^2 - 4*input$CoeffSq*input$CoeffC))/(2*input$CoeffSq)
              ,(-input$Coeffx - sqrt(input$Coeffx^2 - 4*input$CoeffSq*input$CoeffC))/(2*input$CoeffSq))
  })
  
  output$solution = renderPrint({
    value = sol()
    paste0("The solutions to the quadratic equation are ", value[1], " and ", value[2])
  })
  
  
})
