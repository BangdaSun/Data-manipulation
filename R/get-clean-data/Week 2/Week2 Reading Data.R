# Week2_Reading data Quiz
# 1. Register an application with the Github API here https://github.com/settings/applications. 
# Access the API to get information on your instructors repositories 
# (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). 
# Use this data to find the time that the datasharing repo was created. What time was it created?



# 2. The sqldf package allows for execution of SQL commands on R data frames. 
# We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL.
# Download the American Community Survey data and load it into an R object called acs
library(RMySQL)
library(sqldf)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "C://Users//Bangda//Desktop//Get and Cleaning Data in R//Week 2//getdata.csv")
acs <- read.csv("C://Users//Bangda//Desktop//Get and Cleaning Data in R//Week 2//getdata.csv", 
                header = TRUE)
sqldf("select pwgtp1 from acs where AGEP < 50")


# 3. Using the same data frame you created in the previous problem,
# what is the equivalent function to unique(acs$AGEP)
unique(acs$AGEP)
sqldf("select distinct AGEP from acs")

# 4. How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
Url <- "http://biostat.jhsph.edu/~jleek/contact.html"
page <- readLines(Url)
length(page)
nchar(page[10])
nchar(page[20])
nchar(page[30])
nchar(page[100])

# 5. Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
Url <- url('http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for')
data <- readLines(Url)
close(Url)
getdata <- '[0-9]{2}[A-Z]{3}[0-9]{4}'
data <- grep(data, pattern = getdata, value = TRUE)
nchar(data[1])
newdata <- rep(NA,length(data))
for (i in 1:length(data)){
  newdata[i] <- substr(data[i], start = 29, stop = 32)
}
newdata <- as.numeric(newdata)
sum(newdata)
