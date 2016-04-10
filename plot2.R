if(!file.exists("./data")) {dir.create("./data")}
ProjectUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(ProjectUrl, destfile = "./data.zip", method = "curl")
unzip("data.zip", exdir = "data")
PowerData <- read.table("./data/household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE, header = TRUE, na = "?")
TwoDays <- PowerData[PowerData$Date %in% c("1/2/2007", "2/2/2007"), ] ##subset data to the 2 days needed
TwoDays$DateTime <- paste(TwoDays$Date, TwoDays$Time, sep = " ") ## combine Date and Time into a new combined variable DateTime
library(lubridate)
DateTime2 <- dmy_hms(TwoDays$DateTime) ## make this new column a POSIXct class
TwoDays4 <- cbind(TwoDays, DateTime2) ## asdd this new column to dataset
plot2 <- with(TwoDays4,plot.default(DateTime2, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")) 
dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px") ##copy code to png graphing device
dev.off() ##turn off png device and save file to working directory