library(dplyr)
dev.off(dev.list()["RStudioGD"])
data = read.csv("household_power_consumption.txt", sep=";")
data$Date <- as.Date(strptime(data$Date,"%d/%m/%Y"))

pdays <- data %>%
    filter(Date == "2007-02-01" | Date == "2007-02-02")
pdays <- pdays %>%
    filter(Global_active_power != "?")

pdays$Global_active_power <- levels(pdays$Global_active_power)[pdays$Global_active_power]

pdays$DateTime <- as.POSIXct(paste(pdays$Date, pdays$Time), format="%Y-%m-%d %H:%M:%S")

png("plot2.png",480,480)
par(pch=1)
with(pdays, plot(x = DateTime, y = as.numeric(pdays$Global_active_power), type = "n", ylab = "Global Active Power (kilowatts)"))
lines(x = pdays$DateTime, y = as.numeric(pdays$Global_active_power))
dev.off()
