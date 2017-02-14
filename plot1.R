## This script plots a histogram of Global Active Power for the period 01-FEB-2007 through 02-FEB-2007

## Load useful libraries.
library("data.table", lib.loc="~/R/win-library/3.3")
library("DBI", lib.loc="~/R/win-library/3.3")
library("dplyr", lib.loc="~/R/win-library/3.3")
library("readr", lib.loc="~/R/win-library/3.3")

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

## Make plot.
png("plot1.png")  # defaults to correct size, 480 X 480 px
hist(pwrdt$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()         # remember to close device!
