library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Class Survey"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Survey Question Gallery", tabName = "build", icon = icon("list"),
               menuSubItem("Personal Information",tabName = "person",icon = icon("user-circle-o")),
               menuSubItem("Politics", tabName = "politics",icon = icon("flag")),
               menuSubItem("Education", tabName = "education", icon = icon("university")),
               menuSubItem("Health", tabName = "health", icon = icon("heartbeat")),
               menuSubItem("Customer Satisfaction", tabName = "satisfaction", icon = icon("smile-o"))
      ), 
      menuItem("Generate Your Questionaire",tabName = "questionaire",icon = icon("window-restore")),
      menuItem("Take A Survey", tabName = "survey", icon = icon("file-text")),
      menuItem("Survey Data", tabName = "result",icon = icon("bar-chart"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "person",
              
              sidebarLayout(
                sidebarPanel(
                  
                  checkboxInput("gender", "Gender"),
                  checkboxInput("eth", "Ethnicity"),
                  checkboxInput("age1", "Age(qualitative)"),
                  checkboxInput("age2", "Age(quantitative)"),
                  checkboxInput("major", "Major"),
                  checkboxInput("semester", "Semester")
                  
                ),
                
                mainPanel(
                  
                  conditionalPanel("input.gender == 1",
                                   radioButtons("genderA","Gender:",choices = c("Male"='male',"Female"='female',"Rather Not Say"='NA'),inline = TRUE)
                  ),
                  conditionalPanel("input.eth == 1",
                                   radioButtons("ethA","Ethnicity:",choices = c("White"='white',"Hispanic or Latino"='hl',"Native American"='native',"Asian/Pacific Islander"='asian',"Other"='other'),inline = TRUE)
                  ),
                  conditionalPanel("input.age1 == 1",
                                   radioButtons("age1A","Age:", choices = c("<18" = 'teenager',"18-25" = 'young', "25-45" = 'middle', "45-65" = 'old', ">65" = 'elder'),inline = TRUE)
                  ),
                  conditionalPanel("input.age2 == 1",
                                   sliderInput("age2A","Age:",min = 10, value = 21, max = 80)
                  ),
                  conditionalPanel("input.major == 1",
                                   radioButtons("majorA","Major:",choices = c("Science"='sc',"Engineer"='engineer',"Art"='art',"Education"='edu',"Business"='busi'),inline = TRUE)
                  ),
                  conditionalPanel("input.semester == 1",
                                   sliderInput("semesterA","Semester:",min = 1, value = 5,max = 10))
                  
                  
                )
              )
              
      ),
      
      tabItem(tabName = "politics",
              fluidPage(
                fluidRow(
                  column(1,checkboxInput("p1","1.")),
                  column(11,radioButtons("p1A","Overall, I am satisfied with the City's efforts to create more jobs.",
                                         choices = c("Strongly Disagree"='StrD',"Moderately Disagree"='MD',"Slightly Disagree"='SliD',
                                                     "Slightly Agree"='SliA',"Moderately Agree"='MA',"Strongly Agree"='StrA'),inline = TRUE))
                ))),
      
      tabItem(tabName = "education",
              fluidPage(
                fluidRow(
                  column(1,checkboxInput("e1","1."),br(),checkboxInput("e2","2.")),
                  column(11,radioButtons("e1A","How many hours do you spend on study per week?",
                                         choices = c("<20hrs"="aEd1","20-40hrs"="bEd1","40-60hrs"="cEd1"),inline = TRUE),
                         radioButtons("e2A","What is your SAT score?",choices = c("<1000"="aEd2","1000-1500"="bEd2","1500-2000"="cEd2","2000-2400"="dEd2"),inline = TRUE))
                  
                )
              )),
      
      tabItem(tabName = "health",
              fluidPage(
                fluidRow(
                  column(1,checkboxInput("h1","1."),br(),br(),br(),checkboxInput("h2","2."),br(),br(),checkboxInput("h3","3."),br(),checkboxInput("h4","4.")),
                  column(11,sliderInput("h1A","Height(cm):",min = 140,value = 158,max = 200),
                         sliderInput("h2A","Weight(kg):",min = 40,value = 44,max = 150),
                         radioButtons("smoke","How often do you smoke?",
                                      choices = c("Never"='aSM',"<1 time per day"='bSM',"1-5 times per day"='cSM',"5-10 times per day"='dSM',">10 times per day"='eSM'),inline = TRUE),
                         radioButtons("sleep","How many hours do you sleep per day?",
                                      choices = c("<6hrs"='aSL',"6-8hrs"='bSL',"9-10hrs"='cSL',">10hrs"='dSL'),inline = TRUE))
                )
              )),
      
      # Second tab content
      tabItem(tabName = "satisfaction",
              fluidPage(
                fluidRow()
              )),
      
      
      
      tabItem(tabName = "questionaire",
              column(3,offset = 5,actionButton("done","Generate Your Questionaire")),
              br(),
              hr(),
              fluidRow(
                column(1, "1.",br(),br(),br(),"2.",br(),br(),br(),"3."),
                column(11,
                       conditionalPanel("(input.done == 1)&(input.gender == 1)", radioButtons("genderA","Gender:",choices = c("Male"='male',"Female"='female',"Rather Not Say"='NA'),inline = TRUE)),
                       conditionalPanel("(input.done == 1)&(input.eth == 1)",  radioButtons("ethA","Ethnicity:",choices = c("White"='white',"Hispanic or Latino"='hl',"Native American"='native',"Asian/Pacific Islander"='asian',"Other"='other'),inline = TRUE)),
                       conditionalPanel("(input.done == 1)&(input.age1 == 1)", radioButtons("age1A","Age:", choices = c("<18" = 'teenager',"18-25" = 'young', "25-45" = 'middle', "45-65" = 'old', ">65" = 'elder'),inline = TRUE)),
                       conditionalPanel("(input.done == 1)&(input.age2 == 1)", sliderInput("age2A","Age:",min = 10, value = 21, max = 80)),
                       conditionalPanel("(input.done == 1)&(input.major == 1)",radioButtons("majorA","Major:",choices = c("Science"='sc',"Engineer"='engineer',"Art"='art',"Education"='edu',"Business"='busi'),inline = TRUE)), 
                       conditionalPanel("(input.done == 1)&(input.semester == 1)", sliderInput("semesterA","Semester:",min = 1, value = 5,max = 10)),
                       conditionalPanel("(input.done == 1)&(input.p1 == 1)", radioButtons("p1A","Overall, I am satisfied with the City's efforts to create more jobs.",
                                                                                          choices = c("Strongly Disagree"='StrD',"Moderately Disagree"='MD',"Slightly Disagree"='SliD',
                                                                                                      "Slightly Agree"='SliA',"Moderately Agree"='MA',"Strongly Agree"='StrA'),inline = TRUE)),
                       conditionalPanel("(input.done == 1)&(input.h1 == 1)", sliderInput("h1A","Height(cm):",min = 140,value = 158,max = 200)),
                       conditionalPanel("(input.done == 1)&(input.h2 == 1)", sliderInput("h2A","Weight(kg):",min = 40,value = 44,max = 150)),
                       conditionalPanel("(input.done == 1)&(input.h3 == 1)", radioButtons("smoke","How often do you smoke?",
                                                                                          choices = c("Never"='aSM',"<1 time per day"='bSM',"1-5 times per day"='cSM',"5-10 times per day"='dSM',">10 times per day"='eSM'),inline = TRUE)),
                       conditionalPanel("(input.done == 1)&(input.h4 == 1)", radioButtons("sleep","How many hours do you sleep per day?",
                                                                                          choices = c("<6hrs"='aSL',"6-8hrs"='bSL',"9-10hrs"='cSL',">10hrs"='dSL'),inline = TRUE))
          
                )
              ),
              fluidRow(column(4,offset = 8,
                              textInput("code1","Please enter a class code"),
                              actionButton("submit1","Submit")))
              
      ),
      
      tabItem(tabName = "survey",
              fluidPage(
                fluidRow(
                  column(3,textInput("code","Please enter the class code:")),
                  column(3,offset = 2,actionButton("get","Get the questionaire"))
                ),
                fluidRow(
                  tableOutput("dataTable")
                ),
                fluidRow(
                  # column(1, "1.",br(),br(),br(),"2.",br(),br(),br(),"3."),
                  # if(data[1,2] == TRUE){ # Isn't working.
                  #   radioButtons("genderA","Gender:",choices = c("Male"='male',"Female"='female',"Rather Not Say"='NA'),inline = TRUE)
                  # }
                  #column(11,
                         # conditionalPanel("condition = loadData3()", radioButtons("genderA","Gender:",choices = c("Male"='male',"Female"='female',"Rather Not Say"='NA'),inline = TRUE))
                         # conditionalPanel("(input.done == 1)&(input.eth == 1)",  radioButtons("ethA","Ethnicity:",choices = c("White"='white',"Hispanic or Latino"='hl',"Native American"='native',"Asian/Pacific Islander"='asian',"Other"='other'),inline = TRUE)),
                         # conditionalPanel("(input.done == 1)&(input.age1 == 1)", radioButtons("age1A","Age:", choices = c("<18" = 'teenager',"18-25" = 'young', "25-45" = 'middle', "45-65" = 'old', ">65" = 'elder'),inline = TRUE)),
                         # conditionalPanel("(input.done == 1)&(input.age2 == 1)", sliderInput("age2A","Age:",min = 10, value = 21, max = 80)),
                         # conditionalPanel("(input.done == 1)&(input.major == 1)",radioButtons("majorA","Major:",choices = c("Science"='sc',"Engineer"='engineer',"Art"='art',"Education"='edu',"Business"='busi'),inline = TRUE)), 
                         # conditionalPanel("(input.done == 1)&(input.semester == 1)", sliderInput("semesterA","Semester:",min = 1, value = 5,max = 10)),
                         # conditionalPanel("(input.done == 1)&(input.p1 == 1)", radioButtons("p1A","Overall, I am satisfied with the City's efforts to create more jobs.",
                         #                                                                    choices = c("Strongly Disagree"='StrD',"Moderately Disagree"='MD',"Slightly Disagree"='SliD',
                         #                                                                                "Slightly Agree"='SliA',"Moderately Agree"='MA',"Strongly Agree"='StrA'),inline = TRUE)),
                         # conditionalPanel("(input.done == 1)&(input.h1 == 1)", sliderInput("h1A","Height(cm):",min = 140,value = 158,max = 200)),
                         # conditionalPanel("(input.done == 1)&(input.h2 == 1)", sliderInput("h2A","Weight(kg):",min = 40,value = 44,max = 150)),
                         # conditionalPanel("(input.done == 1)&(input.h3 == 1)", radioButtons("smoke","How often do you smoke?",
                         #                                                                    choices = c("Never"='aSM',"<1 time per day"='bSM',"1-5 times per day"='cSM',"5-10 times per day"='dSM',">10 times per day"='eSM'),inline = TRUE)),
                         # conditionalPanel("(input.done == 1)&(input.h4 == 1)", radioButtons("sleep","How many hours do you sleep per day?",
                                                                                            # choices = c("<6hrs"='aSL',"6-8hrs"='bSL',"9-10hrs"='cSL',">10hrs"='dSL'),inline = TRUE))
                ),
                br(),
                br(),
                br(),
                hr(),
                hr(),
                fluidRow(
                  column(1,offset = 11,actionButton("submit","Submit"))
                )
              )),
      
      tabItem(tabName = "result",
              fluidPage(
                fluidRow(
                  column(3,textInput("code","Please enter the class code:")),
                  column(3,offset = 1,actionButton("res","Get class results")),
                  column(5,offset = 4, actionButton("res2", "Get all results"))
                ),
                fluidRow(
                  tableOutput("dataResult")
                ),
                br(),
                br(),
                br(),
                hr(),
                hr(),
                fluidRow(
                  column(1,offset = 11,actionButton("download","Download"))
                )
              ))
    )
  )
)