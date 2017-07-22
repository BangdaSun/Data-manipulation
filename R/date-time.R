################################
### Chapter 4. Date and Time ###
################################

### Get current date and time
Sys.Date()
Sys.time()

### 4.1 as.Date (Date only)
#   format = ...
#   default: year with 4 digits - month - day with - or /

as.Date("2017-06-05")
as.Date("6/5/2017", format = "%m/%d/%Y")  # format = ... means the form of character we input
as.Date("June 5, 2017", format = "%B %d, %Y")
as.Date("5JUN17", format = "%d%b%y")

#   date object is number of days from 1970/01/01
as.numeric(as.Date("2017-06-05"))
as.numeric(as.Date("2014-12-10"))

day = 17322
class(day) = "Date"
day

weekdays(day)

### 4.2 chron package
#   format code:
# +-------+----------------------+
# +   m   +  month (decimals)    +
# +   d   +   day (decimals)     +
# +   y   +  year (4 digits)     +
# +  mon  +  month (3 letters)   +
# + month +  month (total name)  +
# +-------+----------------------+
# +   h   +        hours         +
# +   m   +        minutes       +
# +   s   +        seconds       +
# +-------+----------------------+

#   if the data has date and time, we need split them first
library(chron)
dtimes = "2017-06-05 21:28:40"
dtparts = strsplit(dtimes, split = " ")
dtparts
chron(dates = dtparts[[1]][1], times = dtparts[[1]][2],
      format = c("y-m-d", "h:m:s")) # mon, month

### 4.3 POSIX class
# POSIX usually for UNIX

#  POSIXct: use second from 1970/01/01 (default in R)
#  POSIXlt: second, minute, hour, day, month, year as a list
#  they also work for different time zone

#  valid input for POSIXt:
#  2017/6/5
#  2017-06-05 21:37
#  2017/6/5 21:37:55
dts = c("2005-10-21 18:47:22 EDT",
        "2005-10-24 16:39:58 EDT",
        "2005-10-28 07:30:05 EDT")
as.POSIXct(dts)
as.POSIXlt(dts)

#  input seconds since 2017-01-01
dts <- c(1127056501, 1104295502)
class(dts) <- c('POSIXt', 'POSIXct')
# or
structure(dts, class = c('POSIXt', 'POSIXct'))

# strptime(), strftime() for input and output date data
# format code can refer to page 64 of Phil Spector, Data Manipulation with R

mydate <- strptime('16/Oct/2017:09:01:35', 
                  format = '%d/%b/%Y:%H:%M:%S')
# use tz = .. specify time zone

# one more way to create POSIX
ISOdate(2017, 7, 21, 20, 44, 50, tz = "...")

### 4.4

### 4.5 Time interval
b1 = as.Date("2017-06-05")
b2 = as.Date("2016-09-06")
b1 - b2

#   by different time unit
difftime(b1, b2, units = "weeks")
difftime(b1, b2, units = "mins")

### 4.6 Time series
#   generate time index sequence
seq(as.Date("2016-09-06"), by = "days", length = 10)
seq(as.Date("2016-09-06"), by = "weeks", length = 20)

#   get date one week ago
d = as.Date('2017-06-29')
seq(d - 7, d - 1, by = 'weeks')

#   get date one week later
seq(d, by = 'weeks', length = 2)[2]
