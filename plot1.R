plot1 <- function(){
    #Read in the February data
    df <- read.table("/Users/MiniMe/Coursera/ExploratoryDataAnalysis/Project1/feb_household_power_consumption.txt", sep=";",header=TRUE,stringsAsFactors=FALSE)

    #Only use the rows without missing data, which is indicated with '?', rather
    #than NA. Convert the Global active power data to character first.
    df$Global<- as.character(df$Global_active_power)
    subdf <- subset(df, df$Global_active_power != '?')
    gapower <- (df$Global_active_power)
    png(filename="plot1.png", width=480, height=480, bg="white")
    hist(as.numeric(gapower),xlab="Global Active Power (kilowatts)", ylab="Frequency",main="Global Active Power",col="red")

    #IMPORTANT, close the device!
    dev.off()
}
