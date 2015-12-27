## Common functions
source(file = "common_components.R")

## Download, and extract the data using the common function defined in common_components.R
download_data()

## Read the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## Subset vehicle related NEI data for Baltimore City
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_SCC <- SCC[vehicles, ]$SCC
vehicles_NEI <- NEI[NEI$SCC %in% vehicles_SCC, ]
baltimore_vehicles_NEI <- vehicles_NEI[vehicles_NEI$fips=="24510", ]

## Prepare to save plot 5 image in "figure" directory

## Load ggplot2 library
library(ggplot2)

## Start png device
png("figure/plot5.png", width = 650, height = 480, units = "px")

## Create plot 5
ggplot(baltimore_vehicles_NEI, aes(factor(year), Emissions)) +
  geom_bar(stat = "identity") +
  theme_bw() +  guides(fill = FALSE) +
  labs(x = "year", y = expression("Total PM2.5 Emissions (in Tons)")) + 
  labs(title = expression("PM2.5 Motor Vehicle Source Emissions in Baltimore City from 1999-2008"))

## Turn off png device
dev.off()

## All done!