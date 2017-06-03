library(shiny)
library(ggplot2)

# Add in plot interaction with ggplot
# Include better boxplot -- Done
# Other things other than normal data -- Can do once students can draw their own curves

shinyServer(function(input, output) {
  
  gen_data = reactive({
    value = c(input$n, 
              input$mu1, 
              input$mu2, 
              input$mu3,
              input$sigma
    )
  })
  
  #Creates the BoxPlot *Need to make a ggplot of this to make more interactive*
  output$aovPlot = renderPlot({
    value = gen_data()
    df = data.frame(y = c(rnorm(value[1], value[2], value[5]), 
                          rnorm(value[1], value[3], value[5]), 
                          rnorm(value[1], value[4], value[5])),
                    group = rep(sprintf('mu%s', 1:3), each = value[1]))
    ggplot(data = df, aes(x = df$group, y = df$y)) + 
      geom_boxplot(data = df, aes(x = df$group, y = df$y)) + 
      geom_point(data = df, aes(x = df$group, y = df$y)) +
      xlab("Group of Means") + ylab("Values")
  })
  
  #Summary of the data
  output$aovSummary = renderPrint({
    value = gen_data()
    df = data.frame(y = c(rnorm(value[1], value[2], value[5]), 
                          rnorm(value[1], value[3], value[5]), 
                          rnorm(value[1], value[4], value[5])),
                    group = rep(sprintf('mu%s', 1:3), each = value[1]))
    
    summary(aov(df$y ~ df$group))
  })
  
  #Displays the F Crit Value
  output$Fcrit = renderPrint({
    value = gen_data()
    df = data.frame(y = c(rnorm(value[1], value[2], value[5]), 
                          rnorm(value[1], value[3], value[5]), 
                          rnorm(value[1], value[4], value[5])),
                    group = rep(sprintf('mu%s', 1:3), each = value[1]))
    
    dfsum = summary(aov(df$y ~ df$group))
    qf(0.95, df1 = dfsum[[1]]$Df[1], dfsum[[1]]$Df[2])
  })
  # output$Fdist = renderPlot({
  #   value = gen_data()
  #   df = data.frame(y = c(rnorm(value[1], value[2], value[5]), 
  #                         rnorm(value[1], value[3], value[5]), 
  #                         rnorm(value[1], value[4], value[5])),
  #                   group = rep(sprintf('mu%s', 1:3), each = value[1]))
  #   dfsum = summary(aov(df$y ~ df$group))
  #   df1 = dfsum[[1]]$Df[1]
  #   df2 = dfsum[[1]]$Df[2]
  #   curve(df(x, df1 = df1, df2 = df2), from = 0, to = 100, xLab = "F-statistic
  #         ")# Add in ability to repeat same sample. P-value distribution changes
  # })
  
  #Makes number of simulations into a reactive variable
  counter = reactive(input$sim)
  #Creates the P-value plot through the number of simulations
  output$pvalueplot = renderPlot({
    simulations = counter()
    vector = c()
    value = gen_data()
    for(i in 1:simulations){
      # for(i in 0:input$sim){
      df = data.frame(y = c(rnorm(value[1], value[2], value[5]), 
                            rnorm(value[1], value[3], value[5]), 
                            rnorm(value[1], value[4], value[5])),
                      group = rep(sprintf('mu%s', 1:3), each = value[1]))
      
      dfsum = summary(aov(df$y ~ df$group))
      pvalue = dfsum[[1]]$`Pr(>F)`[1]
      vector = c(vector, pvalue)
    }
    hist(vector, main = paste("P-Value Distribution for", input$sim, "Simulations"), 
         xlab = "P-value")
    
  })# Different types(not just normal) of populations
  # Boxplot from ggplot
  # Be able to select points and see where they are on the box plot
  
  
})