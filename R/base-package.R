### with()
#   with() function applys an expression to a dataset
#   with(.data, expression)
df <- data.frame(A = rnorm(20), B = rnorm(20))
with(df, df[, 'A'])


### within()
#   within() function is similar to with(), but it makes the corresponding modification
#   to a copy of data. Can be used like transform
#   within(.data, expression)
within(df, C <- A + B)  # get a column named C


### by()
#   by() function applys a function to each level of a factor or factors
#   by(.data, .data$factorlist, function)
df$level <- factor(c(rep('A', 15), rep('B', 5)))
by(df, df$level, function(x) mean(x$A))


### transform()
#   does something on data frame
transform(airquality, Ozone = -Ozone)
transform(airquality, new = -Ozone, Temp = (Temp-32)/1.8)

### subset()
#   can apply on vector, matrix, data frame
subset(airquality, Temp > 80, select = c(Ozone, Temp))
subset(airquality, Day == 1, select = -Temp)
subset(airquality, select = Ozone:Wind)
