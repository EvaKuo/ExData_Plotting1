if(!file.exists("./data")) {dir.create("./data")}
ProjectUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(ProjectUrl, 
      destfile = "./data.zip", method = "curl")
unzip("data.zip", exdir = "data") ## download and unzip data
PowerData <- read.table("./data/household_power_consumption.txt", 
       sep = ";", stringsAsFactors = FALSE, header = TRUE, na = "?")
TwoDays <- PowerData[PowerData$Date %in% c("1/2/2007", "2/2/2007"), ] ##subsets data to the 2 days needed
png(file = "plot1.png", width = 480, height = 480, units = "px") ## opens png graphics device
plot1 <- hist(TwoDays$Global_active_power, col = "red", 
      xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.off() ## turn off png device and save file to working directory
