##This is the series of commands (function) used to generate plot3.png.
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
## An important step in cleaning the data to make it ready for the processing.
datapower[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

##Created a new variable called 'dateTime' that holds the new time format with a POSIXct class which will 
##enable the user to subset the needed data for the plot.
datapower[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

##Subset the data that are needed/requirements for the plot.
data <- datapower[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

##Specified my preferred graphics device and its dimensions.
png("plot3.png", width=480, height=480)

##Called the plot to be generated with the required specifications.
plot(data[, dateTime], data[, Sub_metering_1], type = "l", xlab = "", ylab = "Energy sub metering")

##Added the annotations
lines(data[, dateTime], data[, Sub_metering_2], col ="red")
lines(data[, dateTime], data[, Sub_metering_3],col="blue")
legend("topright", 
       col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1), lwd=c(1,1))

##And finally turned off the connection to the graphics device.
dev.off()


