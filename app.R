# About this script-------------------------------------------------------------
# Purpose: Create the shiny application based on the prepared data
# Project task: Data visualization of a self-chosen Public Health problem
# Project title: Source reduction in IVM for dengue fever in Dhaka, Bangladesh
# Author name: Anna Wedler
# Student ID: 22306466
# Study program: MSc Global Health
# Module: Digital Health
# Examination date: February 8th 2024

# create shiny app--------------------------------------------------------------

# load packages and data 
pacman::p_load(
  shiny,
  ggplot2,
  dplyr,
  tidyverse,
  bslib
  )

source("clean.R")

# define UI for application that draws interactive bar chart 
ui <- fluidPage(
  
  titlePanel("Source reduction in IVM for dengue fever"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("area_type", "Area type", levels(dengue_infr$area_type))
      ),
    mainPanel(
      navset_card_underline(
        nav_panel("Data visualization", titlePanel("Data visualization"), plotOutput("BarChart1"), p("Graph description"),
                  tags$ul(
                    tags$li(tags$b("Area"), " - the area of Dhaka district where dengue fever cases have been confirmed"),
                    tags$li(tags$b("area_type"), " - the area type the case was confirmed: undeveloped, developed"),
                    tags$li(tags$b("house_type"), " - the house type the case was confirmed: building, tin-shed, other")
                  )),
        nav_panel("Interpretation", titlePanel("Interpretation"), p("In 13 out of 36 areas in Dhaka (Bangshal, Demra, Dhanmondi, 
                                                                    Jatrabari, Kadamtali, Khilkhet, Kafrul, Kalabagan, Mirpur, 
                                                                    Mohammadpur, Pallabi, Paltan, Tejgaon) the number of dengue 
                                                                    fever cases in the current outbreak is 10 or higher."),
                                                                  p("The data indicates an increased trend of dengue fever cases 
                                                                    in undeveloped compared to developed areas across Dhaka. The 
                                                                    distribution by area type shows that in developed areas, 6 out 
                                                                    of 36 areas indicate 10 or more cases while there are 9 out of 
                                                                    36 areas in the undeveloped areas of Dhaka. Additionally, among 
                                                                    the undeveloped areas, the number of cases per area is higher 
                                                                    compared to those in developed areas – three of them indicating 
                                                                    more than 15 cases (Bangshal, Jatrabrari, Kafrul)."),
                                                                  p("The distribution of dengue cases by house type indicates contradicting 
                                                                    findings. While in areas such as Bangshal, Badda, or Sabujbagh (in 
                                                                    undeveloped areas), more cases were identified in tin-sheds, it is 
                                                                    the opposite case in areas such as Demra or Tejgaon, where the share 
                                                                    of dengue cases in buildings is higher compared to tin-sheds. However, 
                                                                    there are various factors contributing to these findings. For instance, 
                                                                    some areas might be structurally more advanced than others which would 
                                                                    explain the higher number of cases living in buildings rather than tin-sheds.")),
        nav_panel("Recommendation", titlePanel("Recommendation"), p("Based on the data, funding should be allocated to 13 out of 36 areas in 
                                                                    Dhaka initially. The areas of Bangshal, Demra, Dhanmondi, Jatrabari, Kadamtali, 
                                                                    Khilkhet, Kafrul, Kalabagan, Mirpur, Mohammadpur, Pallabi, Paltan, Tejgaon indicate more than 10 cases 
                                                                    both, in developed and in undeveloped areas and should hence be prioritized in funding allocation 
                                                                    for source reduction in IVM of dengue fever."),
                                                                  p("In these areas, it is recommended to prioritize source reduction in undeveloped areas, given 
                                                                    the higher number of cases in these. However, the difference is negligible."), 
                                                                  p("Funding allocation based on house type is not recommended given insufficient evidence."), 
                                                                  p("However, high population density and rapid, unplanned urbanization and development contribute 
                                                                     to the increasing burden of dengue fever in the urban regions like Dhaka. The initiation and 
                                                                     implementation of appropriate and designed urbanization and the support of infrastructure improvements 
                                                                     both, at the level of houses and areas, to reduce dengue occurrence in the long run is recommended. 
                                                                     Additional areas of IVM should be taken into consideration."))
        )
     )
  )
)

# create server function
server <- function(input, output) {
  filteredData <- reactive({
    dengue_infr_filtered <- dengue_infr %>% filter(area_type == input$area_type)
    return(dengue_infr_filtered)  
  })
  
  output$BarChart1 <- renderPlot({
    ggplot(filteredData(), aes(x = area, fill = house_type)) +
      geom_bar() +
      scale_fill_grey() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(title = "Distribution of cases by area, area type and house type",
           x = "Area",
           y = "Cases",
           fill = "House type")
  })
}

# run the Shiny app-------------------------------------------------------------
shinyApp(ui = ui, server = server)


