##This is the series of commands (function) used to generate plot2.png.
## I used the data.table package to manipulate and subset the original raw data.

##First, I setwd("~/Shanset the working directory where the extracted householdconsumption.txt is found.
setwd("E:/R Practice/AAA   DOST PCIEERD Data Science Track/Notes and slideshows/Module 4/Week 1/Course Project 1")

##Then loaded the "amazing" data.table package.
library(data.table)

##Read the raw data and stored to a data.table object called "datapower".
datapower <- fread(input = "household_power_consumption.txt", na.strings = "?")

##Turned off the penalty of using scientific notation in plots in R.
options(scipen = 999)

##Transformed the values of the Global_active_power into as.numeric to prevent the results from being coerced into scientific notation form once plotted.
datapower[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

##Created a new variable called 'dateTime' that holds the new time format with a POSIXct class which will 
##enable the user to subset the needed data for the plot.
datapower[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

##Subset the data that are needed/requirements for the plot.
data <- datapower[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

##Specified my preferred graphics device and its dimensions.
png("plot2.png", width=480, height=480)

##Called the plot to be generated with the required specifications.
plot(x = data[, dateTime], y = data[, Global_active_power]
     , type = "l", xlab ="", ylab = "Global_active_power (kilowatts)")

##And finally turned off the connection to the graphics device.
dev.off()
