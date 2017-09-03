library(dplyr)

data = read.csv("household_power_consumption.txt", sep=";")
data$Date <- as.Date(strptime(data$Date,"%d/%m/%Y"))

pdays <- data %>%
    filter(Date == "2007-02-01" | Date == "2007-02-02")
pdays <- pdays %>%
    filter(Global_active_power != "?")

pdays$Global_active_power <- levels(pdays$Global_active_power)[pdays$Global_active_power]

png("plot1.png",480,480)
hist(as.numeric(pdays$Global_active_power), col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
