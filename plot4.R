#Exploratory Data Analysis
#Course Project 1: Electric power consumption

setwd("C:/Users/HomeUser/Documents/Exploratory Data Analysis/ExData_Plotting1")

## Reading File

###Read just a bunch of the file to retrieve variables classes
initial = read.table("household_power_consumption.txt", header = T, sep=";",nrows=100)
head(initial)
classes = sapply(initial,class)
classes

classes["Date"]="character" #correction in order to speed-up read.table loading

system.time(
  consumption <- read.table("household_power_consumption.txt", header = T, sep=";"
                            , na.strings = "?"
                            , comment.char = ""
                            , colClasses = classes
  )
)

## Tranform into tidy data

### Format Dates
head(consumption)
consumption$Date = as.Date(consumption$Date, "%d/%m/%Y")
head(consumption)

### Keep only 2 days of the data
consumption_partial <- consumption[consumption$Date == '2007-02-01' | consumption$Date == '2007-02-02' ,]
head(consumption_partial)
tail(consumption_partial)

### Construct a full date variable with date and time
consumption_partial$FullDate = strptime(paste(consumption_partial$Date, consumption_partial$Time),
                                        "%Y-%m-%d %H:%M:%S")
head(consumption_partial)

## Plot4
Sys.setlocale(category = "LC_ALL", locale = "C")

png(file = "plot4.png", width = 480, height = 480, bg = "transparent")
par(mfcol = c(2,2))

#Top-Left Plot
with(consumption_partial,
     plot(FullDate, Global_active_power, type = "l", 
          xlab = "", ylab = "Global Active Power")
)

#Bottom-Left Plot
with(consumption_partial,
     plot(FullDate, Sub_metering_1, type = "l"
          ,xlab = "", ylab = "Energy sub metering"
     )
)
with(consumption_partial,
     lines(FullDate, Sub_metering_2, type = "l", col = "red"
     )
)
with(consumption_partial,
     lines(FullDate, Sub_metering_3, type = "l", col = "blue"
     )
)
legend("topright", bty = "n", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Top-Right Plot
with(consumption_partial,
     plot(FullDate, Voltage, type = "l",
          ,xlab = "datetime", ylab = "Voltage"
     )
)

#Bottom-Right Plot
with(consumption_partial,
     plot(FullDate, Global_reactive_power, type = "l",
          ,xlab = "datetime", ylab = "Global_reactive_power"
     )
)

dev.off()
Sys.setlocale(category = "LC_ALL", locale = "")