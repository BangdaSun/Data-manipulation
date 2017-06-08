#########################################
### Data Manipulation in R with dplyr ###
#########################################

# 
#   Source: DataCamp
#

### 1. Introduction
# Load the dplyr package and data set: hflights
library(dplyr)
library(hflights)

# Call both head() and summary() on hflights
head(hflights)
summary(hflights)

# Convert the hflights data.frame into a hflights tbl
hflights = tbl_df(hflights)

# Display the hflights tbl
hflights

# Create the object carriers
carriers = hflights$UniqueCarrier

# Change labels in data
lut <- c("AA" = "American", "AS" = "Alaska", "B6" = "JetBlue", "CO" = "Continental", 
         "DL" = "Delta", "OO" = "SkyWest", "UA" = "United", "US" = "US_Airways", 
         "WN" = "Southwest", "EV" = "Atlantic_Southeast", "F9" = "Frontier", 
         "FL" = "AirTran", "MQ" = "American_Eagle", "XE" = "ExpressJet", "YV" = "Mesa")

# Add the Carrier column to hflights
hflights$Carrier <- lut[hflights$UniqueCarrier]

# Glimpse at hflights: alternative way to view tbl_df data
glimpse(hflights)

# The lookup table
lut <- c("A" = "carrier", "B" = "weather", "C" = "FFA", "D" = "security", "E" = "not cancelled")

# Add the Code column
hflights$Code <- lut[hflights$CancellationCode]

# Glimpse at hflights
glimpse(hflights)

### 2. select()

### 3. mutate()

### 4. summarise()

### 5. group_by()

