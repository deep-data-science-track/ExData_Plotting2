## Common functions
source(file = "common_components.R")

## Download, and extract the data using the common function defined in common_components.R
download_data()

## Read the data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## Subset coal combustion related NEI data
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coal_combustion <- (combustion & coal)
combustion_SCC <- SCC[coal_combustion, ]$SCC
combustion_NEI <- NEI[NEI$SCC %in% combustion_SCC, ]

## Prepare to save plot 4 image in "figure" directory

## Load ggplot2 library
library(ggplot2)

## Start png device
png("figure/plot4.png")

## Create plot 4
ggplot(combustion_NEI, aes(factor(year), Emissions/10^5)) +
  geom_bar(stat = "identity") +
  theme_bw() +  guides(fill = FALSE) +
  labs(x = "year", y = expression("Total PM2.5 Emissions (in 10^5 Tons)")) + 
  labs(title = expression("PM2.5 Coal Combustion Source Emissions across US from 1999-2008"))

## Turn off png device
dev.off()

## All done!