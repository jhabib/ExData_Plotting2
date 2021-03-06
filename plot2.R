##Data is loaded using the loadData.R script.
##NEI and SCC data frames will not be available without running loadData.R
##"https://github.com/jhabib/ExData_Plotting2/blob/master/loadData.R"
print("Please run loadData.R before proceeding")

#Plot trend for Baltimore City (fips=="24510")
columnsToKeep <- which(colnames(NEI) %in% c("Emissions", "year"))
agrData <- aggregate(Emissions ~ year, data=NEI[NEI$fips=="24510", columnsToKeep], FUN="sum")
plot(x=agrData$year, y=agrData$Emissions, type="p", main="2 - Emissions in Baltimore by Year", xlab="year", ylab="Emissions")

##Add a linear trend line
fit <- glm(agrData$"Emissions"~agrData$"year")
abline(fit, col="blue", lwd=1)

##Output the plot to plot2.png
dev.copy(png, filename=file.path("./plot2.png"), width=480, height=480)
dev.off()