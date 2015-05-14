##Data is loaded using the loadData.R script.
##NEI and SCC data frames will not be available without running loadData.R
##"https://github.com/jhabib/ExData_Plotting2/blob/master/loadData.R"
print("Please run loadData.R before proceeding")

####Load dependencies
packages <- c("data.table", "ggplot2")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}
lapply(packages, library, character.only=TRUE)

##Subset the data to keep only relevant values
##Covert to data.table to speed up merge
NEI <- data.table(NEI[NEI$fips %in% c("24510", "06037"),], key="SCC")
SCC <- data.table(SCC[grepl("Veh+", SCC$"Short.Name"),], key="SCC")

##Merge NEI and SCC by key (SCC)
mergedData <- merge(NEI, SCC)

##Drop unnecessary columns
columnsToDrop <- which(!(colnames(mergedData) %in% c("fips", "Emissions", "year", "Short.Name")))
mergedData <- mergedData[, (columnsToDrop):=NULL]

agrData <- aggregate(Emissions ~ fips+year, data=mergedData, FUN="sum")

##Create a plot of aggregate Emissions vs year
##Add a trendlines with abline
ggplot(data=agrData, aes(x=year, y=Emissions, colour=fips),) + 
  labs(title="6 - Emissions by Year, LA County (06037) vs. Baltimore (24510)") + 
  geom_point() + 
  geom_smooth(method=lm, se=FALSE)


##Output the plot to plot6.png
dev.copy(png, filename=file.path("./plot6.png"), width=480, height=480)
dev.off()