
Sys.setlocale("LC_TIME", "en_US.UTF-8")

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file1 <- download.file(fileUrl, destfile = "./file1.zip")
data1 <- read.csv(unz("file1.zip", "household_power_consumption.txt"), sep = ";")
unlink ("./file1.zip")

#We convert column Date into a date format
data1$Date2 <- as.Date(data1$Date, "%d/%m/%Y")

#We only select rows for which the date is either 2007-02-01 or 2007-02-02
data2 <- subset(data1, Date2 >= as.Date("2007-02-01") & Date2 <= as.Date("2007-02-02"))
data2$Global_active_power2 <- as.numeric(as.character(data2$Global_active_power))

#We create a single variable with time dans date
data2$Date3 <- paste(data2$Date, data2$Time)
data2$Date4 <- strptime(data2$Date3, format = "%d/%m/%Y %H:%M:%S")

#we create the plot
png(file = "plot2.png")
plot(data2$Date4,data2$Global_active_power2, 
     type="l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     cex.lab = 1,
     cex.axis = 1
     )
dev.off()
