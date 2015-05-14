##Data is loaded using the loadData.R script.
##NEI and SCC data frames will not be available without running loadData.R
print("Please run loadData.R before proceeding")

####Load dependencies
packages <- c("data.table")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}
lapply(packages, library, character.only=TRUE)

NEI <- data.table(NEI, key="SCC")
SCC <- data.table(SCC, key="SCC")

mergedData <- merge(NEI, SCC)

columnsToDrop <- which(!(colnames(mergedData) %in% c("Emissions", "year", "Short.Name")))

mergedData <- mergedData[, (columnsToDrop):=NULL]
mergedData <- mergedData[grepl("Coal+", mergedData$"Short.Name"),]

agrData <- aggregate(Emissions ~ year, data=mergedData, FUN="sum")

##Create a plot of aggregate Emissions from Coal sources vs year
##Add a trendline with abline
with(agrData, plot(x=year, y=Emissions, main="4 - Coal Emissions by Year across USA", xlab="year", ylab="Emissions") +
       abline(glm(Emissions ~ year), col="blue", lwd=1))

##Output the plot to plot4.png
dev.copy(png, filename=file.path("./plot4.png"), width=480, height=480)
dev.off()