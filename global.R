library(glue)
library(sendmailR)
library(readr)
library(ggplot2)
library(dplyr)
library(wordcloud)
library(tm)
library(fmsb)
library(shiny)
library(ggnet)
library(network)
library(sna)
library(stringr)
library(digest)
library(promises)

options(warn=-1)


academic_transcript <- read_csv('./data/academic_transcript.csv')
fileName <- './data/resume_text.txt'
resume_text <- readChar(fileName, file.info(fileName)$size)
employment_data <- read_csv('./data/employment_data.csv')

build_network_graph <- function(employment_data, min_freq = 0, company, regenerate){
  args_val <- list(employment_data, min_freq, company, regenerate)
  source('./cache.R', local = TRUE)
  
  employment_data <- employment_data %>% 
    filter(Company == company)
  all_skill_edges <- lapply(1:nrow(employment_data), function(tag_index){
    skills <- str_split(employment_data$Tags[tag_index], ', ')[[1]]
    expand.grid(skills, skills)
  })
  
  all_skill_edges <- bind_rows(all_skill_edges)
  colnames(all_skill_edges) <- c('from_node', 'to_node')
  all_skill_edges_reduced <- all_skill_edges %>% 
    group_by(from_node, to_node) %>% 
    summarise(freq = n()) %>% 
    filter(!(from_node == to_node)) %>% 
    filter(freq >= min_freq)
  
  all_skills_nodes <- all_skill_edges %>% 
    group_by(from_node) %>% 
    summarise(freq_node = n())
  
  
  net <- network(all_skill_edges_reduced, vertex.attrnames = as.list(all_skills_nodes$from_node), directed = F, matrix.type = 'edgelist', ignore.eval = FALSE, names.eval = "freq")
  
  net %v% "freq_node" = all_skills_nodes$freq_node
  network_plot <- 
    ggnet2(net, label = T, edge.size = "freq", edge.color = "freq", edge.alpha = 0.1, layout.exp = 0.3, size = "degree", legend.position = "none")
  
  saveRDS(network_plot, path_to_cache_file)
  return(network_plot)
  
} 


tools_df <- data.frame(
  tool_names = c(
    "R",
    "Tableau",
    "Python",
    "AWS",
    "Spark",
    "SQL",
    "Linux",
    "Git"
  ),
  tool_scores = c(10, 9, 4, 5, 4, 10, 6, 5)
)

skills_df <- data.frame(
  skill_names = c(
    "Data Visualisation",
    "Data Engineering",
    "NLP",
    "Time Series",
    "Machine Learning",
    "Experimental Design",
    "Statistics",
    "Marketing Optimisation"
  ),
  skill_scores = c(
    9,8,7,5,8,7,6,9
  )
)

generic_radarchart <- function(names_vector, score_vector){
  args_val <-  list(names_vector, score_vector)
  source('./cache.R', local = TRUE)
  data=as.data.frame(matrix(score_vector , ncol=length(names_vector)))
  data=rbind(rep(10,length(names_vector)) , rep(0,length(names_vector)) , data)
  colnames(data) <- names_vector
  chart <- radarchart(
    data  ,
    axistype = 0,
    pcol = "#F8766D" ,
    pfcol = rgb(0.2, 0.5, 0.5, 0.2) ,
    plwd = 4 ,
    cglcol = "grey",
    cglty = 1,
    axislabcol = "grey",
    cglwd = 0.8,
    vlcex = 1.5
  )
  saveRDS(chart, path_to_cache_file)
  return(chart)
}

generic_wordcloud <- function(vector_source, scale = c(6, 1.5), min.freq = 1, regenerate = 0){
  args_val <-  list(vector_source, scale, min.freq, regenerate)
  source('./cache.R', local = TRUE)
  course_name_words <- docs <- Corpus(VectorSource(vector_source))
  # inspect(docs)
  toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
  docs <- tm_map(docs, toSpace, "/")
  docs <- tm_map(docs, toSpace, "@")
  docs <- tm_map(docs, toSpace, "\\|")
  docs <- tm_map(docs, toSpace, "&")
  docs <- tm_map(docs, content_transformer(tolower))
  # Remove numbers
  docs <- tm_map(docs, removeNumbers)
  # Remove english common stopwords
  docs <- tm_map(docs, removeWords, stopwords("english"))
  # Remove your own stop word
  # specify your stopwords as a character vector
  docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 
  # Remove punctuations
  docs <- tm_map(docs, removePunctuation)
  # Eliminate extra white spaces
  docs <- tm_map(docs, stripWhitespace)
  dtm <- TermDocumentMatrix(docs)
  m <- as.matrix(dtm)
  v <- sort(rowSums(m),decreasing=TRUE)
  d <- data.frame(word = names(v),freq=v)
  wordcloud_plot <-
    wordcloud(
      words = d$word,
      freq = d$freq,
      min.freq = min.freq,
      max.words = 200,
      random.order = F,
      rot.per = 0,
      colors = brewer.pal(8, "Dark2"),
      use.r.layout = F,
      scale = scale,
      fixed.asp = T
      
    )
  saveRDS(wordcloud_plot, path_to_cache_file)
  return(wordcloud_plot)
}






