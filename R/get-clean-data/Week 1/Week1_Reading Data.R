# Week1_Reading data Quiz

# 1.The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
#
# and load the data into R. The code book, describing the variable names is here:
#  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
#
# How many properties are worth $1,000,000 or more?
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(
  fileUrl, destfile = "C://Users//Bangda//Desktop//Get and Cleaning Data in R//Week 1//getdata.csv", 
  method = "wininet")
getdata <- read.csv("C://Users//Bangda//Desktop//Get and Cleaning Data in R//Week 1//getdata.csv", 
                    header = TRUE)
sum(getdata$VAL == 24, na.rm = TRUE)

# 2.Use the data you loaded from Question 1. Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate?
## 

# 3. why it will exist error used the download data (without wb arg), but good used local data
# Download the Excel spreadsheet on Natural Gas Aquisition Program here:
#  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx
#
# Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
library(xlsx)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "C://Users//Bangda//Desktop//Get and Cleaning Data in R//Week 1//getdata%2Fdata%2FDATA.gov_NGAP.xlsx", mode = "wb")
rowIndex <- 18:23
colIndex <- 7:15
dat <- read.xlsx("C://Users//Bangda//Desktop//Get and Cleaning Data in R//Week 1//getdata%2Fdata%2FDATA.gov_NGAP.xlsx", sheetIndex = 1, rowIndex = rowIndex, colIndex = colIndex)
sum(dat$Zip*dat$Ext,na.rm=T)

# 4.  Read the XML data on Baltimore restaurants from here:
#
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml
#
# How many restaurants have zipcode 21231?
library(XML)
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml" # remove the 's', only support http
doc <- xmlTreeParse(fileUrl, useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)
names(rootNode)
rootNode[[1]][[1]]
sum(xpathSApply(rootNode, "//zipcode", xmlValue) == 21231)

# 5. The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
#
# using the fread() command load the data into an R object
#
#

# 1
# DT
# The following are ways to calculate the average value of the variable
# 
#1
# pwgtp15
# broken down by sex. Using the data.table package, which will deliver the fastest user time? 
library(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "getdata%2Fdata%2Fss06pid.csv", method = "wininet")
getdata <- read.csv("getdata%2Fdata%2Fss06pid.csv", header = TRUE)
DT = fread(input = "getdata%2Fdata%2Fss06pid.csv")

# time consuming comparison
ptm <- proc.time()
tapply(DT$pwgtp15, DT$SEX, mean)
proc.time() - ptm

ptm <- proc.time()
DT[,mean(pwgtp15),by=SEX]
proc.time() - ptm

ptm <- proc.time()
sapply(split(DT$pwgtp15,DT$SEX),mean)
proc.time() - ptm

ptm <- proc.time()
mean(DT$pwgtp15,by=DT$SEX)
proc.time() - ptm

ptm <- proc.time()
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
proc.time() - ptm

ptm <- proc.time()
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
proc.time() - ptm