##Data is loaded using the loadData.R script.
##NEI and SCC data frames will not be available without running loadData.R
##"https://github.com/jhabib/ExData_Plotting2/blob/master/loadData.R"
print("Please run loadData.R before proceeding")

##Plot aggregate Emissions vs year
agrData <- aggregate(Emissions ~ year, data=NEI, FUN="sum")
plot(x=agrData$year, y=agrData$Emissions, type="p", main="1 - Emissions by Year", xlab="year", ylab="Emissions")

##Add a linear trend line
fit <- glm(agrData$"Emissions"~agrData$"year")
abline(fit, col="blue", lwd=1)

##Output the plot to plot1.png
dev.copy(png, filename=file.path("./plot1.png"), width=480, height=480)
dev.off()