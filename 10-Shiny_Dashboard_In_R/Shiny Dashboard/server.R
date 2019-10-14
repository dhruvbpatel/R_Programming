#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/ 
#
library(plotly)
library(shiny)
library(shinydashboard)

library(reshape2)



# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$histogram <-  renderPlot({
            hist(faithful$eruptions)
        }) 
    
    output$approvedBox <-  renderInfoBox({
        
        infoBox("Approval Sales","12444",icon=icon("bar-chart"),color = "yellow")
        
    })
    
    output$plot <- renderPlotly({
        plot_ly(mtcars, x = ~mpg, y = ~wt)
    })
    
    output$event <- renderPrint({
        d <- event_data("plotly_hover")
        if (is.null(d)) "Hover on a point!" else d
    })
        

    output$msgOutput <- renderMenu({
        msgs <-  apply()

    })
    
    readf <- reactive(read.csv(input$file1$datapath))
    
    output$dhruv <- renderPrint({
        
        str(readf())    # prinitng structure readf()
        print(readf()$Id)
        
    })
    
    
    

    output$anovaOutput <- renderPrint({
        readAnova <- reactive(read.csv(input$fileAnova$datapath))
        str(readAnova())    # prinitng structure readf()
        bartlett.test(readAnova())

    })
    
    require(ggplot2)
    
    output$histogram1 <- renderPlot({
        readAnova <- reactive(read.csv("anova.csc"))
        hist(x,data=readAnova())
        plot(x~y,data = readAnova())
    })
    
    
    
})
