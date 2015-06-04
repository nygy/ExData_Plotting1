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

## Construct Plot4
par(mfrow = c(2, 2), mar = c(4, 4, 4, 2), oma = c(0,0,0,0), cex=0.7)
with(data, {
  plot(Global_active_power ~ Datetime, type="l", ylab="Global Active Power", xlab="")
  plot(Voltage ~ Datetime, type="l", ylab="Voltage", xlab="datetime")
  plot(data$Sub_metering_1 ~ data$Datetime,type="l", col="black", ylab="Energy sub metering", xlab="")
    points(data$Sub_metering_2 ~ data$Datetime,type="l", col="red")
    points(data$Sub_metering_3 ~ data$Datetime,type="l", col="blue")
    legend("topright", lty=1, lwd=2, col = c("blacK", "red", "blue"), bty="n",
         legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  plot(Global_reactive_power ~ Datetime, type="l", ylab="Global_reactive_power", xlab="datetime")
})

## Save to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
