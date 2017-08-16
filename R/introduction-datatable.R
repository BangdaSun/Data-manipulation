# Intro to data.table
# combine subset rows (where), subset column and compute (select / aggregate / group by)
#
# reference: 
#   https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html
#
# 

library(data.table)

### Data: NYC-Flights14 data
flights = fread('flights14.csv')
str(flights)
class(flights)
head(flights)

### General form
#   DT[i, j, by]
#   +-------------+-----------------+----------+
#   + R   +   i   +       j         +    by    +
#   + ----+-------+-----------------+----------+
#   + SQL + where + select | update + group by +
#   +-------------+-----------------+----------+
#
#   j could be the most flexible!

### Filter rows
#   columns can be referred directly, using df$cols is also fine
#   comma can be ignored
flights[origin == 'JFK' & month == 6L] %>% head
flights[1:2]
flights[order(origin, -dest)] %>% head  # sort by origin in ascending order, then by dest in descending order

### Select columns
#   return a vector
flights[, arr_delay] %>% head

#   return data table
flights[, list(arr_delay)] %>% head
flights[, .(arr_delay)] %>% head  # .() is the alise of list()
flights[, !c('arr_delay')] 
flights[, -c('arr_delay')]

#  return data table also rename the columns
flights[, .(arrival_delay = arr_delay, depart_delay = dep_delay)]

#  compute
flights[, arr_delay + dep_delay < 0] %>% head
flights[, sum(arr_delay + dep_delay < 0)]

#  -- question: how many trips have been made in 2014 from JFK in June?
flights[origin == 'JFK' & month == 6L, length(origin)]
flights[origin == 'JFK' & month == 6L, .N]  # .N

### Aggregation
##  group by
flights[, .(.N, avg_dep_time = mean(dep_time)), by = .(origin, dest)]

##  key by - combine with group by and order by
flights[carrier == 'AA',
        .(mean(arr_delay), mean(dep_delay)),
        keyby = .(origin, dest)]

##  chaining - DT[...][...]
flights[carrier == 'AA'][keyby = .(origin, dest)]

##  multiple columns operations .SD, .SDcols
#   -- group by origin and dest, and return the max two dep_delay one in each group
flights[, head(.SD, 2), by = .(origin, dest)]  # only this way works - chaining doesn't work
#   -- group by origin and dest, and return the mean of dep_time, dep_delay, arr_delay, air_time 
flights[, lapply(.SD, mean), by = .(origin, dest), .SDcols = c('dep_time', 'dep_delay', 'arr_delay', 'air_time')]
