contact <- tabPanel("Contact",
                      pageWithSidebar(
                        headerPanel(""),
                        sidebarPanel(
                          textInput("from", "From:", placeholder ="from@gmail.com"),
                          textInput("to", "To:", placeholder ="to@gmail.com"),
                          textInput("subject", "Subject:", placeholder = "Message subject"),
                          actionButton("send", "Send E-mail", width = "100%", icon = icon("envelope", class = NULL, lib = "font-awesome"))
                        ),
                        mainPanel(   
                          textAreaInput(
                            "message",
                            "Message:",
                            value = "",
                            width = "100%",
                            placeholder = "Your message here"
                          )
                        )
                        
                      )
                    )
