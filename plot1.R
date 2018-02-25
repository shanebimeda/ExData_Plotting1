##This is the series of commands (function) used to generate plot1.png.
## I used the data.table package to manipulate and subset the original raw data.

##First, I set the working directory where the extracted householdconsumption.txt is found.
setwd("~/Shane's LiDAR laptop/A1 INECAR OFFICE/R Practice/AAA   DOST PCIEERD Data Science Track/Notes and slideshows/Lecture Videos/Module 4/Week 1/Course Project 1")

##Then loaded the "amazing" data.table package.
library(data.table)

##Read the raw data and stored to a data.table object called "datapower".
datapower <- fread(input = "household_power_consumption.txt", na.strings = "?")

##Turned off the penalty of using scientific notation in plots in R.
options(scipen = 999)

##Transformed the values of the Global_active_power into as.numeric to prevent the results from being coerced into scientific notation form once plotted.
datapower[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

##Subset the data that are needed/requirements for the plot.
data <- datapower[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

##Specified my preferred graphics device and its dimensions.
png("plot1.png", width = 480, height = 480)

##Called the plot to be generated with the required specifications.
hist(data[, Global_active_power], main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

##And finally turned off the connection to the graphics device.
dev.off()
