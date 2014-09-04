## Download dataset in question.
file = "exdata_plotting1.zip"
if (!file.exists(file)) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                         destfile = filename,
                         method = "curl")
}
## Load dataset into memory from household_power_consumption.txt file while clean it ad format
powerdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   colClasses=c("character", "character", "numeric","numeric", 
                                "numeric", "numeric","numeric", "numeric", "numeric"), 
                   na = "?")

## format date column and subsetting of dataset according to specified date in question
## combining data andtime
timeStamp <- paste(powerdata$Date, powerdata$Time)
powerdata$DateTime <- strptime(timeStamp, format="%d/%m/%Y %H:%M:%S")
filterStartDateTime = strptime("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S")
filterEndDateTime = strptime("02/02/2007 23:59:59", format="%d/%m/%Y %H:%M:%S")
powerdata = powerdata[powerdata$DateTime >= filterStartDateTime & powerdata$DateTime <= filterEndDateTime, ]
## dataset size after subsetting 
dim(powerdata) ##2880    10
##Now dataset can be used for plotting as per project requirement

## plot3
##Define graphic device
png(filename="plot3.png", width=480, height=480)
## creation of plot using plot funtion
plot(powerdata$DateTime, powerdata$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering")
lines(powerdata$DateTime, powerdata$Sub_metering_2, col="red")
lines(powerdata$DateTime, powerdata$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=par("lwd"))
## close device as it is very important.
dev.off()

