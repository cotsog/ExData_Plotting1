library(datasets)

data <- read.table(pipe('head -n 1 household_power_consumption.txt && grep "^1/2/2007\\|^2/2/2007" household_power_consumption.txt'), header=TRUE, sep=';')

data$DateTime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$DateTime <- format(data$DateTime, format="%Y-%m-%d %H:%M:%S")
data$DateTime <- as.POSIXlt(data$DateTime)

data <- data[,3:10]

png('plot3.png')
plot(x=data$DateTime, y=data$Sub_metering_1, type='n', xlab='', ylab='Energy sub metering')
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty = c(1, 1, 1), lwd = c(1, 1, 1), col = c('black', 'red', 'blue'))
lines(x=data$DateTime, y=data$Sub_metering_1, col='black')
lines(x=data$DateTime, y=data$Sub_metering_2, col='red')
lines(x=data$DateTime, y=data$Sub_metering_3, col='blue')
dev.off()