## This script plots Global Active Power vs. measurement time for the period 01-FEB-2007 through 02-FEB-2007

## Load useful libraries.
library("data.table", lib.loc="~/R/win-library/3.3")
library("DBI", lib.loc="~/R/win-library/3.3")
library("dplyr", lib.loc="~/R/win-library/3.3")
library("readr", lib.loc="~/R/win-library/3.3")
library("lubridate", lib.loc="~/R/win-library/3.3")

## Download and unzip data.
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              "household_power_consumption.zip")
unzip("household_power_consumption.zip", "household_power_consumption.txt")

## Read data.
pwrdt <- fread("household_power_consumption.txt", na.strings = "?")

## Find dates of interest and reconstruct power data table
dt1FEB <- subset(pwrdt, grepl("^1/2/2007", pwrdt$Date))
dt2FEB <- subset(pwrdt, grepl("^2/2/2007", pwrdt$Date))
pwrdt <- rbind(dt1FEB, dt2FEB)

## Convert Date and Time columns to a datetime column with POSIXct format
pwrdt <- mutate(pwrdt, datetime = paste(Date, Time))
pwrdt <- mutate(pwrdt, datetime = dmy_hms(datetime))

## Make plot.
png("plot4.png")  # defaults to correct size, 480 X 480 px
par(mfcol = c(2,2))  # set up for four plots

## Make Global Active Power plot (plot2)
plot(pwrdt$datetime, pwrdt$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Make Energy sub metering plot (plot 3)
plot(pwrdt$datetime, pwrdt$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "")
lines(pwrdt$datetime, pwrdt$Sub_metering_2, col = "red")
lines(pwrdt$datetime, pwrdt$Sub_metering_3, col = "blue")
title(xlab = "", ylab = "Energy sub metering")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1), bty = "n")

## Make Voltage plot
with(pwrdt, plot(datetime, Voltage, type = "l"))

## Make Global_reactive_power plot
with(pwrdt, plot(datetime, Global_reactive_power, type = "l"))
dev.off()         # remember to close device!
