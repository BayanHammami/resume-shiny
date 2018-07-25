
word_cloud_of_course_names <- function(academic_transcript, degree_selected = 1){
  if(degree_selected == 2){
    academic_transcript <- academic_transcript %>% 
      filter(Degree == 'Engineering')
  }else if(degree_selected == 3){
    academic_transcript <- academic_transcript %>% 
      filter(Degree == 'Commerce')
  }
  generic_wordcloud(academic_transcript$Course)
  
}




units_by_subject_area <- function(academic_transcript, input){
  education_units_data <- academic_transcript %>% 
    mutate(education_radio_value = ifelse(Degree == 'Engineering', 2, 3)) %>% 
    group_by(`Subject Area`, Degree, education_radio_value) %>% 
    summarise(`Number of Courses` = n())
  
  if(input$education_radio %in% c(2,3)){
    education_units_data <- education_units_data %>% 
      filter(education_radio_value == input$education_radio)
    g <-
      ggplot(education_units_data) +
      coord_flip() +
      ylab('Number of Courses') +
      xlab('Subject Area') +
      geom_col(aes(
        x = reorder(`Subject Area`, `Number of Courses`, sum),
        y = `Number of Courses`
      ),
      fill =  ifelse(input$education_radio == 2, "#00BFC4", "#F8766D")) +
      theme(axis.text=element_text(size=14),
           axis.title=element_text(size=16,face="bold"),
           legend.text=element_text(size=14),
           legend.title=element_text(size=14))
  }else{
    g <- 
      ggplot(education_units_data) +
      coord_flip() +
      ylab('Number of Courses') +
      xlab('Subject Area') +
      geom_col(aes(
        x = reorder(`Subject Area`, `Number of Courses`, sum),
        y = `Number of Courses`,
        fill = Degree
      )) +
      theme(axis.text=element_text(size=14),
            axis.title=element_text(size=16,face="bold"),
            legend.text=element_text(size=14),
            legend.title=element_text(size=14))
    
  }
  return(g)
}

distribution_of_grades <- function(academic_transcript, input){
  if(input$education_radio %in% c(2,3)){
    academic_transcript <- academic_transcript %>% 
      mutate(education_radio_value = ifelse(Degree == 'Engineering', 2, 3)) %>% 
      filter(education_radio_value == input$education_radio)
    g <- 
      ggplot(academic_transcript) +
      xlim(50, 100) +
      ylab("Frequency") +
      theme(axis.text=element_text(size=14),
            axis.title=element_text(size=16,face="bold"),
            legend.text=element_text(size=14),
            legend.title=element_text(size=14))
    if(input$education_grades_radio == "Density"){
      g <- 
        g +
        geom_density(
          aes(Grade),
          alpha = 0.1,
          fill = ifelse(input$education_radio == 2, "#00BFC4", "#F8766D"),
          colour = ifelse(input$education_radio == 2, "#00BFC4", "#F8766D")
        )
    }else{
      g <- 
        g +
        geom_histogram(
          aes(Grade),
          alpha = 0.1,
          fill = ifelse(input$education_radio == 2, "#00BFC4", "#F8766D"),
          colour = ifelse(input$education_radio == 2, "#00BFC4", "#F8766D"),
          position="identity"
        )      
    }
  }else{
    g <-
      ggplot(academic_transcript) +
      xlim(50, 100) +
      ylab("Frequency") +
      theme(axis.text = element_text(size = 14),
            axis.title = element_text(size = 16, face = "bold"),
            legend.text=element_text(size=14),
            legend.title=element_text(size=14))
    if(input$education_grades_radio == "Density"){
      g <- 
        g +
        geom_density(aes(Grade,
                         color = Degree,
                         fill = Degree),
                     alpha = 0.1)
    }else{
      g <- 
        g +
        geom_histogram(aes(Grade,
                           color = Degree,
                           fill = Degree),
                       alpha = 0.1,
                       position = "identity")
    }
  }
  return(g)
}