## Common components for re-use

## Function to download and extract the data
download_data <- function() {
  ## Download and extract the zip file
  if ((!(file.exists("data/Source_Classification_Code.rds"))) || (!(file.exists("data/summarySCC_PM25.rds")))) {
    if (!(file.exists("data/NEI.zip"))) {
      download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile="data/NEI.zip")
    }
    unzip("data/NEI.zip", exdir = "data", overwrite=T)
  }
}
