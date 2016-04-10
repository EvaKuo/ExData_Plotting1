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
png(file = "plot3.png", width = 480, height = 480, units = "px") ## opens png graphics device
plot3 <- plot(TwoDays4$DateTime2, TwoDays4$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
## makes a graph of submetering1 in black
lines(TwoDays4$DateTime2, TwoDays4$Sub_metering_2, type = "l", xlab = "", ylab = "", col = "red") ## adds submetering 2 in red to graph
lines(TwoDays4$DateTime2, TwoDays4$Sub_metering_3, type = "l", xlab = "", ylab = "", col = "blue") ## adds submetering3 in blue to graph
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), lwd = c(2, 2, 2), col = c("black", "red","blue"), xjust = 1)
## adds legend
dev.off() ## turns png device off and saves file to working directory