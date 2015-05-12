print("Please run loadData.R before proceeding")

##Plot aggregate Emissions vs year
agrData <- aggregate(Emissions ~ year, data=NEI, FUN="sum")
plot(x=agrData$year, y=agrData$Emissions, type="l")

##Add a linear trend line
fit <- glm(agrData$"Emissions"~agrData$"year")
abline(fit, col="blue", lwd=1)

##Output the plot to plot1.png
dev.copy(png, filename=file.path("./plot1.png"), width=480, height=480)
dev.off()