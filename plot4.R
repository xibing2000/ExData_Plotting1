# Load the necessary library
library(data.table)
library(dplyr)
#Read the whole data file, and then subsetting the data to 2007-02-01~02
power_data<-read.table("household_power_consumption.txt", header = TRUE, sep =";", na.strings = "?", dec = ".", stringsAsFactors = FALSE)
sub_powerdata<-subset(power_data, power_data$Date %in% c("1/2/2007","2/2/2007"))

#Convert Global Active Power,reactive power,voltage columns to numberic value
global_active_power<-as.numeric(sub_powerdata$Global_active_power)
global_reactiveP_power<-as.numeric(sub_powerdata$Global_reactive_power)
voltage<-as.numeric(sub_powerdata$Voltage)

# Convert the data and time format
date_time<- strptime(paste(sub_powerdata$Date, sub_powerdata$Time, sep=" "),"%d/%m/%Y %H:%M:%S" )

# Convert sub_metering_1 to 3 data
submetering1<-as.numeric(sub_powerdata$Sub_metering_1)
submetering2<-as.numeric(sub_powerdata$Sub_metering_2)
submetering3<-as.numeric(sub_powerdata$Sub_metering_3)

# create graphic device and set the parameters for par function
png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))

# top-left, top-right, bottom-left and bottom-right plots
plot(date_time, global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(date_time, voltage, type="l", xlab="datetime", ylab="Voltage")
plot(date_time, submetering1, type="l", xlab="", ylab="Energy sub  metering", col="black")
lines(date_time, submetering2, type="l", col="red")
lines(date_time, submetering3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty = 1, lwd = 2,
       col=c("black", "red", "blue"),bty="n")
plot(date_time, global_reactiveP_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# Close the graphic device
dev.off()

