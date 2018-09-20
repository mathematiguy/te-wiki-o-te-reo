
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$kupuPlot <- renderPlot({
    kupu <- input$select_kupu
    
    dist_matrix %>% 
      select(word, !!kupu) %>% 
      filter(word != kupu) %>%
      rename(kupu = !!kupu) %>% 
      arrange(desc(kupu)) %>% 
      head() %>%
      ggplot(aes(x = reorder(word, kupu), y = kupu, fill = word)) +
      geom_bar(stat = 'identity') +
      guides(fill = FALSE) +
      coord_polar()
    
  })
  
})
