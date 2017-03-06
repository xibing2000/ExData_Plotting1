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

#Plot the data in line style
plot(date_time, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# Save the graph to the png file in the working directory. Then close the graphic device.
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()