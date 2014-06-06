library(datasets)

data <- read.table(pipe('head -n 1 household_power_consumption.txt && grep "^1/2/2007\\|^2/2/2007" household_power_consumption.txt'), header=TRUE, sep=';')

data$DateTime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$DateTime <- format(data$DateTime, format="%Y-%m-%d %H:%M:%S")
data$DateTime <- as.POSIXlt(data$DateTime)

data <- data[,3:10]

png('plot2.png')
plot(x=data$DateTime, y=data$Global_active_power, type='n', xlab='', ylab='Global Active Power (kilowatts)')
lines(x=data$DateTime, y=data$Global_active_power)
dev.off()