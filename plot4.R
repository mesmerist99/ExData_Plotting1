
### step1 : Loading the data
## set working directory
setwd("C:/Users/SY.YI/Desktop/R")

## road the dataset into R
data <- read.table("household_power_consumption.txt", header = T, sep = ";")

# bind the two columns (Date, Time) into the new column (datetime)
data$datetime <- paste(data$Date, data$Time)

## convert Date, Time, datetime variables into Date/Time classes
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")
data$datetime <- strptime(data$datetime, format = "%d/%m/%Y %H:%M:%S")

## subsetting data from the dates 2007-02-01 and 2007-02-02
target.data <- subset(data, subset = 
                          (Date == "2007-02-02" | Date == "2007-02-01"  ))

### step2 : Making Plots
## plot4
## set weekdays in english
Sys.setlocale("LC_TIME", "English")

# open png graphic device
png(filename = "plot4.png")

## plot4
# split screen
par(mfcol = c(2,2))

# create 1st plot
plot(target.data$datetime, target.data$Global_active_power, 
     type = "l", yaxt="n",
     xlab ="", ylab = "Global Active Power (kilowatts)")
axis(2, yaxp=c(0,6,3), las=2)

# create 2nd plot
plot(target.data$datetime, target.data$Sub_metering_1, 
     type = "l", yaxt="n",
     xlab = "", ylab = "Energy sub metering")
lines(target.data$datetime, target.data$Sub_metering_2, col = "red")
lines(target.data$datetime, target.data$Sub_metering_3, col = "blue")

axis(2, yaxp=c(0,30,3), las=2)

legend("topright", 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1), col = c("black","red","blue"), cex = 0.9, bty = "n")

# create 3rd plot
target.data$Voltage <- as.numeric(as.character(target.data$Voltage))

plot(target.data$datetime, target.data$Voltage, 
     type = "l", yaxt = "n",
     xlab = "datetime", ylab = "Voltage")

axis(2, yaxp=c(234,246,6), las=2)

# create 4th plot
target.data$Global_reactive_power <- as.numeric(as.character(target.data$Global_reactive_power))

plot(target.data$datetime, target.data$Global_reactive_power, 
     type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")

# save plot in png file
dev.off()

