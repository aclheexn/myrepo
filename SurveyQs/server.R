#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Put Into Console
##############################################################
outputDir <- "responses"

saveData <- function(data) {
  #data <- t(data)
  # Create a unique file name
  fileName <- sprintf("%s_%s.csv", as.integer(Sys.time()), digest::digest(data))
  # Write the file to the local system
  write.csv(
    x = data,
    file = file.path(outputDir, fileName), 
    row.names = FALSE, quote = TRUE
  )
}

loadData <- function() {
  # Read all the files into a list
  files <- list.files(outputDir, full.names = TRUE)
  data <- lapply(files, read.csv, stringsAsFactors = FALSE) 
  # Concatenate all data together into one data.frame
  data <- do.call(rbind, data)
  data
}
###############################################################
# Can use loadData() as an argument in Shiny Server
# ^ That's the next step


shinyServer(function(input, output) {
  # First Try to add to and Create Reactive Data Frame
  # react = reactive({
  #   # updated = update()
  #   df = rbind(df, c(input$bins, input$text))
  # })
  
  #Creates reactive values for inputs
  
  update = reactive({
    value = data.frame("Name" = input$text, 
                       "SAT Score" = input$score,
                       "Internet Hours" = input$hours, 
                       "Height in Inches" = input$height)
    # had c(input$bins, input$text) 
    # Adding a df to a character vector doesn't work
  })
  
  #Creates a reactive data frame
  values = reactiveValues()
  values$df = data.frame()
  
  #Second Try to add to data frame
  # newEntry = observe({
  #   if(input$update > 0){
  #     newLine = isolate(c(input$bins, input$text))
  #     values$df = rbind(values$df, newLine)
  #   }
  # })
  
  #Adds to Dataframe through update button
  observeEvent(input$update, {
    updated = update()
    values$df = rbind(values$df, updated)
  })
  
  #Shows updated data table
  output$table = renderPrint({
    values$df
    
  })
  
  #Saves table to a csv file on folder
  observeEvent(input$save, {
    saveData(values$df)
  })
  
  #Creation of Text function so it appears when u click button
  text = eventReactive(input$update, {
    "Updated!"
  })
  
  #Outputs Updated Text
  output$updated = renderText({
    paste(text(), input$update)
  })
  
  #Clears data table
  observeEvent(input$clear, {
    output$table = renderPrint({
      values$df
    })
    values$df = data.frame()
  })
  
  
  
  
})
