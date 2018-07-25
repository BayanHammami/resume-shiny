projects <- tabPanel("Projects",
                     sidebarLayout(sidebarPanel(
                       sliderInput(
                         "bins",
                         "Year:",
                         min = 0,
                         max = 100,
                         value = 10
                       )
                     ),
                     mainPanel(p('Hello'))))
