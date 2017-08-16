#
# stringr tutorial
# 
# reference: 
#
#   https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html
#
#
# Four main families of functions:
# (1) character manipulation - inside strings, inside character vectors
# (2) whitespace add/remove etc
# (3) locale sensitive operation
# (4) pattern matching function - regular expression mainly

library(stringr)

### 1. Manipulating individual characters
myName = 'bangda'
myInfo = c('bangda', 'male', 'chinese', 'new york')

str_length(myName)  # length of string, same as nchar()
str_length(myInfo)

# substring
str_sub(myName, 2, 2)
str_sub(myName, 2)  # default from this position to last one
str_sub(myName, 2, -2)  # 2nd to 2nd to last

str_sub(myName, 1, 1) = 'B'
myName

# str duplicate
str_dup(myName, c(3, 4))

### 2. Whitespace
# pads a string to fixed length by adding extra white space on left / right
str_pad(myInfo, 10, 'left')  # where 10 means total length after adding
str_pad(myInfo, 8, 'both')
str_pad(myName, 8, 'both', pad = '$')
# str_trunc

# remove white space
myName = str_pad(myName, 10, 'left')
myName
str_trim(myName)

### 3. Locale sensitive
str_to_lower(myName)
str_to_upper(myName)

### 4. Pattern matching
# rules for regular expression
#  (1) indicate sets of characters with brackets []
#     "[a-z]" matches any lower case letters
#     "[:punct:]" matches all punctation marks
#  (2) the caret ^ negates a character range when in the leading position
#     "[^aeiou]" matches any characters except lower-case vowels
#  (3) the period . stands for any character and doesn't need brackets
#     "c..s" matches "cats", "class", "c88s", "c  s", etc
#  (4) quantifier: apply to last character before they appear
#     +: repeat one or more times
#     *: repeat zero or more times
#     ?: repeat one or zero times
#     {n}: repeat extacly n times
#     {n, }: repeat n or more times
#     {n, m}: repeat between n and m times
#  (5) $ sign means that a pattern only matches at the end of a line
#  (6) the caret ^ outside of brackets means that a pattern only matches at the beginning of a line


# examples:
#   "[0-9][0-9][a-zA-Z]+" matches strings with two digits followed by one or more letters
#   "(abc){3}" matches "abcabcabc"
#   "abc{3}" matches "abccc"
#   "M[rs][rs]?\.?" matches "Mr", "Ms", "Mrs", "Mr.", "Ms.", "Mrs."
#   "[a-z,]$" matches strings ending in low-case letters or a comma
#   "^[^A-Z]" matches strings not beginning with capital letters

# strsplit() can use a regular expression to divide a string into a vector
# grep() can search for patterns represented by regular expressions in a string
# regexp()
# regexpr()

strs = c(
  'apple',
  '219 733 8965',
  '329-293-8753',
  'Work: 579-499-7527; Home: 543.355.3679'
)

# pattern
phone = '([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})'

# detect pattern => logical vector, like grepl()
str_detect(strs, phone)

# return matched element, like grep()
str_subset(strs, phone)

# counts the number of matched
str_count(strs, phone)

# locate the position
str_locate(strs, phone)  # like regexpr()
str_locate_all(strs, phone)  # like gregexpr()

# extract elements
str_extract(strs, phone)
str_extract_all(strs, phone)

# match, like regmatches()

# replace
str_replace(strs, phone, 'XXX-XXX-XXXX')
str_replace_all(strs, phone, 'XXX-XXX-XXXX')

# split
str_split('a-b-c', '-')
str_split_fixed('a-b-c', '-', n = 2)

# engines
