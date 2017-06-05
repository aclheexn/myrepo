#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
# Use DT::renderDataFrame

library(shiny)
# Try UIoutput with renderUI
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
  
  
  # output$dataResult = renderTable({
  #   values$df
  # })
  # All saves
  observeEvent(input$res2, {
    output$dataResult = renderTable({
      loadData()
    })
  })
  
  observeEvent(input$res, {
    output$dataResult = renderTable({
      loadData2()
    })
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
    files <- list.files(paste(outputDir,'/', input$code2, sep = ''), full.names = TRUE)
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
    data = data[nrow(data),]
  }
  
  # Saving the answers in the all file as well as the input code file
  observeEvent(input$submit, {
    #if(input$save == 0)
    #{
    # dir.create(path = paste('responses/',input$code, sep = ''))
    #}
    updated = update3()
    values$df = rbind(values$df, updated)
    
    saveData(values$df)
    saveData2(values$df)
  })
  
  # Saving the questions into the input code file
  observeEvent(input$submit1, {
    questions = update()
    values$df2 = rbind(values$df2, questions)
    dir.create(path = paste('responses/',input$code1, sep = ''))
    saveQuestions(values$df2)
    
  })
  
  #Getting the True False things for which questions selected
  observeEvent(input$get, {#It's screwed up when you put in a class code that has already been used
    output$dataTable = renderTable({
      data <- loadData3()
    })
    output$questionaire = renderUI({
      #if(data$gender[1] != FALSE){
        radioButtons("Ogender","Gender:",choices = c("Male"='male',"Female"='female',"Rather Not Say"='NA'),inline = TRUE)
      #}
      # if(data[2] != 'FALSE'){
      #   radioButtons("ethA","Ethnicity:",choices = c("White"='white',"Hispanic or Latino"='hl',"Native American"='native',"Asian/Pacific Islander"='asian',"Other"='other'),inline = TRUE)
      # }
      # radioButtons("age1A","Age:", choices = c("<18" = 'teenager',"18-25" = 'young', "25-45" = 'middle', "45-65" = 'old', ">65" = 'elder'),inline = TRUE)
      # if(data[3,1] != 'FALSE'){
      #   radioButtons("age1A","Age:", choices = c("<18" = 'teenager',"18-25" = 'young', "25-45" = 'middle', "45-65" = 'old', ">65" = 'elder'),inline = TRUE)
      # }
    })
    output$questionaire2 = renderUI({
      #if(data$ethnicity[1] != FALSE){
      radioButtons("OethA","Ethnicity:",choices = c("White"='white',"Hispanic or Latino"='hl',"Native American"='native',"Asian/Pacific Islander"='asian',"Other"='other'),inline = TRUE)
      #}
            })
    output$questionaire3 = renderUI({
      radioButtons("Oage1A","Age:", choices = c("<18" = 'teenager',"18-25" = 'young', "25-45" = 'middle', "45-65" = 'old', ">65" = 'elder'),inline = TRUE)
    })
    output$questionaire4 = renderUI({
      sliderInput("Oage2A","Age:",min = 10, value = 21, max = 80)
    })
    output$questionaire5 = renderUI({
      radioButtons("OmajorA","Major:",choices = c("Science"='sc',"Engineer"='engineer',"Art"='art',"Education"='edu',"Business"='busi'),inline = TRUE)
    })
    output$questionaire6 = renderUI({
      sliderInput("OsemesterA","Semester:",min = 1, value = 5,max = 10)
    })
    output$questionaire7 = renderUI({
      radioButtons("Op1A","Overall, I am satisfied with the City's efforts to create more jobs.",
                                                                                       choices = c("Strongly Disagree"='StrD',"Moderately Disagree"='MD',"Slightly Disagree"='SliD',
                                                                                                   "Slightly Agree"='SliA',"Moderately Agree"='MA',"Strongly Agree"='StrA'),inline = TRUE)
    })
    
    output$questionaire8 = renderUI({
      radioButtons("Oe1A","How many hours do you spend on study per week?",
                   choices = c("<20hrs"="aEd1","20-40hrs"="bEd1","40-60hrs"="cEd1"),inline = TRUE)
    })
    
    output$questionaire9 = renderUI({
      radioButtons("Oe2A","What is your SAT score?",choices = c("<1000"="aEd2","1000-1500"="bEd2","1500-2000"="cEd2","2000-2400"="dEd2"),inline = TRUE)
    })
    
    output$questionaire10 = renderUI({
      sliderInput("Oh1A","Height(cm):",min = 140,value = 158,max = 200)
    })
    output$questionaire11 = renderUI({
      sliderInput("Oh2A","Weight(kg):",min = 40,value = 44,max = 150)
    })
    output$questionaire12 = renderUI({
      radioButtons("Osmoke","How often do you smoke?", choices = c("Never"='aSM',"<1 time per day"='bSM',"1-5 times per day"='cSM',"5-10 times per day"='dSM',">10 times per day"='eSM'),inline = TRUE)
    })
    output$questionaire13 = renderUI({
      radioButtons("Osleep","How many hours do you sleep per day?",
                    choices = c("<6hrs"='aSL',"6-8hrs"='bSL',"9-10hrs"='cSL',">10hrs"='dSL'),inline = TRUE)
    })
  })
  
  update3 = reactive({
    value = data.frame("gender" = input$Ogender,
                       "ethnicity" = input$OethA,
                       "ageQual" = input$Oage1A,
                       "ageQuan" = input$Oage2A,
                       "major" = input$OmajorA,
                       "semester" = input$OsemesterA,
                       "Politics1" = input$Op1A,
                       "Education1" = input$Oe1A,
                       "Education2" = input$Oe2A,
                       "Health1" = input$Oh1A,
                       "Health2" = input$Oh2A,
                       "Health3" = input$Osmoke,
                       "Health4" = input$Osleep)
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
