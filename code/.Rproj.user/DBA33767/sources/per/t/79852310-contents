#install.packages("reshape")
library(readxl)
library(reshape)
# Path to the data, which is universal for us
data_path = paste(dirname(getwd()), "/data/", sep = "")

# Filename of the data
filename_emissions = paste(data_path, "climatetrace_emissions_by_subsector_timeseries_interval_year_since_2020_to_2020.csv", sep = "")
# Loading the Climate Trace Emissions data that Charles put into the WhattsApp Group
emissions = read.csv(filename_emissions,sep = ",", header = TRUE)

# Aggregating Emissions over each Country
total_emissions = aggregate(emissions[,1], by = list(emissions$country, emissions$country_full), FUN = sum, na.rm = TRUE)
# Renaming variables
colnames(total_emissions) = c("Country Code","Emissions Data Country Name", "Emissions")

# Emissions per sector
per_sector_emissions = aggregate(emissions[,1], by = list(emissions$country, emissions$country_full, emissions$sector), FUN = sum, na.rm = T)
colnames(per_sector_emissions) = c("country code","country name", "sector", "emissions")
per_sector_emissions = reshape(per_sector_emissions, idvar = c("country code", "country name") , timevar = "sector", direction = "wide")
per_sector_emissions$emissions.total = total_emissions$Emissions


# Reading the GDP Excel Sheet from https://data.worldbank.org/indicator/NY.GDP.MKTP.CD?end=2021&start=1960
filename_gdp = paste(data_path, "GDP_worldbank.xls", sep = "")
gdp = read_excel(filename_gdp)
# Renaming variables to the correct names in the third row
colnames(gdp) = gdp[3,]
# Drop the first three irrelevant rows
gdp = gdp[-(1:3),]
# Drop all irrelevant variables
gdp = gdp[c("Country Name", "Country Code", "2020")]
# Rename the 2020 GDP variable simply to GDP
names(gdp)[names(gdp) == "2020"] <- "GDP"

# Merge GDP and Emissions data. I kept non matching entries which have to be checked if the country code is wrong
df_total = merge(total_emissions, gdp, by = "Country Code", all = TRUE)
# Reorder variables
df_total = df_total[, c(1, 4, 2, 3, 5)]

# Calculate Emissions per GDP
df_total$GDP = as.numeric(df_total$GDP)
df_total$Emissions_per_GDP = df_total$Emissions / df_total$GDP


# Merge per sector and GDP
gdp = gdp[c("Country Code", "GDP")]
names(gdp)[names(gdp) == "Country Code"] <- "country code"
gdp$GDP = as.numeric(gdp$GDP)
df_per_sector = merge(per_sector_emissions, gdp, by = "country code", all = F)

filename_per_sector_gdp = paste(data_path, "/output/per_sector_emissions_gdp.csv", sep = "")
write.csv(df_per_sector, file = filename_per_sector_gdp)

pairs(df_per_sector[,c(-1,-2)])


filename_data = paste(data_path, "data.csv", sep = "")
data = read.csv(filename_data)
