#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
# Use DT::renderDataFrame

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  # update = reactive({
  #   value = data.frame("CodeNum" = input$code,
  #                      "Name" = input$text, 
  #                      "Age" = input$age,
  #                      "Major" = input$major,
  #                      "Gender" = input$gender,
  #                      "SAT" = input$score,
  #                      "Internet" = input$hours, 
  #                      "Height" = input$height)
  #   # had c(input$bins, input$text) 
  #   # Adding a df to a character vector doesn't work
  # })
  
  values = reactiveValues()
  values$df = data.frame()
  
  
  outputDir = "responses"
  
  update = reactive({
    value = data.frame("gender" = input$gender,
                       "ethnicity" = input$eth,
                       "ageQual" = input$age2,
                       "ageQuan" = input$age1,
                       "major" = input$major,
                       "semester" = input$semester,
                       "Politics1" = input$p1,
                       "Education1" = input$e1,
                       "Education2" = input$e2,
                       "Health1" = input$h1,
                       "Health2" = input$h2,
                       "Health3" = input$h3,
                       "Health4" = input$h4)
  })
  
  update2 = reactive({
    value = data.frame("gender" = input$genderA,
                       "ethnicity" = input$ethA,
                       "ageQual" = input$age1A,
                       "ageQuan" = input$age2A,
                       "major" = input$majorA,
                       "semester" = input$semesterA,
                       "Politics1" = input$p1A,
                       "Education1" = input$e1,
                       "Education2" = input$e2,
                       "Health1" = input$h1A,
                       "Health2" = input$h2A,
                       "Health3" = input$smoke,
                       "Health4" = input$sleep)
  })
  
  values = reactiveValues()
  values$df = data.frame()
  values$df2 = data.frame()
  
  
  # observeEvent(input$submit, {
  #   updated = update2()
  #   values$df = rbind(values$df, updated)
  # })
  
  
  output$dataResult = renderTable({
    values$df
    
  })
  
  saveQuestions <- function(data) {
    # data <- t(data)
    # Create a unique file name
    fileName <- 'Questions'
    # Write the file to the local system
    write.csv(
      x = data,
      file = file.path(paste(outputDir, "/", input$code1, sep = ''), fileName), 
      row.names = FALSE, quote = TRUE
    )
  }
  
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
  
  saveData2 <- function(data) {
    #data <- t(data)
    # Create a unique file name
    fileName <- sprintf(paste(input$code, "%s_%s.csv"), as.integer(Sys.time()), digest::digest(data))
    # Write the file to the local system
    write.csv(
      x = data,
      file = file.path(paste(outputDir, "/all", sep = ''), fileName), 
      row.names = FALSE, quote = TRUE
    )
  }
  
  loadData <- function() {
    # Read all the files into a list
    files <- list.files(paste(outputDir, '/all', sep = ''), full.names = TRUE)
    data <- lapply(files, read.csv, stringsAsFactors = FALSE) 
    # Concatenate all data together into one data.frame
    data <- do.call(rbind, data)
    data
  }
  
  loadData2 <- function() { #Need to make it so that it only captures ones with the input$code
    # Read all the files into a list
    files <- list.files(paste(outputDir,'/', input$code, sep = ''), full.names = TRUE)
    data <- lapply(files, read.csv, stringsAsFactors = FALSE) 
    # Concatenate all data together into one data.frame
    data <- do.call(rbind, data)
    data
  }
  
  loadData3 <- function() { #Need to make it so that it only captures ones with the input$code
    # Read all the files into a list
    files <- list.files(paste(outputDir,'/', input$code, sep = ''), full.names = TRUE)
    data <- lapply(files, read.csv, stringsAsFactors = FALSE) 
    # Concatenate all data together into one data.frame
    data <- do.call(rbind, data)
    data
  }
  
  observeEvent(input$submit, {
    #if(input$save == 0)
    #{
    # dir.create(path = paste('responses/',input$code, sep = ''))
    #}
    updated = update2()
    values$df = rbind(values$df, updated)
    
    saveData(values$df)
    saveData2(values$df)
  })
  
  observeEvent(input$submit1, {
    questions = update()
    values$df2 = rbind(values$df2, questions)
    dir.create(path = paste('responses/',input$code1, sep = ''))
    saveQuestions(values$df2)
    
  })
  
  observeEvent(input$get, {#It's screwed up when you put in a class code that has already been used
    output$dataTable = renderTable({
      data <<- loadData3()
    })
  })
  
  output$downloadData = downloadHandler(
    filename = function(){
      paste('data-', Sys.Date(), '.csv', sep = '')
    },
    content = function(con){
      write.csv(loadData(), con)
    }
  )
  
})
