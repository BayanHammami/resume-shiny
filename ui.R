library(shinythemes)
output <-
  lapply(paste0(
    "./ui-components/",
    list.files("./ui-components", recursive = T)
  ), source)

ui <- navbarPage(
  "Bayan Hammami",
  theme = shinytheme("paper"),
  home,
  experience,
  skills,
  education,
  # contact,
  #Theres a bug in the shiny code: https://stackoverflow.com/questions/40808889/a-dynamically-resizing-shiny-textareainput-box
  #This is a hack until they fix it
  tags$style(
    HTML(
      ".shiny-input-container:not(.shiny-input-container-inline) {width: 100%;}"
    )
  )
)
