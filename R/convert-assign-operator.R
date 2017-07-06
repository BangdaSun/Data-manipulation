#
# How to convert all assignment operator '=' to '->'
# https://bangdasun.github.io/2017/07/05/assignment-in-r/
#

setwd('c:/users/bangda/desktop/data manipulation')

# R script I want to convert
con <- file('introduction-stringr.R')
script <- readLines(con)

# convert
library(formatR)
new.script <- tidy_source(text = script, arrow = TRUE)

# create formatted R script
new.con <- file('formatted.R')
writeLines(text = new.script$text.tidy, con = new.con)
