#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Students Marks"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            selectInput("graph","select garph",c("hist","Box","Scatter","goem_points","facet_wrap","facet_grid"),selected = "hist")
        ),
        
        
        # Show a plot of the generated distribution
        mainPanel(
            # plotOutput("distPlot"),
            plotOutput("dis")
        )
    )
)




# Define server logic required to draw a histogram
server <- function(input, output) {
    
    marks <- data.frame(class=c("BDA","CBA","MA","MA","CBA","BDA","BDA","CBA"),
                        name=c("dhruv","shashwat","hiren","harsh","meet","vedant","divij","akshay"),
                        score=c(80,77,63,41,56,24,15,38),
                        grade=c("B+","B","B","C","C+","E+","E","D+")
                        )
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        
        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
       
         
        
    })
    
    require(ggplot2)
    output$dis<-renderPlot({
        
        if(input$graph=="hist")
        {
           return ( ggplot(data = marks)+geom_histogram(aes(x=score)))
            
        }
        if(input$graph=="Box")
        {
            return(ggplot(marks,aes(y=score,x=class))+geom_boxplot())
            
        }
        if(input$graph=="Scatter"){
            plot(grade~class,data=marks)  
        }
            if(input$graph=="goem_points"){
                d <- ggplot(marks,aes(x=score,y=class))
                return (d+geom_point(aes(color=grade)))
            }
        if(input$graph=="facet_wrap"){
            d <- ggplot(marks,aes(x=score,y=class))
            return(d+geom_point(aes(color=grade))+facet_wrap(score ~ grade))
        }
        if(input$graph=="facet_grid"){
            d <- ggplot(diamonds,aes(x=score,y=class))
            return (d+geom_point(aes(color=grade))+facet_grid(grade~score))
        }
    })
}

# Run the application 
shinyApp(ui = ui, server = server)