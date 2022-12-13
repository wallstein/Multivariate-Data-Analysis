####Merging GPS data with per capita emissions & gdp

# clear environment
rm(list = ls())

## Load and install the packages 
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse,
               parallel, # parallel computing
               furrr, # parallel computing
               tictoc,
               fixest,
               #purrr,
               #readxl,# excel files
               haven, # dta files
               lubridate,
               ggplot2,
               ggthemes,
               RColorBrewer,
               hrbrthemes,
               viridis,
               wesanderson,
               tidytext
               
               library(tidyverse)               
               library(dplyr)
               library(data.table)
               library(tidyr)
               
# Setups environment for the R project
setwd("C:/Users/blasi/OneDrive/Desktop/UPF Studies/multivariate data analysis/Class/Group project/1 LOCAL COPIES/pc_emissions_plus gdp")
#load emissions data
df.em <- read.csv("data.csv")
View(df.em)
#drop column X
df.em =
  df.em %>%
    select(-c(X))
View(df.em)
#load preference data
setwd("C:/Users/blasi/OneDrive/Desktop/UPF Studies/multivariate data analysis/Class/Group project/1 LOCAL COPIES/gps")
library("haven")
df.gps <- read_dta("country.dta")
View(df.gps)
#rename isocode to country.code
df.gps <- rename(df.gps, iso_code = isocode)
#Merge the two country be country code
df.empref <- merge(df.em, df.gps, by = "iso_code")
View(df.empref)

##save the data frame
save(df.empref, file = "Emissions_and_Preferences.RData")
