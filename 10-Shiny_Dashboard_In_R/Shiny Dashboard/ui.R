library(shinydashboard)
  library(shiny)
require(ggplot2)
library(plotly)



shinyUI(
  
  dashboardPage( title = "Finance DashBoard", skin = "green",
    
    dashboardHeader(title = "Finance Dashboard",
        
            dropdownMenu(type = "message",
                         messageItem(from = "Finance Update",message = "we are on threshold"),
                         messageItem(from="Sales Update",message = "Sales are at 50%",icon=icon("bar-chart"),time="22:00"),
                         messageItem(from="Sales Update",message = "sales meeting at 15:00 monday",time="15:00",icon = icon("handshake-o"))
                        ),
            dropdownMenu(type="notifications",
                         notificationItem(
                           text="2 new tabs added to the dashboard",
                           icon = icon("dashboard"),
                           status="success"
                         ),
                         notificationItem(text="server is currently running at 95% load",
                                          icon = icon("warning"),
                                          status = "warning"
                                          )  
                         ),
            
            dropdownMenu(type="tasks",
                         taskItem(
                         value=80,
                         color = "red",
                         "Dashboard Tasks "
                         ),
                         
                         taskItem(
                           value = 60,
                           color = "blue",
                           "Health Status"
                         )
                         
                         )
            
                      ),

    dashboardSidebar(
      br(),
      sidebarMenu(
      sidebarSearchForm("Search text","buttonSearch","Search"),
      menuItem("Dashboard",tabName = "dashboard",icon = icon("dashboard")),   # add tabname of respective tab
        menuSubItem("Dashboard Finanace",tabName = "finance"),
        menuSubItem("dashboard Sales",tabName = "sales"),
      menuItem("Analysis",badgeLabel = "new",badgeColor = "green"),
      menuItem("Practicals",badgeLabel = "new",badgeColor = "yellow",icon=icon("file-word"),tabName = "pracs"),
              menuSubItem("Anova-Test",tabName = "anova-test"),
      menuItem("Raw Data",tabName = "finance")
      
        
    )),
    dashboardBody(
      # tabitems is for making a page for each menuitems
      tabItems(
        tabItem(tabName = "dashboard",  
                fluidRow(
                  infoBox("Sales Count",124+44,icon=icon("thumbs-up"),color = "green"),
                  infoBox("Conversions %",paste0('20%'),icon=icon("envelope"),color="blue")
                  ,infoBoxOutput("approvedBox")
                  
                ),
                
                fluidRow(
                  valueBox(15*200,"Bugdet for 10 days",icon=icon("wallet"),color = "red")
                )
                ,
                
                fluidRow(
                box( title="Histogram of Faithful",
                          status ="primary",solidHeader=T, box(plotOutput("histogram"),width = "400")
                ),
                box(title = "Control for Header",status="info",solidHeader = T,
                    "Use this controls to fine tune dashboard",
                    sliderInput("bins","Number of Breaks",1,100,50),
                    textInput("text_input","search oppurtunities",value = "1234")
                    )
                 
                )
      ), 
      tabItem(
        tabName = "finance",h1("Finance Dashboard"),
        plotlyOutput("plot"),
        verbatimTextOutput("event")

      ),
      
      tabItem( 
        tabName = "pracs",h1("Practicals "),
        verbatimTextOutput("dhruv"),
        fileInput("file1","Choose CSV file",
                  multiple = FALSE,
                  accept = c("text/csv",
                             "text/comma-seperated-values,text/plain"
                             ,".csv")
        )
        
        #TukeyHSD("result of anova")
        
      ),
      
      tabItem(
        tabName = "anova-test",h2("ANOVA Test"),
        
        verbatimTextOutput("anovaOutput"),
        fileInput("file-anova","Choose CSV file",
                  multiple = FALSE,
                  accept = c("text/csv","text/comma-seperated-values,text/plain",".csv")
        )
        
        
      )
    
      
     
      
    
      )
      
      
    )
  )
  
  
)
