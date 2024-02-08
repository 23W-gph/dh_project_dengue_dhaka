# About this script-------------------------------------------------------------
# Purpose: Load, clean and prepare data
# Project task: Data visualization of a self-chosen Public Health problem
# Project title: Source reduction in IVM for dengue fever in Dhaka, Bangladesh
# Author name: Anna Wedler
# Student ID: 22306466
# Study program: MSc Global Health
# Module: Digital Health
# Examination date: February 8th 2024

# install and load packages------------------------------------------------------
install.packages("pacman")
pacman::p_load(here,
               readr,
               magrittr,
               tidyverse,
               dplyr,
               janitor,
               )

# import, load, and prepare data-------------------------------------------------
dengue_data <- read_csv(
  here("dataset.csv"),
  name_repair = "universal",
  col_types = cols(
    Gender = col_factor(levels = c("Female", "Male")), 
    Age = col_integer()), 
)

# view data----------------------------------------------------------------------
View(dengue_data)   

# transform data-----------------------------------------------------------------
dengue_data <- dengue_data  %>% 
  
  # clean column names outside of mutate
  clean_names()  %>% 
  
  # mutate data
  mutate(
    across(c(area, area_type, house_type), as.factor),
    outcome = as.logical(outcome)
  )  %>% 
  
  # remove duplicates
  distinct()

# subset table with relevant data----------------------------------------- 
dengue_infr <- subset(dengue_data, outcome == 1, select = c(area, outcome, area_type, house_type))

# review new data frame 
print(dengue_infr)
