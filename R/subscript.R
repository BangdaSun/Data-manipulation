############################
### Chapter 6. Subscript ###
############################

# we can get the value in data structures using subscripts:
# 3 type of subscripts: numbers, characters (name), logic

# numbers: R start from 1
# character: cannot use negative, can use grep() to remove
# logic: TRUE will be included

# for matrix and array, we can use empty subscript to get all element of that dimension

# we can use order() to re-arrange the order of data
# x[order(x)], sort(x)
# also for data frame and matrix, we can apply rev() on that dimension
riris <- iris[rev(1:nrow(iris)), ]  # we see the first index is 150

# drop = FALSE, [[]] and []

### 6.6 Special functions for matrix
mat <- matrix(1:25, nrow = 5)
row(mat)
col(mat)
lower.tri(mat)
upper.tri(mat)

### 6.8 Data frame subscript
#   when using logical index:
#     return of [ will contain NA if NA exists;
#     return of subset() will exclude NA
#     also we can use '-' to exclude variables in subset()
#     but subset() cannot modify the data frame.
