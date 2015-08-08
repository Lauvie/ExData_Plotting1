
Sys.setlocale("LC_TIME", "en_US.UTF-8")


fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file1 <- download.file(fileUrl, destfile = "./file1.zip")
data1 <- read.csv(unz("file1.zip", "household_power_consumption.txt"), sep = ";")
unlink ("./file1.zip")

#We convert column Date into a date format
data1$Date2 <- as.Date(data1$Date, "%d/%m/%Y")

#We only select rows for which the date is either 2007-02-01 or 2007-02-02
data2 <- subset(data1, Date2 >= as.Date("2007-02-01") & Date2 <= as.Date("2007-02-02"))
data2$Sub_metering_12 <- as.numeric(as.character(data2$Sub_metering_1))
data2$Sub_metering_22 <- as.numeric(as.character(data2$Sub_metering_2))
data2$Sub_metering_32 <- as.numeric(as.character(data2$Sub_metering_3))

#We create a single variable with time dans date
data2$Date3 <- paste(data2$Date, data2$Time)
data2$Date4 <- strptime(data2$Date3, format = "%d/%m/%Y %H:%M:%S")

#we create the plot

png(file = "plot3.png")
with(data2, {
        plot(Date4,Sub_metering_12, 
                 type="l",
                 xlab = "",
                 ylab = "Energy sub metering",
                 col = "black"
                 )
        axis(side=1, at=seq(0, 30, by=10))
        par(new=T)
        plot(Date4,Sub_metering_22, 
             type="l",
             xlab = "",
             ylab = "",
             col = "red",
             ylim = c(0,30),
             xaxt='n', 
             yaxt = 'n'
             )
        par(new=T)
        plot(Date4,Sub_metering_32, 
             type="l",
             xlab = "",
             ylab = "",
             col = "blue",
             ylim = c(0,30),
             xaxt='n', 
             yaxt = 'n'
             ) 
        legend ("topright",
                lwd = 1,
                col = c("black", "red", "blue"),
                legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                cex = 1
                )
})
dev.off()

