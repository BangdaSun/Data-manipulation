############################
### Chapter 1. Data in R ###
############################

### 1.1 Mode and Class
#   mode() and class() are two main properties of data in R, (typeof() is also used)
#   for single data (usually in vector), there could be: numeric, character, logical
#   for data set, like matrix, list, data frame, we will meet other modes and classes

mylist = list(
  num  = c(1, 1, 2, 3, 5, 8),
  char = c("A", "B", "c", "d"),
  logi = c(TRUE, FALSE),
  lst  = list(a = c(1, 1, 2), b = c("a", "b", "c")),
  mat  = matrix(c(1:8), nrow = 4, ncol = 2),
  df   = data.frame(id = c(1:4), grade = c(90, 94, 95, 88))
)
# Check mode and class
sapply(mylist, mode)
sapply(mylist, class)
sapply(mylist, typeof)

### 1.2 Data storage

### 1.3 Check mode and class 

### 1.4 Check structure of object

### 1.5 Convert object

### 1.6 Missing value

### 1.7 Dealing with missing value
# many statistical aggregate function has a param: na.rm = TRUE to deal with NA values,
# if the function has no such param, we can use is.na() to identify the NA values

# some modeling function like lm(), glm() has a param na.action = ..., we can specify 
# functions to apply on data before modeling on data

# na.omit(), complete.cases() are also a useful choice
