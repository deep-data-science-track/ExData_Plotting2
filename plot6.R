## Common functions
source(file = "common_components.R")

## Download, and extract the data using the common function defined in common_components.R
download_data()

## Read the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## Subset vehicle related NEI data for Baltimore City & LA
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_SCC <- SCC[vehicles, ]$SCC
vehicles_NEI <- NEI[NEI$SCC %in% vehicles_SCC, ]
baltimore_vehicles_NEI <- vehicles_NEI[vehicles_NEI$fips=="24510", ]
baltimore_vehicles_NEI$city <- "Baltimore City"
LA_vehicles_NEI <- vehicles_NEI[vehicles_NEI$fips=="06037", ]
LA_vehicles_NEI$city <- "Los Angeles County"
baltimore_LA_vehicles_NEI <- rbind(baltimore_vehicles_NEI, LA_vehicles_NEI)

## Prepare to save plot 6 image in "figure" directory

## Load ggplot2 library
library(ggplot2)

## Start png device
png("figure/plot6.png", width = 650, height = 480, units = "px")

## Create plot 6
ggplot(baltimore_LA_vehicles_NEI, aes(factor(year), (Emissions/10^3), fill = city)) +
  geom_bar(aes(fill = year), stat = "identity") +
  facet_grid(scales = "free", space = "free", .~city) +
  theme_bw() +  guides(fill = FALSE) +
  labs(x = "year", y = expression("Total PM2.5 Emissions (in 10^3 Tons)")) + 
  labs(title = expression("PM2.5 Motor Vehicle Source Emissions in Baltimore City & Los Angeles from 1999-2008"))

## Turn off png device
dev.off()

## All done!