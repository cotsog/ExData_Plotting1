library(datasets)

data <- read.table(pipe('head -n 1 household_power_consumption.txt && grep "^1/2/2007\\|^2/2/2007" household_power_consumption.txt'), header=TRUE, sep=';')

data$DateTime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$DateTime <- format(data$DateTime, format="%Y-%m-%d %H:%M:%S")
data$DateTime <- as.POSIXlt(data$DateTime)

data <- data[,3:10]

png('plot4.png')
par(mfrow=c(2,2))

# top-left
plot(x=data$DateTime, y=data$Global_active_power, type='n', xlab='', ylab='Global Active Power')
lines(x=data$DateTime, y=data$Global_active_power)

# top-right
plot(x=data$DateTime, y=data$Voltage, type='n', xlab='datetime', ylab='Voltage')
lines(x=data$DateTime, y=data$Voltage)

# bottom-left
plot(x=data$DateTime, y=data$Sub_metering_1, type='n', xlab='', ylab='Energy sub metering')
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty = c(1, 1, 1), lwd = c(1, 1, 1), col = c('black', 'red', 'blue'), bty = 'n')
lines(x=data$DateTime, y=data$Sub_metering_1, col='black')
lines(x=data$DateTime, y=data$Sub_metering_2, col='red')
lines(x=data$DateTime, y=data$Sub_metering_3, col='blue')

# bottom-right
plot(x=data$DateTime, y=data$Global_reactive_power, type='n', xlab='datetime', ylab='Global_reactive_power')
lines(x=data$DateTime, y=data$Global_reactive_power)

dev.off()