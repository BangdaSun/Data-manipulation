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
#   but for format like 20170707 08:00, h should be two digits

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
week(go.work)
day(go.work)
wday(go.work)  # --> return number of days in one week: Fri is 6th; use label = TRUE to get Frid (factor)
yday(go.work)  # --> return number of days in that year
with_tz(go.work)

#   gonna late...
minute(go.work) <- 5
go.work


### Time interval
working <- interval(go.work, go.home)
working
class(working)  # interval object in lubridate


eating <- ymd_hm('2017-07-07 13:00', tz = 'America/New_York') - ymd_hm('2017-07-07 12:30', tz = 'America/New_York')
eating.interval <- interval(ymd_hm('2017-07-07 13:00', tz = 'America/New_York'),
                            ymd_hm('2017-07-07 12:30', tz = 'America/New_York'))

#   check if two time interval overlaps
int_overlaps(eating.interval, working)
ymd_hm('20170708 06:00') %within% working

### Arithemtics
# lubridate allows arithmetic with both relative and exact units by introducing four new time
# related objects. These are instants, intervals, durations, and periods.

#   check if 2017 is leap year
leap_year(2017)

#   durations
dminutes(2)
dyears(1)

#   create period object, notice the difference with functions like year(), day() (they apply on date object)
years(1)
days(1:2)  # those result can be applied on date objects

#   calculate time interval to be time units
stay.together <- interval(ymd('20170706'), ymd('20141210'))
stay.together / ddays(1)  # -> number of days

#   %/%, %%, %--% operator

#   as.period
as.period(stay.together)
