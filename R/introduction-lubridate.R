#
# lubridate tutorial - more convenient dates and time manipulation package
#
# references:
#
#   https://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html
#   https://www.jstatsoft.org/article/view/v040i03
#
#

# install.packages('lubridate')
library(lubridate)


### Parsing dates and times
#   no need specify like format = ... in as.Date

today <- ymd('20170706')
today
class(today)

dmy('07/06/2017')
ymd_hms('2017-07-06 15:58:00')
ymd_hms('2017-07-06 15:58:00', tz = 'America/New_York')  # check https://en.wikipedia.org/wiki/List_of_tz_database_time_zones


### Extract info from dates and times
my.tz <- 'America/New_York'
go.work <- ymd_hm('2017-07-07 8:00', tz = my.tz)
go.home <- ymd_hm('2017-07-07 17:30', tz = my.tz)

second(go.work)
hour(go.work)
year(go.work)
month(go.work)
day(go.work)
with_tz(go.work)

#   gonna late...
minute(go.work) <- 5
go.work


### Time interval
working <- interval(go.work, go.home)
working
class(working)  # interval object in lubridate
