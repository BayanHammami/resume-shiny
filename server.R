output <-
  lapply(paste0(
    "./server-components/",
    list.files("./server-components", recursive = T)
  ), source)


server <- function(input, output) {
  output$education_plot_title <- renderText({ 
    input$education_plot_type
  })
  
  output$education_plot <- renderPlot({
    if(input$education_plot_type == "Units By Subject Area"){
      units_by_subject_area(academic_transcript, input)
    }else if(input$education_plot_type == "Word Cloud of Course Names"){
      word_cloud_of_course_names(academic_transcript, input$education_radio)
    }else if(input$education_plot_type == "Distribution of Grades"){
      distribution_of_grades(academic_transcript, input)
    }
  })
  
  output$skills_plot <- renderPlot({
    if(input$skills_plot_type == "Tools & Technologies"){
      generic_radarchart(tools_df$tool_names, tools_df$tool_scores)
    }else if(input$skills_plot_type == "Skills"){
      generic_radarchart(skills_df$skill_names, skills_df$skill_scores)
    }
  })
  # 
  # output$home_plot <- renderPlot({
  #   input$home_regenerate
  #   generic_wordcloud(
  #     resume_text,
  #     min.freq = input$min_word_freq,
  #     regenerate = input$home_regenerate
  #   )
  #   
  #   return(p)
  # })
  # 

  
  output$home_plot <- renderImage({
    filename <-
      paste0(digest::digest(c(
        input$min_word_freq, input$home_regenerate
      ))
      , ".png")
    full_path <- paste0('./precalculated/', filename)
    if (filename %in% list.files('./precalculated/')) {
      list(src = full_path)
    } else {
      png(full_path)
      generic_wordcloud(
        resume_text,
        min.freq = input$min_word_freq,
        regenerate = input$home_regenerate
      )
      dev.off()
      list(src = full_path)
    }
    
  }, deleteFile = FALSE)


  
  
  output$experience_plot <- renderPlot({
    input$experience_regenerate
    build_network_graph(
      employment_data,
      min_freq = input$min_con_freq,
      input$experience_section,
      input$experience_regenerate
    )
  })
  
  
  
  
  observe({
    if(is.null(input$send) || input$send==0) return(NULL)
    from <- isolate(input$from)
    to <- isolate(input$to)
    subject <- isolate(input$subject)
    msg <- isolate(input$message)
    sendmail(from, to, subject, msg)
  })
}
