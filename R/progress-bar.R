# print a progress bar (use for for - loop only)
n = 10000  # the number of iteration in for - loop
for (i in seq(n)) {
  # ...
  # print bar
  if (i %in% c(seq(10) * (n/10)) )
    cat('|', rep('=', 10*i/n), rep(' ', 10 - 10*i/n), '|', ' ', 100*i/n, '%', '\n', sep = '')
}
