library("data.table")

setwd("/home/ravi-ranjan/Courses/Coursera Data Science Specialization/03. Exploratory Data Analysis/Week-1 Base Plotting")
getwd()

#Reads in data from file then subsets data for specified dates
data = data.table::fread(input = filename, sep = ";", na.strings = "?", header = TRUE)

# Prevents Scientific Notation
data[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
data <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = data[, dateTime]
     , y = data[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
