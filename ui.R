# UI for Shiny web app.
library(shiny)
library(BH)
library(rCharts)
#install.packages('devtools')
#options(unzip = 'internal')
#devtools::install_github('ramnathv/rCharts')
#install_github('ramnathv/rCharts')
#install.packages('dplyr')
#install.packages('DT')
#install.packages("data.table")
#install.packages('sqldf')

require(markdown)
require(data.table)
library(dplyr)
library(DT)

shinyUI(
    navbarPage("LEGO Sets Summary", 
    # multi-page user-interface including a navigation bar.
        tabPanel("Data Exploration",
             sidebarPanel(
                sliderInput("timeline", 
                            "Years:", 
                            min = 1950,
                            max = 2015,
                            value = c(2000, 2015)),
                sliderInput("pieces", 
                            "# Pieces:",
                            min = 0,
                            max = 5922,
                            value = c(1000, 2000) 
                ),
                            #format = "####"),
                uiOutput("themesControl"), # the id
                actionButton(inputId = "clearAll", 
                             label = "Clear selection", 
                             icon = icon("square-o")),
                actionButton(inputId = "selectAll", 
                             label = "Select all", 
                             icon = icon("check-square-o"))
        
             ),
             mainPanel(
                 tabsetPanel(
                   # Data 
                   tabPanel(p(icon("table"), "Dataset"), dataTableOutput(outputId="dTable")
                   ), # end of "Dataset" tab panel
                   tabPanel(p(icon("line-chart"), "Data Visualization"), 
                            h4('# of Themes / Year', align = "center"),
                            h5('Hover mouse over individual bar for Count details.', align ="center"),
                            showOutput("themesByYear", "nvd3"),
                            h4('Average # Pieces / Theme', align = "center"),
                            h5('Hover mouse over individual bar for avg # pieces for that theme', align ="center"),
                            showOutput("piecesByThemeAvg", "nvd3"),
                            h4('# of Pieces / Year', align = "center"),
                            h5('Hover mouse over individual points for Set Name and ID details.', align ="center"),
                            showOutput("piecesByYear", "nvd3"),
                            h4('Average # Pieces / Year', align = "center"),
                            h5('Hover mouse over individual points for avg # pieces for that yr.', align ="center"),
                            showOutput("piecesByYearAvg", "nvd3")
                            
                   ) # end of "Visualize the Data" tab panel

                 )
                   
            )     
        ), # end of "Explore Dataset" tab panel
    
        
        tabPanel("About the Project", mainPanel(
            includeMarkdown("about.md")
            )
        ) # end of "About" tab panel
    )
  
)
