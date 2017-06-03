#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(MASS)




# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  # Adding in Data
  worlddata = read.csv('world2.csv')
  worlddata = worlddata[,-c(1,2,7)]
  worlddata = worlddata[-c(36),]
  worlddata$income = as.numeric(worlddata$income)
  animaldata = MASS::Animals
  
  
  # Animal Plots
  output$animalPlot = 
    renderPlot({
      
      #If they don't checkbox anything
      if(length(input$transforms) == 0)
      {
        plot(animaldata[,input$Xanimal], animaldata[,input$Yanimal], xlab = input$Xanimal, ylab = input$Yanimal, main = "Brain(g) vs Body(kg)")
        # abline(lm(animaldata[,input$Xanimal]~animaldata[,input$Yanimal]), col = 'red')
        # legend("topright", bty = "n", legend = paste("R2 is", 
        #                                              format(summary(lm(animaldata[,input$Xanimal]~animaldata[,input$Yanimal]))$adj.r.squared, digits = 4)))
      }
      
      # If they checkbox one of them
      else if(length(input$transforms) == 1)
      {
        # If they only checkbox the Transform Y option
        if(input$transforms == 'Transform Y')
        {
          plot(animaldata[,input$Xanimal], log(animaldata[,input$Yanimal]), xlab = input$Xanimal, ylab = paste("Log:", input$Yanimal), main = "Brain(g) vs Body(kg)")
          # abline(lm(animaldata[,input$Xanimal]~animaldata[,input$Yanimal]), col = 'red')
          # legend("topright", bty = "n", legend = paste("R2 is", 
          #                                              format(summary(lm(animaldata[,input$Xanimal]~log(animaldata[,input$Yanimal])))$adj.r.squared, digits = 4)))
        }
        # If they only checkbox the Transform X option
        else if(input$transforms == 'Transform X')
        {
          plot(log(animaldata[,input$Xanimal]), animaldata[,input$Yanimal], xlab = paste("Log:", input$Xanimal), ylab = input$Yanimal, main = "Brain(g) vs Body(kg)")
          # abline(lm(animaldata[,input$Xanimal]~animaldata[,input$Yanimal]), col = 'red')
          # legend("topright", bty = "n", legend = paste("R2 is", 
          #                                              format(summary(lm(log(animaldata[,input$Xanimal])~animaldata[,input$Yanimal]))$adj.r.squared, digits = 4)))
        }      
        
      }
      #If they check both boxes
      else #Doesn't plot line, but plots R-squared value
      {
        plot(log(animaldata[,input$Xanimal]), log(animaldata[,input$Yanimal]), xlab = paste("Log:", input$Xanimal), ylab = paste("Log:", input$Yanimal), main = "Brain(g) vs Body(kg)")
        # abline(lm(animaldata[,input$Xanimal]~animaldata[,input$Yanimal]), col = 'red')
        # legend("topright", bty = "n", legend = paste("R2 is", 
        #                                              format(summary(lm(log(animaldata[,input$Xanimal])~log(animaldata[,input$Yanimal])))$adj.r.squared, digits = 4)))
      }
      
    })
  
  
  #World Plots(bestfit line doesn't work for Transform y) Maybe Can use ggplot
  output$worldPlot = 
    renderPlot({
      
      if(length(input$transforms) == 0)
      {
        plot(worlddata[,input$Xworld], worlddata[,input$Yworld], xlab = input$Xworld, ylab = input$Yworld, main = paste(input$Xanimal, "vs", input$Yanimal))
        #abline(lm(worlddata[,input$Xworld]~worlddata[,input$Yworld]), col = 'red')
        #legend("topright", bty = "n", legend = paste("R2 is", 
                                                     #format(summary(lm(worlddata[,input$Xworld]~worlddata[,input$Yworld]))$adj.r.squared, digits = 4)))
      }
      
      else if(length(input$transforms) == 1)
      {
        if(input$transforms == 'Transform Y')
        {
          plot(worlddata[,input$Xworld], log(worlddata[,input$Yworld]), xlab = input$Xworld, ylab = paste("Log:", input$Yworld), main = paste(input$Xanimal, "vs", "Log:", input$Yanimal))
          #abline(lm(worlddata[,input$Xworld]~worlddata[,input$Yworld]), col = 'red')
        }
        else if(input$transforms == 'Transform X')
        {
          plot(log(worlddata[,input$Xworld]), worlddata[,input$Yworld], xlab = paste("Log:", input$Xworld), ylab = input$Yworld, main = paste("Log:", input$Xanimal, "vs", input$Yanimal))
          #abline(lm(worlddata[,input$Xworld]~worlddata[,input$Yworld]), col = 'red')
        }
      }
      
      else
      {
        plot(log(worlddata[,input$Xworld]), log(worlddata[,input$Yworld]), xlab = paste("Log:", input$Xworld), ylab = paste("Log:", input$Yworld), main = paste("Log:", input$Xanimal, "vs", "Log:", input$Yanimal))
        #abline(lm(worlddata[,input$Xworld]~worlddata[,input$Yworld]), col = 'red')
      }
      
    })
  
  #Histograms of both variables
  observeEvent(input$hist, {
    output$animalBars =
      renderPlot({
        if(input$loghist1 == TRUE)
        {
          hist(log(animaldata[,input$Xanimal]),
               main = paste("Histogram of Log:", input$Xanimal, sep = ''),
               xlab = paste("Log:", input$Xanimal))
        }
        else{
          hist(animaldata[,input$Xanimal],
               main = paste("Histogram of", input$Xanimal),
               xlab = input$Xanimal)
        }
      })
    output$animalBars2 =
      renderPlot({
        if(input$loghist2 == TRUE)
        {
          hist(log(animaldata[,input$Yanimal]),
               main = paste("Histogram of Log:", input$Yanimal, sep = ''),
               xlab = paste("Log:", input$Yanimal))
        }
        else{
          hist(animaldata[,input$Yanimal],
               main = paste("Histogram of", input$Yanimal),
               xlab = input$Yanimal)
        }
      })
    output$worldBars =
      renderPlot({
        if(input$loghist1 == TRUE)
        {
          hist(log(worlddata[,input$Xworld]),
               main = paste("Histogram of Log:", input$Xworld, sep = ''),
               xlab = paste("Log:", input$Xworld))
        }
        else{
          hist(worlddata[,input$Xworld],
               main = paste("Histogram of", input$Xworld),
               xlab = input$Xworld)
        }
      })
    output$worldBars2 =
      renderPlot({
        if(input$loghist2 == TRUE)
        {
          hist(log(worlddata[,input$Yworld]), 
               main = paste("Histogram of Log:", input$Yworld, sep = ''),
               xlab = paste("Log:", input$Yworld))
        }
        else{
          hist(worlddata[,input$Yworld],
               main = paste("Histogram of", input$Yworld),
               xlab = input$Yworld)
        }
      })
  })
  
  
  
  
  # output$summary = renderPrint({
  #   input$transforms
  # })
  # 
  
  output$EmptyPlot =
    renderPlot({
      plot(x = c(-1,1),y = c(-1,1), type = "n")
    })
})
