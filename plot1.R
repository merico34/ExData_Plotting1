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

## Plot1

png(file = "plot1.png", width = 480, height = 480, bg = "transparent")
with(consumption_partial,
     hist(Global_active_power, col='red', main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
)
dev.off()

