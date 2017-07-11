################################
### Chapter 15. Missing data ###
################################

#
# R in action, Robert I. Kabacoff
# 

### General procedure
#    identify missing data
# => inference the cause of missing, need some interpretations
# => manipulation (delete row or impute), see which one gives better result

# install.packages(c("VIM", "mice"))
# Data: sleep from VIM
#   Dream - dream time
#   NonD - non dream time

library(VIM)
library(mice)
head(sleep)
dim(sleep)  # each row is a species

#   Three type of missing data:
#     (1) totally randomly missing - MCAR (best case?)
#     the data has no relation with other obs / vars
#     e.g.: the NA of 12 species is not the result of system reasons
#     the data without NA can be viewed as random sample
#  
#     (2) randomly missing - MAR
#     the data depends on other vars, but not depdens on obs
#     e.g.: the less body weight will lead to high probability of NA
#     but NA is not depend on the dream time
#     i.e., if I control the body weight, the NA will be random
#
#     (3) non randomly missing - NMAR
#     e.g. probability of NA depdens on the dream time

#     In most case, we assume MCAR / MAR
#     for NMAR, we need also modeling on missing data

#     identify missing data: is.na(), !complete.cases(), VIM package
#     => delete NA 
#        => invalid instance, row deletion, omit.na()
#        => valid instance, .. some functions
#     => MLE, mvmle package
#     => impute
#        => single imputation, Hmisc package
#        => multiple imputation, Mi, Mice, amelia, mitools packages

### Detect missing data
#   common: is.na(), is.nan(), is.infinite(); and remember we cannot use a == NA to detect
#   we can also use complete.case, return TRUE if the row has no NA
complete.cases(sleep)
sleep[!complete.cases(sleep), ]

# practice: detect NA in data frame
# ------------------------------------------------------------------------------
# test data
test_df <- data.frame(
  year = seq(1994, 2017),
  A    = rnorm(24, mean = 10, sd = 1),
  B    = runif(24, min = 20, max = 30),
  C    = rexp(24, rate = 2),
  D    = rbinom(24, size = 10, prob = .3)
)

row_idx <- sample(1:nrow(test_df), size = 3, replace = FALSE)
col_idx <- sample(2:ncol(test_df), size = 4, replace = TRUE)

test_df[row_idx[1], col_idx[2]] <- NA
test_df[row_idx[2], col_idx[2]] <- NA
test_df[row_idx[3], col_idx[3]] <- NA
test_df[row_idx[1], col_idx[1]] <- NA
test_df[row_idx[3], col_idx[4]] <- NA

# detect obs with NA
idx <- 1:nrow(test_df)
idx[!complete.cases(test_df)]

test_df_wna <- test_df[!complete.cases(test_df), ]  # every row has NA
test_df_wna

# detect locations of NA
apply(test_df_wna, 1, is.na) %>% 
  as.numeric() %>% 
  matrix(ncol = ncol(test_df_wna), byrow = TRUE)

# detect the NA pattern: appear successively
test_df[2:3, 2] <- NA
test_df[c(1, 3, 5), 3] <- NA
test_df[3:9, 4] <- NA
test_df

successive_na_detect <- function(.data) {
  lst <- is.na(.data) %>% rle()  # --> doesn't work for NA directly, need is.na()
  lst$lengths[lst$values]
}

apply(test_df, 2, successive_na_detect)
# ------------------------------------------------------------------------------


### Explore the pattern of missing data
#   1. make a list to show missing data
#   use md.pattern in mice package
#   where 1 means no missing data, 0 means missing data, row name are the number of obs
md.pattern(sleep)

#   2. visualization
#   use aggr(), matrixplot(), scattMiss() in VIM
aggr(sleep, prop = TRUE, number = TRUE)
aggr(sleep, prop = FALSE, number = TRUE)

matrixplot(sleep) # red is missing data, and the value of variable are mapping to [0, 1] which is from white to black
#   from the matrixplot, we can see non missing data correspond to small BodyWgt and BrainWgt

#   explore the relationship between dream time and gest
marginplot(sleep[c("Gest", "Dream")], pch = 20, col = c("darkgrey", "red", "blue"))
