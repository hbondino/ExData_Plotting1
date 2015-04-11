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
smalldata$Sub_metering_1<-as.numeric(as.character(smalldata$Sub_metering_1))
smalldata$Sub_metering_2<-as.numeric(as.character(smalldata$Sub_metering_2))

Sys.setlocale("LC_TIME", "C") ## Sorry, otherwise the plot is in spanish in my computer

## Making plot
png(filename="plot3.png")
plot(smalldata$FullTime,smalldata$Sub_metering_1,ylab="Energy sub metering",xlab="",type ="n")
lines(smalldata$FullTime,smalldata$Sub_metering_1)
lines(smalldata$FullTime,smalldata$Sub_metering_2,col="red")
lines(smalldata$FullTime,smalldata$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1, col=c("black","red","blue"))
dev.off()





