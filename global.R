options(scipen = 99)
library(tidyverse) # koleksi beberapa package R
library(dplyr) # grammar of data manipulation
library(readr) # membaca data
library(ggplot2) # plot statis
library(plotly) # plot interaktif
library(glue) # setting tooltip
library(scales) # mengatur skala pada plot
library(shiny)
library(shinydashboard)
library(echarts4r)

#read data
dps <- readxl::read_excel("Data-Pengelolaan-Sampah.xlsx", sheet = 1)

#Population Data
pop_data <- dps %>% 
  filter(Data == c("Population", "Population birth", "Population death", 
                   "In migration", "Out migration", "Working people", "Residents not working")) %>%
  select("Data", "Year", "Value") %>%
  mutate(Population = glue("Population : {comma(Value)} people"))

#Waste Generation Data
wg <- dps %>% 
  filter(Data == "Waste generation") %>%
  select("Data", "Year", "Value") %>%
  mutate(Waste = glue("Waste generation : {comma(Value)} ton"))

#Source of Waste Data
sw <- dps %>% 
  filter(Data == c("Household", "Public facility", "Market", "Commercial", "District", "Office area", "Other")) %>%
  select("Data", "Value") %>%
  mutate(Percentage = glue("Proportion : {(Value)}%"))

# Waste Management per Year Data
wm <- dps %>%
  filter(Data %in% c("TPS", "Waste bank", "TPA", "ITF non-incinerator", "Informal handled", "Not handled waste"),
         Year == "2021") %>%
  select(Data, Year, Value) %>%
  mutate(Managed = glue("Value : {comma(Value)} ton")) %>%
  arrange(desc(Value))

