## Common functions
source(file = "common_components.R")

## Download, and extract the data using the common function defined in common_components.R
download_data()

## Read the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Subset NEI data by Baltimore City's fips
baltimore_city_NEI <- NEI[NEI$fips == "24510", ]

## Emissions from Baltimore City by year/type
baltimore_city_emissions <- aggregate(Emissions ~ year + type, baltimore_city_NEI, sum)

## Prepare to save plot 3 image in "figure" directory

## Load ggplot2 library
library(ggplot2)

## Start png device
png(filename = "figure/plot3.png", width = 650, height = 480, units = "px")

## Create plot 3
ggplot(baltimore_city_emissions, aes(x = factor(year), y = Emissions, fill = type)) +
  geom_bar(stat="identity") + facet_grid(. ~ type) + xlab("Year") + ylab("Total PM2.5 Emissions") +
  ggtitle("PM2.5 Emissions in Baltimore City")

## Turn off png device
dev.off()

## All done!