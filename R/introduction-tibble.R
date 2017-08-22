# tibble tutorial
#
# http://r4ds.had.co.nz/tibbles.html
#

library(tibble) # also in tidyverse


## 1. create tibbles
# as_tibble() - change existed df to tibble
as_tibble(iris)

# tibble() - more convenient than data.frame, auto-recycle inputs if length 1

# allows us to refer to variable just created
tibble(x = 1:5, y = 3 * x  + 1.2)

# non-syntactic names (backticks `` is also useful in other tidyverse pkgs)
tibble(`:-)` = 'smile', `:-(` = 'sad')

# tribble() - transposed tibble
# columns are defined by formulas, start with ~
# entries are separated by commas
tribble(
  ~x, ~y, ~z,
  'a', 2, 3.6,
  'b', 1, 2.33
)


# 2. vs data.frame()
# from hadley:
# "Compared to a data.frame, tibbles are more strict: they never do partial matching, 
# and they will generate a warning if the column you are trying to access does not exist."

# use place holder
df %>% .$x
df %>% .[['x']]
