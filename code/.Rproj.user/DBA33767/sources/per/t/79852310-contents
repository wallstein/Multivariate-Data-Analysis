library(readxl)

setwd("~/Library/Mobile Documents/com~apple~CloudDocs/Upf/MDA/Project")

# Loading the Climate Trace Emissions data that Charles put into the WhattsApp Group
emissions = read.csv("climatetrace_emissions_by_subsector_timeseries_interval_year_since_2020_to_2020.csv",sep = ",", header = TRUE)

# Aggregating Emissions over each Country
total_emissions = aggregate(emissions[,1], by = list(emissions$country, emissions$country_full), FUN = sum, na.rm = TRUE)
# Renaming variables
colnames(total_emissions) = c("Country Code","Emissions Data Country Name", "Emissions")


# Reading the GDP Excel Sheet from https://data.worldbank.org/indicator/NY.GDP.MKTP.CD?end=2021&start=1960
gdp = read_excel("API_NY.GDP.MKTP.CD_DS2_en_excel_v2_4701247.xls")
# Renaming variables to the correct names in the third row
colnames(gdp) = gdp[3,]
# Drop the first three irrelevant rows
gdp = gdp[-(1:3),]
# Drop all irrelevant variables
gdp = gdp[c("Country Name", "Country Code", "2020")]
# Rename the 2020 GDP variable simply to GDP
names(gdp)[names(gdp) == "2020"] <- "GDP"

# Merge GDP and Emissions data. I kept non matching entries which have to be checked if the country code is wrong
df = merge(total_emissions, gdp, by = "Country Code", all = TRUE)
# Reorder variables
df <- df[, c(1, 4, 2, 3, 5)]

# Calculate Emissions per GDP
df$GDP = as.numeric(df$GDP)
df$Emissions_per_GDP = df$Emissions / df$GDP

