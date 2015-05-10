plot4<-function(){
    #Read in the February data
    library(date)
    library(lubridate)
    df <- read.table("/Users/MiniMe/Coursera/ExploratoryDataAnalysis/Project1/feb_household_power_consumption.txt", sep=";",header=TRUE,na.strings="?",stringsAsFactors=FALSE)

    #Only use the rows without missing data, which is indicated with '?', rather
    #than NA. Convert the Global active power data to character first.
    df$Global<- as.character(df$Global_active_power)
    subdf <- subset(df, df$Global_active_power != '?')
    #Combine the date and time to get the complete date...
    as.Date(subdf$Date,format="%d/%m%y")
    Sys.timezone()
    dateTime <- (paste(subdf$Date, subdf$Time,sep=" "))
    subdf$DateTime<-dmy_hms(dateTime,tz=Sys.timezone())
    #Open the device
    png(filename="plot4.png", width=480, height=480, bg="white")

    #Generate panel dimension: 2 rows X 2 columns
    par(mfrow=c(2,2))

    #Global Active Power
    plot(subdf$DateTime,subdf$Global_active_power,type="l",xlab="",ylab="Global active power (kilowatts)",col="darkblue")


    #Voltage
    plot(subdf$DateTime,subdf$Voltage,type="l",xlab="datetime",ylab="Voltage",col="black")

    #Energy sub metering
    #Get the maximum xrange
    x1range <- range(subdf$Sub_metering_1)
    x2range <- range(subdf$Sub_metering_2)
    x3range <- range(subdf$Sub_metering_3)
    x1<-diff(x1range)
    x2<-diff(x2range)
    x3<-diff(x3range)
    maxr <- max(x1,x2,x3)
    if( x1 == maxr){
        maxX<- x1range
    }else if (x2 == maxr){
        maxX <- x2range
    }else{
        maxX <-x3range
    }

    #Get the yrange
    yrange <- range(subdf$DateTime)

    #Line colors
    colors<-c("black","red","green")

    plot(yrange,maxX,type="n",xlab="",ylab="Energy sub metering")
    lines(subdf$DateTime,subdf$Sub_metering_1,col="black",type="l")
    lines(subdf$DateTime,subdf$Sub_metering_2,col="red",type="l")
    lines(subdf$DateTime,subdf$Sub_metering_3,col="green",type="l")

    #Line names
    group<-c("Sub_metering_1","Sub_metering_2","Sub_metering_3")

    #Line types=1, solid
    lt<-c(1,1,1)

    #add legend
    legend(x="topright",legend=group,lty=lt,col=colors)

    #Global reactive power
    plot(subdf$DateTime,subdf$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power",col="black")

    #Don't forget to close the device!!!
    dev.off()


}
