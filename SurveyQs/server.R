#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
# input a class code
# Get classes or everybody's data
# Collecting, saving, Download
# Number of responses per quesiton
# Question bank of 10 then giving options to add another question
# Age Gender Major <-- Important Qs

library(shiny)

# Put Into Console/I think you can put this under server file to take inputs from ui
##############################################################
# outputDir <- "responses"
# 
# saveData <- function(data) {
#   #data <- t(data)
#   # Create a unique file name
#   fileName <- sprintf(paste(input$code, "%s_%s.csv"), as.integer(Sys.time()), digest::digest(data))
#   # Write the file to the local system
#   write.csv(
#     x = data,
#     file = file.path(outputDir, fileName), 
#     row.names = FALSE, quote = TRUE
#   )
# }
# 
# loadData <- function() {
#   # Read all the files into a list
#   files <- list.files(outputDir, full.names = TRUE)
#   data <- lapply(files, read.csv, stringsAsFactors = FALSE) 
#   # Concatenate all data together into one data.frame
#   data <- do.call(rbind, data)
#   data
# }
###############################################################
# Can use loadData() as an argument in Shiny Server
# ^ That's the next step


shinyServer(function(input, output) {
  
  outputDir <- "responses"
  # 
  # observeEvent(input$folder, {
  #   dir.create(path = paste('responses/',input$code, sep = ''))
  # })
  # dir.create(path = paste('SurveyQs/responses/',input$code, sep = ''))
  
  saveData <- function(data) {
    #data <- t(data)
    # Create a unique file name
    fileName <- sprintf(paste(input$code, "%s_%s.csv"), as.integer(Sys.time()), digest::digest(data))
    # Write the file to the local system
    write.csv(
      x = data,
      file = file.path(paste(outputDir, "/", input$code, sep = ''), fileName), 
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
  
  loadData2 <- function() { #Need to make it so that it only captures ones with the input$code
    # Read all the files into a list
    files <- list.files(outputDir, full.names = TRUE)
    data <- lapply(files, read.csv, stringsAsFactors = FALSE) 
    # Concatenate all data together into one data.frame
    data <- do.call(rbind, data)
    data
  }
  
  # First Try to add to and Create Reactive Data Frame
  # react = reactive({
  #   # updated = update()
  #   df = rbind(df, c(input$bins, input$text))
  # })
  
  #Creates reactive values for inputs
  
  update = reactive({
    value = data.frame("Name" = input$text, 
                       "Age" = input$age,
                       "Major" = input$major,
                       "Gender" = input$gender,
                       "SAT" = input$score,
                       "Internet" = input$hours, 
                       "Height" = input$height)
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
    #if(input$save == 0)
    #{
      dir.create(path = paste('responses/',input$code, sep = ''))
    #}
    saveData(values$df)
  })
  
  #Creation of Text function so it appears when u click button
  text = eventReactive(input$update, {
    "Updated!"
  })
  
  #Outputs 'Updated' Text
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
  
  #Shows total Table with all saves
  observeEvent(input$show, {
    output$tote = renderTable({
      loadData()
    })
  })
  
  #Shows table with only select # of saves
  observeEvent(input$show2, {
    output$tote = renderTable({
    loadData2()
  })
  })
  
  #First try at a download button hoooooooooooly shheeeeeeeeeeet it works
  output$downloadData = downloadHandler(
    filename = function(){
      paste('data-', Sys.Date(), '.csv', sep = '')
    },
    content = function(con){
      write.csv(loadData(), con)
    }
  )
})
