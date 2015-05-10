plot2<-function(){
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
    png(filename="plot2.png", width=480, height=480, bg="white")
    plot(subdf$DateTime,subdf$Global_active_power,type="l",xlab="",ylab="Global active power (kilowatts)",col="darkblue")

    #Don't forget to close the device!!!
    dev.off()


}
