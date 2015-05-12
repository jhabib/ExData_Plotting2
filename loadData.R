##Download and unzip the data
dataFileName <- "exdata-data-NEI_data.zip"
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
workingDirectory <- "ExData_Plotting2"


if(!file.exists(file.path(dataFileName))){
  download.file(dataUrl, destfile=file.path(dataFileName), method="auto")  
}
unzip(zipfile=file.path(dataFileName), exdir=file.path("ExData_Plotting2"))

##Load RDS data file into R
NEI <- readRDS(file=file.path(workingDirectory, "summarySCC_PM25.rds"))
SCC <- readRDS(file=file.path(workingDirectory, "Source_Classification_Code.rds"))
