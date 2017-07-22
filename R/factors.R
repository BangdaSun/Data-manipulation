#########################
### Chapter 5. Factor ###
#########################

### 5.1 Intro
#   factor is stored as integer vector in R
#   with a corresponding set of character values to use when factor is displayer

data  = c(1, 2, 2, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1)

fdata = factor(data)
levels(fdata)
nlevels(fdata)

rdata = factor(data, labels = c("I", "II", "III"))
rdata

#   we can also change the label of fdata by levels function
#   levels function is like names function for vector
levels(fdata) = c("I", "II", "III")
fdata

#   ordered level
ofdata = factor(data, order = TRUE)
ofdata

#   factors represent a efficient way to store character values,
#   where each character will be stored only once, and the data
#   itslef is stored as a vector of integers
#   Therefore, read.table() will automatically convert character
#   variable into factors. We can use as.is = TRUE to avoid this

#   use reorder(), relevel() to re-order the factor level

### 5.2 Numeric factor

### 5.3 Manipulate factor
#   when subset factor data, the level will remain, may cause some problems
lets = sample(letters, size = 100, replace = TRUE)
lets = factor(lets)
table(lets[1:5])

#   when combine factor variables, we need convert it back to original form:
#   use levels function
levels(lets)[lets]

### 5.4 Create factor based on continuous variable
#   we can use cut function with breaks = ... param
#   cut function will return factor class

#   example: 
#   create three equally divided intervals
#   add labels
#   divide based on quantile
height = rnorm(20, mean = 100, sd = 10)
cut(height, 3)
cut(height, 3, labels = c('low', 'medium', 'high'))
cut(height, quantile(height, (0:4) / 4))

### 5.5 Factor on date and time
#   use seq() to create date vector
all_day <- seq(from = as.Date('2017-01-01'),
               to = as.Date('2017-12-31'), by = 'day')

#   use format() to extract month
c_month <- format(all_day, '%b')
months <- factor(c_month, levels = unique(c_month), order = TRUE)
table(months)

#   also we can use cut(), breaks = ... to get any interval
wks <- cut(all_day, breaks = 'week')
head(wks)

qts <- cut(all_day, '3 months', labels = paste0('Q', 1:4))
