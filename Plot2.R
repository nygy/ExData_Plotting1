## Read the entire dataset from the working directory
data_full <- read.csv("household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", 
                      nrows=2075259, check.names=FALSE, stringsAsFactors=FALSE, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subset the required part
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

## Convert dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Setup global graphical parameters
par(mfrow = c(1, 1), mar = c(4, 4, 4, 4), oma = c(0,0,0,0), cex=0.7)

## Construct Plot2
plot(data$Global_active_power ~ data$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
box()

## Save to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()