
library(shiny)
library(shinydashboard)

ui <- shinyUI(
    
    dashboardPage( title = "Practical DashBoard", skin = "green",
                   
                    dashboardHeader(title = "RP practicals"),
                   
                    dashboardSidebar(
                       br(),
                       sidebarMenu(
                           
                           menuSubItem("Hypothesis Testing",tabName = "hypotest")
                           #menuSubItem("Anova Test",tabName = "anovatest")
                    
                       )),
                   
                   dashboardBody(
                       # tabitems is for making a page for each menuitems
                       tabItems(
                           tabItem(tabName = "hypotest",  
                                   h1("PRACTICAL 5"),
                                   h3("Hypothesis Testing"),
                                   br(),
                                   selectInput("test_type",
                                               "Select Type",
                                               c("One Sided Z-test" = "1sidedztest","Two Sided Z-test" = "2sidedztest","Paired T-test" = "pairedttest"
                                               )),
                                   
                                   fileInput("file1","Choose CSV file",
                                             multiple = FALSE,
                                             accept = c("text/csv",
                                                        "text/comma-seperated-values,text/plain"
                                                        ,".csv")
                                   ),
                                   tableOutput("tableOut"),
                                   verbatimTextOutput("textOut")
                                   
                             
                           ) 
                           
                                                 
                     
                       )
                    
                   )
    )
    
)
# Define server logic required to draw a histogram
server <- function(input, output) {
  
    df <- reactive(read.csv(input$file1$datapath))
    output$textOut <- renderPrint({
        x <- df()$Strength
        y <- df()$Data
        if(input$test_type == "2sidedztest")
          t.test(x,y,paired =F)
            # prop.test(x = 95, n = 160, p = 0.5, 
            #           correct = FALSE)
        else if(input$test_type == "1sidedztest")
            prop.test(x = c(490, 400), n = c(500, 500))
        # else if(input$test_type == "One Sample T-test")
        #     t.test(x)
        else if(input$test_type == "pairedttest")
            t.test(x,y,paired = TRUE)
      
    })
    output$tableOut <- renderTable({
        df()
    })
    
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
