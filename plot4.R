library(dplyr)
dev.off(dev.list()["RStudioGD"])
data = read.csv("household_power_consumption.txt", sep=";")

data$Date <- as.Date(strptime(data$Date,"%d/%m/%Y"))
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
data <- data %>%
    filter(Date == "2007-02-01" | Date == "2007-02-02")

pdays1 <- pdays1 %>%
    filter(Sub_metering_1 != "?", Sub_metering_2 != "?", Sub_metering_3 != "?")

pdays2 <- data %>%
    filter(Global_active_power != "?")
pdays2$Global_active_power <- levels(pdays2$Global_active_power)[pdays2$Global_active_power]

pdays1$Sub_metering_1 <- levels(pdays1$Sub_metering_1)[pdays1$Sub_metering_1]
pdays1$Sub_metering_2 <- levels(pdays1$Sub_metering_2)[pdays1$Sub_metering_2]

voltage <- data %>%
    filter(Voltage != "?")

voltage$Voltage <- levels(voltage$Voltage)[pdays2$Voltage]

global_reactive <- data %>%
    filter(Global_reactive_power != "?")

global_reactive$Global_reactive_power <- levels(global_reactive$Global_reactive_power)[global_reactive$Global_reactive_power]

png("plot4.png",480,480)
par(mfcol = c(2,2))

with(pdays2, plot(x = DateTime, y = as.numeric(pdays2$Global_active_power), type = "n", ylab = "Global Active Power (kilowatts)"))
lines(x = pdays2$DateTime, y = as.numeric(pdays2$Global_active_power))


with(pdays, plot(x = DateTime, y = as.numeric(pdays$Sub_metering_1), type = "n",xlab = "", ylab = "Energy sub metering"))
lines(x = pdays$DateTime, y = as.numeric(pdays$Sub_metering_1))
lines(x = pdays$DateTime, y = as.numeric(pdays$Sub_metering_2), col="red")
lines(x = pdays$DateTime, y = as.numeric(pdays$Sub_metering_3), col="blue")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty = c(1,1,1),col=c("black","red","blue"))

with(global_reactive, plot(x = DateTime, y = as.numeric(Global_reactive_power), type = "n",xlab = "datetime", ylab = "Global_reactive_power"))
lines(x = global_reactive$DateTime, y = as.numeric(global_reactive$Global_reactive_power))

with(voltage, plot(x = DateTime, y = as.numeric(Voltage), type = "n",xlab = "datetime", ylab = "Voltage"))
lines(x = voltage$DateTime, y = as.numeric(voltage$Voltage))

dev.off()
