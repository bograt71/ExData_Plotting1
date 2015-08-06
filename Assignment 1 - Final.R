## Exploratory Data Analysis Course - Assignment 1.
## Brendan Moran
##
## Instructions:        All the code for the assignment is contained in a single file and is divided into a number of sections
##                      Part 1: download and unzip the data
##                      Part 2: reading in the data (prepare function, read in data, subset data, created combined datatime field)
##                      Part 3: generate the plots
##                      Part 4: create PNG files


## ------------------------------------------------------------------------------------------------- 
## -------------------- Part 1: download and unzip the data ----------------------------------------
## -------------------------------------------------------------------------------------------------
## Create a custom function to parse the data field correctly. 
## Reference: http://stackoverflow.com/questions/13022299/specify-date-format-for-colclasses-argument-in-read-table-read-csv
library(lubridate)
setClass('myDate')
setAs("character","myDate", function(from) dmy(from))

## Get data from repository
## Set the working directory for your local machine for testing purposes
setwd("./")
## Create a sub-directory to store the data and graphs
if (!file.exists("./data")) {dir.create("./data")}
fileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
## Download the data
download.file(fileURL,destfile="./data/household_power_consumption.zip",method="curl")
## Unzip the file
unzip("./data/household_power_consumption.zip",exdir="./data")

## -------------------------------------------------------------------------------------------------
## -------------------- Part 2: reading in the data (prepare function, read in      ----------------
## --------------------         data, subset data, created combined datatime field) ---------------- 
## -------------------------------------------------------------------------------------------------

## Load full data set
## load time as a character field
powerData<-read.table("./data/household_power_consumption.txt",colClasses=c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),header=TRUE,sep=";", na.strings="?")

## Filter the data to the two days required
powergraphData<-powerData[which(powerData$Date>='2007-02-01' & powerData$Date<='2007-02-02'),]

## Create a combined timestamp field to which combines the Date & Time fields.
powergraphData<-within(powergraphData,{combinedtime=as.POSIXct(paste(Date,Time))})

## ------------------------------------------------------------------------------------------------- 
## -------------------- Part 3: generate the plots -------------------------------------------------
## -------------------------------------------------------------------------------------------------

## Set plot lattice back to default, one plot per device.
par(mfrow=c(1,1))

## Plot 1 
with(powergraphData,hist(Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)"))


## Plot 2 
with(powergraphData,plot(combinedtime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))

## Plot 3 
## Add in the labels first else they'll be overwritten
with(powergraphData,plot(combinedtime,Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering"))
with(powergraphData,lines(combinedtime,Sub_metering_3,type="l",col="blue"))
with(powergraphData,lines(combinedtime,Sub_metering_2,type="l",col="red"))
## Add in the legends last. Ref: http://www.r-bloggers.com/adding-a-legend-to-a-plot/
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","blue","red"))

## Plot 4 
## set up the 2 rows and 2 columns lattice
par(mfrow=c(2,2))
## add the first graph
with(powergraphData,plot(combinedtime,Global_active_power,type="l",xlab="",ylab="Global Active Power"))
with(powergraphData,plot(combinedtime,Voltage,type="l",xlab="datetime",ylab="Voltage"))
with(powergraphData,plot(combinedtime,Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering"))
with(powergraphData,lines(combinedtime,Sub_metering_3,type="l",col="blue"))
with(powergraphData,lines(combinedtime,Sub_metering_2,type="l",col="red"))
## Need to override my combined time label with the datetime label in the sample
with(powergraphData,plot(combinedtime,Global_reactive_power,type="l",xlab="datetime"))

## ------------------------------------------------------------------------------------------------- 
## -------------------- Part 4: create PNG files ---------------------------------------------------
## -------------------------------------------------------------------------------------------------

## Set plot lattice back to default, one plot per device.
par(mfrow=c(1,1))

## Plot 1 
## Open up graphics file
png(filename="plot1.png",width=480, height=480)
## Create the plot
with(powergraphData,hist(Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)"))

## Close the plot device
dev.off()


## Plot 2 - correct
## Open up graphics file
png(filename="plot2.png",width=480, height=480)
with(powergraphData,plot(combinedtime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))
## Close the plot device
dev.off()

## Plot 3 - almost. Use lines() to add additional lines
## Open up graphics file
png(filename="plot3.png",width=480, height=480)
## Add in the labels first else they'll be overwritten
with(powergraphData,plot(combinedtime,Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering"))
with(powergraphData,lines(combinedtime,Sub_metering_3,type="l",col="blue"))
with(powergraphData,lines(combinedtime,Sub_metering_2,type="l",col="red"))
## Add in the legends last. Ref: http://www.r-bloggers.com/adding-a-legend-to-a-plot/
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","blue","red"))
## Close the plot device
dev.off()

## Plot 4 - 
## Open up graphics file
png(filename="plot4.png",width=480, height=480)
## set up the 2 rows and 2 columns lattice
par(mfrow=c(2,2))
## add the first graph
with(powergraphData,plot(combinedtime,Global_active_power,type="l",xlab="",ylab="Global Active Power"))
with(powergraphData,plot(combinedtime,Voltage,type="l",xlab="datetime",ylab="Voltage"))
with(powergraphData,plot(combinedtime,Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering"))
with(powergraphData,lines(combinedtime,Sub_metering_3,type="l",col="blue"))
with(powergraphData,lines(combinedtime,Sub_metering_2,type="l",col="red"))
## Need to override my combined time label with the datetime label in the sample
with(powergraphData,plot(combinedtime,Global_reactive_power,type="l",xlab="datetime"))
## Close the plot device
dev.off()
