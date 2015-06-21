library(shiny)


shinyUI(pageWithSidebar(
        headerPanel("Titanic survival probability prediction"),
        sidebarPanel(
                radioButtons("sex", "Gender:",
                             list("Male" = "male",
                                  "Female" = "female")),
                
                radioButtons("pclass", "Passenger class:",
                             list("1st" = "1st",
                                  "2nd" = "2nd",
                                  "3rd" = "3rd")),
                br(),
                sliderInput('age', 'Age:',value = 25, min = 1, max = 80, step = 1),
                sliderInput('ticket_price', 'Ticket price:',value = 100, min = 0, 
                            max = 514, step = 10,)
        ),
        mainPanel(   
                tabsetPanel(  
                        tabPanel("Output",
                h4("Your data:"),
                tableOutput("yourData"),
                h4("Prediction:"),
                tableOutput("predicted")
                        ),
                tabPanel("Documentation",textOutput("text")
                )
        )

#                 
        
)))






