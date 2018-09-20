
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Kupu similarity"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectizeInput("select_kupu", "Select kupu", names(dist_matrix), selected = names(dist_matrix)[2], multiple = FALSE,
                     options = NULL)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("kupuPlot")
    )
  )
))
