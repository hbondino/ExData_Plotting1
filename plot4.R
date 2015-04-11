## Unzipping the file
unzip("exdata_data_household_power_consumption.zip")

## Loading the data
data<-read.table("household_power_consumption.txt",header=TRUE,sep=";")

## Formatting date
data$Date<-as.Date(data$Date,"%d/%m/%Y")

## Subsetting
dates<-data$Date=="2007-02-01"|data$Date=="2007-02-02"
smalldata<-data[dates,]

## Merging time and date
smalldata$FullTime<-paste(smalldata$Date,smalldata$Time)
smalldata$FullTime<-strptime(smalldata$FullTime,"%Y-%m-%d %H:%M:%S")

## Converting to number (There are no NAs in the subsets)
smalldata$Global_active_power<-as.numeric(as.character(smalldata$Global_active_power))
smalldata$Sub_metering_1<-as.numeric(as.character(smalldata$Sub_metering_1))
smalldata$Sub_metering_2<-as.numeric(as.character(smalldata$Sub_metering_2))
smalldata$Global_reactive_power<-as.numeric(as.character(smalldata$Global_reactive_power))
smalldata$Voltage<-as.numeric(as.character(smalldata$Voltage))

Sys.setlocale("LC_TIME", "C") ## Sorry, otherwise the plot is in spanish in my computer

## Making plots
png(filename="plot4.png")

par(mfcol=c(2,2))
plot(smalldata$FullTime,smalldata$Global_active_power,ylab="Global Active Power",xlab="",type ="n")
lines(smalldata$FullTime,smalldata$Global_active_power)

plot(smalldata$FullTime,smalldata$Sub_metering_1,ylab="Energy sub metering",xlab="",type ="n")
lines(smalldata$FullTime,smalldata$Sub_metering_1)
lines(smalldata$FullTime,smalldata$Sub_metering_2,col="red")
lines(smalldata$FullTime,smalldata$Sub_metering_3,col="blue")
legend("topright",bty="n",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1, col=c("black","red","blue"))

plot(smalldata$FullTime,smalldata$Voltage,ylab="Voltage",xlab="datetime",type ="n")
lines(smalldata$FullTime,smalldata$Voltage)

plot(smalldata$FullTime,smalldata$Global_reactive_power,ylab="Global_reactive_power",xlab="datetime",type ="n")
lines(smalldata$FullTime,smalldata$Global_reactive_power)

dev.off()