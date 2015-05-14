##Data is loaded using the loadData.R script.
##NEI and SCC data frames will not be available without running loadData.R
##"https://github.com/jhabib/ExData_Plotting2/blob/master/loadData.R"
print("Please run loadData.R before proceeding")

####Load dependencies
packages <- c("data.table")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}
lapply(packages, library, character.only=TRUE)

NEI <- data.table(NEI[NEI$fips=="24510",], key="SCC")
SCC <- data.table(SCC[grepl("Veh+", SCC$"Short.Name"),], key="SCC")

##Merge NEI and SCC by key (SCC)
##Use only Baltimore data from NEI (fips=="24510")
mergedData <- merge(NEI, SCC)

##Drop unnecessary columns
columnsToDrop <- which(!(colnames(mergedData) %in% c("Emissions", "year", "Short.Name")))
mergedData <- mergedData[, (columnsToDrop):=NULL]

agrData <- aggregate(Emissions ~ year, data=mergedData, FUN="sum")

##Create a plot of aggregate Emissions from Coal sources vs year
##Add a trendline with abline
with(agrData, plot(x=year, y=Emissions, main="5 - Motor Vehicle Emissions in Baltimore by Year") +
       abline(glm(Emissions ~ year), col="blue", lwd=1))

##Output the plot to plot5.png
dev.copy(png, filename=file.path("./plot5.png"), width=480, height=480)
dev.off()