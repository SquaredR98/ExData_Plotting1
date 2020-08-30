library("data.table")

setwd("/home/ravi-ranjan/Courses/Coursera Data Science Specialization/
      03. Exploratory Data Analysis/Week-1 Base Plotting")
getwd()

#Reads in data from file then subsets data for specified dates
data <- data.table::fread(input = "./dataset/household_power_consumption.txt" 
                             , na.strings="?"
)

# Prevents Scientific Notation
data[, Global_active_power := lapply(.SD, as.numeric),
        .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
data <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png", width=480, height=480)

# Plot 3
plot(data[, dateTime], data[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(data[, dateTime], data[, Sub_metering_2],col="red")
lines(data[, dateTime], data[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()