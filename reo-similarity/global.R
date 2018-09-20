library(shiny)
library(tidyverse)

source("load_data.R", local = TRUE)

UI <- source("ui.R", local = TRUE)
SERVER <- source("server.R", local = TRUE)

shiny::shinyApp(ui=UI, server=SERVER)
