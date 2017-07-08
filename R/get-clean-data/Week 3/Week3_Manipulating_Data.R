# Week3_Manipulating data Quiz
setwd("C://Users//Bangda//Dropbox//Get and Cleaning data in R//Week 3")
# 1.The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# Create a logical vector that identifies the households on greater than 10 acres who sold more 
# than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. 
# Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.
# which(agricultureLogical)
# What are the first 3 values that result?

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "microdata.csv", method = "wininet")
microdata <- read.csv("microdata.csv", header = TRUE)
names(microdata)
microdata$agricultureLogical <- (microdata$ACR == 3 & microdata$AGS == 6)
which(microdata$agricultureLogical)


# 2. Using the jpeg package read in the following picture of your instructor into R
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg
# Use the parameter native=TRUE.
# What are the 30th and 80th quantiles of the resulting data? 
# (some Linux systems may produce an answer 638 different for the 30th quantile)

fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl2, destfile = "jeff.jpg", method = "wininet")
install.packages("jpeg")
library(jpeg)
jeff <- readJPEG("getdata%2Fjeff.jpg", native = TRUE)
quantile(jeff, probs = c(.3, .8))

# 3. Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode.
# How many of the IDs match? Sort the data frame in descending order by GDP rank 
# (so United States is last). 
# What is the 13th country in the resulting data frame?
# Original data sources:
# http://data.worldbank.org/data-catalog/GDP-ranking-table
# http://data.worldbank.org/data-catalog/ed-stats

# still problems exist here....

library(dplyr)
fileUrl3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl3, destfile = "FGDP.csv", method = "wininet")
FGDP <- read.csv("FGDP.csv", header = TRUE)
fileUrl4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl4, destfile = "Edudata.csv", method = "wininet")
Edudata <- read.csv("Edudata.csv", header = TRUE)
head(FGDP)
FGDP <- FGDP[-4:-1, ]
FGDP <- FGDP[1:190, ]
FGDP <- rename(FGDP, CountryCode = X, Rank = Gross.domestic.product.2012)
class(FGDP$Rank)
match <- merge(FGDP, Edudata, id = c("CountryCode"))
FGDP$Rank <- as.numeric(as.character(FGDP$Rank))
FGDP <- arrange(FGDP, desc(Rank))
FGDP[13, ]

# 4.What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
class(match$Rank)
match$Rank <- as.numeric(as.character(match$Rank))
tapply(match$Rank, match$Income.Group, mean)

# 5. Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries
# are Lower middle income but among the 38 nations with highest GDP?
match$RankGroups <- cut(match$Rank, breaks = quantile(match$Rank, probs = seq(0, 1, .2)))
class(match$RankGroups)
levels(match$RankGroups)
table(match$Income.Group, match$RankGroups)
