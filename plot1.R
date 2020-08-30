library(data.table)

filename = "./dataset/household_power_consumption.txt"

#Reads in data from file then subsets data for specified dates
data = data.table::fread(input = filename, sep = ";", na.strings = "?", header = TRUE)

# Prevents histogram from printing in scientific notation
data[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


# Change Date Column to Date Type
data[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]


# Filter Dates for 2007-02-01 and 2007-02-02
data <- data[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(data[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
