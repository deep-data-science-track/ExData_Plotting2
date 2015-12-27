## Common functions
source(file = "common_components.R")

## Download, and extract the data using the common function defined in common_components.R
download_data()

## Read the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## Aggregate (sum) emissions by year
total_yearly_emissions <- aggregate(Emissions ~ year, NEI, sum)

## Prepare to save plot 1 image in "figure" directory

## Start png device
png(filename = "figure/plot1.png")

## Create plot 1
barplot(
  (total_yearly_emissions$Emissions)/10^6,
  names.arg = total_yearly_emissions$year,
  xlab = "Year",
  ylab = "PM2.5 Emissions (in Million Tons)",
  main = "Total PM2.5 Emissions from All US Sources"
)

## Turn off png device
dev.off()

## All done!