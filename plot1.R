
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file1 <- download.file(fileUrl, destfile = "./file1.zip")
data1 <- read.csv(unz("file1.zip", "household_power_consumption.txt"), sep = ";")
unlink ("./file1.zip")

#We convert column Date into a date format
data1$Date2 <- as.Date(data1$Date, "%d/%m/%Y")

#We only select rows for which the date is either 2007-02-01 or 2007-02-02
data2 <- subset(data1, Date2 >= as.Date("2007-02-01") & Date2 <= as.Date("2007-02-02"))
data2$Global_active_power2 <- as.numeric(as.character(data2$Global_active_power))


#we create the plot
png(file = "plot1.png")
hist(data2$Global_active_power2, 
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     cex.main = 1.2,
     cex.lab = 1,
     cex.axis = 1
     )

dev.off()
