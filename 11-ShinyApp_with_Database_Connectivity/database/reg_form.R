#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(RMySQL)
library(shinyjs)
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Registrtion Form"),

        # Show a plot of the generated distribution
        mainPanel(
            numericInput("Id","Id",""),
            textInput("Name","Name",""),
            actionButton("Submit","Submit"),
            verbatimTextOutput("insert"),
            verbatimTextOutput("data")
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    d <- eventReactive(input$Submit,{
        con <- dbConnect(RMySQL::MySQL(), user="root", password="", server="localhost", dbname="test")
        id <- input$Id
        name <- input$Name
        query <- sprintf("INSERT INTO student_master(Id,Name) values(\'%s\',\'%s\')",id,name)
        DBI::dbSendQuery(con, query)
        DBI::dbDisconnect(con)
    })
    
    output$insert <- renderPrint({
        d()
    })
    
    dd <- eventReactive(input$Submit,{
        con <- dbConnect(RMySQL::MySQL(), user="root", password="", server="localhost", dbname="test")
        query <- sprintf("SELECT * from student_master")
        tabledata <- dbSendQuery(con, query)
        FinalData <- dbFetch(tabledata)
        print(FinalData)
        DBI::dbDisconnect(con)
    })
    
    output$data <- renderPrint({
        dd()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
