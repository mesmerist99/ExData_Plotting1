
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
## plot3
## set weekdays in english
Sys.setlocale("LC_TIME", "English")

# open png graphic device
png(filename = "plot3.png")

# create plot3 without y axis
plot(target.data$datetime, target.data$Sub_metering_1, 
     type = "l", yaxt="n",
     xlab = "", ylab = "Energy sub metering")
lines(target.data$datetime, target.data$Sub_metering_2, col = "red")
lines(target.data$datetime, target.data$Sub_metering_3, col = "blue")

# add y aixs
axis(2, yaxp=c(0,30,3), las=2)

# add legend
legend("topright", 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1), col = c("black","red","blue"), cex = 0.9)

# save plot in png file
dev.off()
