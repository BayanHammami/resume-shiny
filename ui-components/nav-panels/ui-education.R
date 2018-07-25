education <- tabPanel("Education",
                      sidebarLayout(
                        sidebarPanel(
                          
                          selectInput(
                            "education_plot_type",
                            label = "Section",
                            choices = list(
                              "Distribution of Grades",
                              "Word Cloud of Course Names",
                              "Units By Subject Area"
                            )
                          ), 
                          conditionalPanel(
                            condition = "input.education_plot_type == 'Distribution of Grades'",
                            radioButtons(
                              "education_grades_radio",
                              label = "Plot Type",
                              choices = list(
                                "Density",
                                "Histogram"
                              )
                            )
                          ),                          
                          radioButtons(
                            "education_radio",
                            label = "Education",
                            choices = list(
                              "UNSW - Both Degrees" = 1,
                              "UNSW - Bachelor of Engineering (Civil)" = 2,
                              "UNSW - Bachelor of Commerce (Finance)" = 3
                            ),
                            selected = 1
                          ),
                          hr(),
                          h6(
                            "I studied a double degree of Engineering & Commerce
                             at the University of New South Wales from 2008 to 2013."
                          ),
                          tags$ul(
                            tags$li("Honours Thesis: \"‘Real Options: A Framework for the Application of the Probabilistic Present Worth Method’\""), 
                            tags$li("Dean's List"), 
                            tags$li("Distinction average for Commerce and Engineering"),
                            tags$li("High Distinction for Honours Thesis")
                          ),
                          hr()
                        ),
                        mainPanel(
                          h5(textOutput("education_plot_title"), align = 'center'),
                          plotOutput("education_plot", height = "600px")
                        )
                      )
)