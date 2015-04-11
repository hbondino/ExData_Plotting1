## Unzipping the file
unzip("exdata_data_household_power_consumption.zip")

## Loading the data
data<-read.table("household_power_consumption.txt",header=TRUE,sep=";")

## Formatting date
data$Date<-as.Date(data$Date,"%d/%m/%Y")

## Subsetting
dates<-data$Date=="2007-02-01"|data$Date=="2007-02-02"
smalldata<-data[dates,]

## Converting to number
smalldata$Global_active_power<-as.numeric(as.character(smalldata$Global_active_power))

## Making plot
png(filename="plot1.png")
hist(smalldata$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()
