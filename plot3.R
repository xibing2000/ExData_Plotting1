# Load the necessary library
library(data.table)
library(dplyr)
#Read the whole data file, and then subsetting the data to 2007-02-01~02
power_data<-read.table("household_power_consumption.txt", header = TRUE, sep =";", na.strings = "?", dec = ".", stringsAsFactors = FALSE)
sub_powerdata<-subset(power_data, power_data$Date %in% c("1/2/2007","2/2/2007"))

#Convert Global Active Power column to numberic value
globalActivePower<-as.numeric(sub_powerdata$Global_active_power)
# Convert the data and time format
date_time<- strptime(paste(sub_powerdata$Date, sub_powerdata$Time, sep=" "),"%d/%m/%Y %H:%M:%S" )

# Convert sub_metering_1 to 3 data
submetering1<-as.numeric(sub_powerdata$Sub_metering_1)
submetering2<-as.numeric(sub_powerdata$Sub_metering_2)
submetering3<-as.numeric(sub_powerdata$Sub_metering_3)

# create the graph file and set the dimension
png("plot3.png", width=480, height=480)

#Plot the data in line style for these three types of data
plot(date_time, submetering1, type="l", xlab="", ylab="Energy sub  metering", col="black")
lines(date_time, submetering2, type="l", col="red")
lines(date_time, submetering3, type="l", col="blue")
# Put legends to the plot
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty = 1, lwd = 2,
       col=c("black", "red", "blue"))
# Close the graphic device
dev.off()










dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()