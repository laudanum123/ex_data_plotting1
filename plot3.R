library(dplyr)
dev.off(dev.list()["RStudioGD"])
data = read.csv("household_power_consumption.txt", sep=";")
data$Date <- as.Date(strptime(data$Date,"%d/%m/%Y"))

pdays <- data %>%
    filter(Date == "2007-02-01" | Date == "2007-02-02")
pdays <- pdays %>%
    filter(Sub_metering_1 != "?", Sub_metering_2 != "?", Sub_metering_3 != "?")


pdays$Sub_metering_1 <- levels(pdays$Sub_metering_1)[pdays$Sub_metering_1]
pdays$Sub_metering_2 <- levels(pdays$Sub_metering_2)[pdays$Sub_metering_2]


pdays$DateTime <- as.POSIXct(paste(pdays$Date, pdays$Time), format="%Y-%m-%d %H:%M:%S")

png("plot3.png",480,480)
with(pdays, plot(x = DateTime, y = as.numeric(pdays$Sub_metering_1), type = "n",xlab = "", ylab = "Energy sub metering"))
lines(x = pdays$DateTime, y = as.numeric(pdays$Sub_metering_1))
lines(x = pdays$DateTime, y = as.numeric(pdays$Sub_metering_2), col="red")
lines(x = pdays$DateTime, y = as.numeric(pdays$Sub_metering_3), col="blue")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty = c(1,1,1),col=c("black","red","blue"))
dev.off()
