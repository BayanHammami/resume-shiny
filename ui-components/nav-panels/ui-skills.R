skills <- tabPanel("Skills",
                   sidebarLayout(sidebarPanel(
                     radioButtons(
                       "skills_plot_type",
                       label = "Radar Plot Type",
                       choices = list(
                         "Tools & Technologies",
                         "Skills"
                       ),
                       selected = "Tools & Technologies"
                     ),
                     hr(),
                     p("This is my self-reported proficiency level in skills, tools & technologies that
                       I have been using in my career.")
                   ),
                   mainPanel(
                     plotOutput("skills_plot", height = "600px")
                   )))
