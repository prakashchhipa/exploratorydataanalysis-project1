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
powerdata$Date = as.Date(powerdata$Date, format="%d/%m/%Y")
filterStartDate = as.Date("01/02/2007", format="%d/%m/%Y")
filterEndDate = as.Date("02/02/2007", format="%d/%m/%Y")
powerdata = powerdata[powerdata$Date >= filterStartDate & powerdata$Date <= filterEndDate, ]

## dataset size after subsetting 
dim(powerdata) ##2880    9

##Now dataset ca be used for plotting as per project requirement
## plot1
##Define graphic device
png(filename="plot1.png", width=480, height=480)
## creation of plot using hist funtion
hist(powerdata$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")
## close device as it is very important.
dev.off()

