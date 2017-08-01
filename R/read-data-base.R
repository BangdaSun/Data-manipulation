#   read all/multiple files with same format (file extension, same column labels)
#   concatenate them into one single file
library(xlsx)

setwd('C:/Users/bsun/Desktop/...')
files <- dir()
bid_df <- do.call(rbind, lapply(files, read.csv, header = TRUE))
write.xlsx(big_df, 'big_df.xlsx')
