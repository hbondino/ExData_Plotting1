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

## Converting to number (There are no NAs in the subset)
smalldata$Global_active_power<-as.numeric(as.character(smalldata$Global_active_power))

Sys.setlocale("LC_TIME", "C") ## Sorry, otherwise the plot is in spanish in my computer

## Making plot
png(filename="plot2.png")
plot(smalldata$FullTime,smalldata$Global_active_power,ylab="Global Active Power (kilowatts)",xlab="",type ="n")
lines(smalldata$FullTime,smalldata$Global_active_power)
dev.off()
