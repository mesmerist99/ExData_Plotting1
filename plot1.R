
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
## plot1
# convert data class
target.data$Global_active_power <- as.numeric(as.character(target.data$Global_active_power))

# open png graphic device
png(filename = "plot1.png")

# create plot1 without axis
hist(target.data$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
     xaxt="n", yaxt="n",
     main = "Global Active Power", col = "red")

# add x, y axis
axis(1, xaxp=c(0,6,3), las=2)
axis(2, yaxp=c(0,1200,6), las=2)

# save plot in png file
dev.off()

