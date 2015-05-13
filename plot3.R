##Data is loaded using the loadData.R script.
##NEI and SCC data frames will not be available without running loadData.R
print("Please run loadData.R before proceeding")

####Load dependencies
packages <- c("ggplot2", "reshape2")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}
lapply(packages, library, character.only=TRUE)

#Plot trend for each "type" of Source for Baltimore City (fips=="24510")
columnsToKeep <- which(colnames(NEI) %in% c("Emissions", "year", "type"))
agrData <- aggregate(Emissions ~ type+year, data=NEI[NEI$fips=="24510", columnsToKeep], FUN="sum")
ggplot(data=agrData, aes(x=year, y=Emissions, colour=type)) + geom_point() + geom_smooth(method=lm, se=FALSE)

##An alternative, a multifaceted plot
# ggplot(data=agrData, aes(x=year, y=Emissions)) + 
#   geom_point() + 
#   facet_grid(type~.) + 
#   geom_smooth(method=lm, se=FALSE)

##Output the plot to plot3.png
dev.copy(png, filename=file.path("./plot3.png"), width=480, height=480)
dev.off()