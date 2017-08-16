# 
# rvest: case study 
# 
# reference:
#
#   https://blog.rstudio.org/2014/11/24/rvest-easy-web-scraping-with-r/
#   https://cran.r-project.org/web/packages/rvest/vignettes/selectorgadget.html
#


# install.packages("rvest")
library(rvest)
library(stringr)
library(ggplot2)
library(plyr)

### Example: extract info from datacamp
url = 'https://www.datacamp.com/courses/all'
datacamp = read_html(url)

# get course titles
course = html_nodes(datacamp, '.course-block__title') # css element
courseName = html_text(course)

# get course hours
hours = html_nodes(datacamp, '.course-block__length')  # css element
hours
courseHours = hours %>%
  html_text() %>%
  str_sub(2, 2) %>%
  as.numeric()

# get categories
pattern_r = '([R]{1}|ggplot2)'
pattern_py = '(Python|pandas|Machine Learning|scikit-learn)'
pattern_sql = 'SQL'

str_count(courseName, pattern_r)
str_subset(courseName, pattern_r)
sum(str_detect(courseName, pattern_r))

str_count(courseName, pattern_py)
str_subset(courseName, pattern_py)
sum(str_detect(courseName, pattern_py))

str_subset(courseName, pattern_sql)
sum(str_detect(courseName, pattern_sql))

# get instructors
instr = html_nodes(datacamp, '.course-block__author-name')
instrName = html_text(instr)

df = data.frame(title = courseName,
                instructor = instrName,
                hours = courseHours)

# add category to df
for (i in 1:nrow(df)) {
  if (str_detect(df$title[i], pattern_r)) 
    df$type[i] = 'R'
  else if (str_detect(df$title[i], pattern_py))
    df$type[i] = 'Python'
  else if (str_detect(df$title[i], pattern_sql))
    df$type[i] = 'SQL'
  else 
    df$type[i] = 'Mixture'
}

head(df)

### summary statistics
# mean hour of each type of course
tapply(df$hours, df$type, mean)

# number of each type of course
table(df$type)

# distribution of hours of each type
ggplot(df, aes(x = hours)) +
  geom_bar(color = 'black', fill = 'lightblue') +
  facet_wrap(~type, nrow = 2)

# number of courses that each instructor teaches
table(df$instructor, df$type)
