## Common functions
source(file = "common_components.R")

## Download, and extract the data using the common function defined in common_components.R
download_data()

## Read the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Subset NEI data by Baltimore City's fips
baltimore_city_NEI <- NEI[NEI$fips == "24510", ]

## Emissions from Baltimore City by year
baltimore_city_yearly_emissions <- aggregate(Emissions ~ year, baltimore_city_NEI, sum)

## Prepare to save plot 2 image in "figure" directory

## Start png device
png(filename = "figure/plot2.png")

## Create plot 2
barplot(
  baltimore_city_yearly_emissions$Emissions,
  names.arg = baltimore_city_yearly_emissions$year,
  xlab = "Year",
  ylab = "PM2.5 Emissions (in Tons)",
  main = "Total PM2.5 Emissions from Baltimore City"
)

## Turn off png device
dev.off()

## All done!