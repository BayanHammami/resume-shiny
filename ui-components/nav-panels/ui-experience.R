experience <- tabPanel(
  "Experience",
  sidebarLayout(sidebarPanel(
    radioButtons(
      "experience_section",
      label = "Employment History",
      choiceNames = list(
        "Domain.com.au - Jan 16 to Present",
        "Servian - Oct 14 to Dec 15",
        "Uplift Education - Feb 08 to Oct 13",
        "ARRB Group - Nov 11 to Feb 12"
      ),
      choiceValues = list(
        "Domain",
        "Servian",
        "Uplift",
        "ARRB"
      )
    ),
    sliderInput(
      "min_con_freq",
      "Minimum number of times two skills/tools have been used together",
      min = 1,
      max = 3,
      value = 1
    ),
    actionButton("experience_regenerate", "Regenerate Network"),
    hr(),
    conditionalPanel(
      condition = "input.experience_section == 'Domain'",
      h6(tags$b("Domain.com.au"), "/Analytics Lead"),
      tags$ul(
        tags$li("Lead and mentored a small team"),
        tags$li("Developed ML models"), 
        tags$li("Performed time series forecasting & analysis"), 
        tags$li("Implemented experimental design for product optimisation"),
        tags$li("Built production ETL pipelines"),
        tags$li("Created reports & dashboards")
      )
    ),
    conditionalPanel(
      condition = "input.experience_section == 'Servian'",
      h6(tags$b("Servian"), "/Associate Consultant"),
      tags$ul(
        tags$li("Developed a geospatial analytics application"),
        tags$li("Implemented thompson sampling algorithm in experimental software"), 
        tags$li("Behaviourial analysis of clickstream data"), 
        tags$li("Experimental design of marketing campaigns"),
        tags$li("Development of predictive marketing models")
      )      
    ),
    conditionalPanel(
      condition = "input.experience_section == 'Uplift'",
      h6(tags$b("Uplift Education"), "/Co-Founder"),
      tags$ul(
        tags$li("Built a profitable small tutoring business"),
        tags$li("Lead & managed a small team of tutors"), 
        tags$li("Developed processes, software systems and educational resources for my students")
      )        
    ),
    conditionalPanel(
      condition = "input.experience_section == 'ARRB'",
      h6(tags$b("ARRB Group"), "/Junior Civil Engineer"),
      tags$ul(
        tags$li("Vehicle crash data analysis"),
        tags$li("Traffic forecasting and modelling"), 
        tags$li("Costing and capital works program planning for proposed road project"),
        tags$li("Built a risk model to assess safety features in school zones")
      )        
      
    )
  ),
  mainPanel(
    plotOutput("experience_plot", height = "600px")
  ))
)
