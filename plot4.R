par(mfrow=c(2,2))
## add the first graph
with(powergraphData,plot(combinedtime,Global_active_power,type="l",xlab="",ylab="Global Active Power"))
with(powergraphData,plot(combinedtime,Voltage,type="l",xlab="datetime",ylab="Voltage"))
with(powergraphData,plot(combinedtime,Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering"))
with(powergraphData,lines(combinedtime,Sub_metering_3,type="l",col="blue"))
with(powergraphData,lines(combinedtime,Sub_metering_2,type="l",col="red"))
## Need to override my combined time label with the datetime label in the sample
with(powergraphData,plot(combinedtime,Global_reactive_power,type="l",xlab="datetime"))