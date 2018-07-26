home <- tabPanel("Home",
                    sidebarLayout(sidebarPanel(
                      p(
                        "Hi there, my name is Bayan Hammami 
                        and I'm a data scientist who loves data. 
                        This is my interactive data-driven resume. 
                        I hope you enjoy it!"
                      ),
                      p(
                        "This site was built with R and the following packages; 
                        shiny, ggplot2, ggnet, network, wordcloud, fmsb, dplyr, tm and a few more."
                      ),
                      p(
                        "The code for this app can be found here:", tags$b(tags$a(href ="https://github.com/BayanHammami/resume-shiny", "https://github.com/BayanHammami/resume-shiny"))
                      ),
                      p(
                        "Please contact me on:", tags$b("bayan.hammami@gmail.com")
                      ),
                      hr(),
                      sliderInput(
                        "min_word_freq",
                        "Minimum word frequency in my text resume",
                        min = 1,
                        max = 5,
                        value = 2
                      ),
                      actionButton("home_regenerate", "Regenerate Wordcloud"),
                      hr(),
                      span(
                        style="margin:8px;",
                        a(href="https://github.com/BayanHammami",
                          target="_blank",
                          icon("github", class = "fa-2x", lib = "font-awesome")
                        )
                      ),
                      span(
                        style="margin:8px;",
                        a(href="https://www.linkedin.com/in/bayan-hammami",
                          target="_blank",
                          icon("linkedin", class = "fa-2x", lib = "font-awesome")
                        )
                      ),
                      span(
                        style="margin:8px;",
                        a(href="https://twitter.com/bayan_aus",
                          target="_blank",
                          icon("twitter", class = "fa-2x", lib = "font-awesome")
                        )
                      )                      
                    ),
                    mainPanel(
                      plotOutput("home_plot", height = "600px"),
                      style="text-align: center;"
                      
                    ))
)


