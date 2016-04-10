if(!file.exists("./data")) {dir.create("./data")}
ProjectUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(ProjectUrl, destfile = "./data.zip", method = "curl")
unzip("data.zip", exdir = "data")
PowerData <- read.table("./data/household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE, header = TRUE, na = "?")
TwoDays <- PowerData[PowerData$Date %in% c("1/2/2007", "2/2/2007"), ] ##subsets to the 2 days needed for analysis
TwoDays$DateTime <- paste(TwoDays$Date, TwoDays$Time, sep = " ") ## combines date and Time data into a new column
library(lubridate)
DateTime2 <- dmy_hms(TwoDays$DateTime) ##gives a Date class to combined DateTime2 column
TwoDays4 <- cbind(TwoDays, DateTime2) ## adds new DateTime2 column
png(file = "plot4.png", width = 480, height = 480, units = "px") ## opens png graphics device
plot4 <- par(mfrow = c(2, 2))
plot(TwoDays4$DateTime2, TwoDays$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(TwoDays4$DateTime2, TwoDays$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(TwoDays4$DateTime2, TwoDays4$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
lines(TwoDays4$DateTime2, TwoDays4$Sub_metering_2, type = "l", xlab = "", ylab = "", col = "red") ## adds submetering 2 in red to graph
lines(TwoDays4$DateTime2, TwoDays4$Sub_metering_3, type = "l", xlab = "", ylab = "", col = "blue") ## adds submetering3 in blue to graph
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), lwd = c(2, 2, 2), col = c("black", "red","blue"), xjust = 1)
plot(TwoDays4$DateTime2, TwoDays$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power")
dev.off()
