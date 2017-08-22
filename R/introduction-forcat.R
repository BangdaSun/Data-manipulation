#
# forcats tutorial
# 
# package for categorical data
# reference
#
#   https://blog.rstudio.com/2016/08/31/forcats-0-1-0/
#

library(forcats)
library(tibble)

df <- tibble(
  zip   = c(35801, 99501, 85001, 72201),
  state = c('Alabama', 'Alaska', 'Arizona', 'Arkansas'),
  city  = c('Huntsville', 'Anchorage', 'Phoenix', 'Little Rock')
)

# parse_factor() - convert into factors (from readr pkg)
df$state <- parse_factor(df$state, levels = df$state)  # must along with levels


# fct_reorder() - re-order the level of the factor

# fct_relevel() - arrange arbitrary, for example move the reference level in front

# in base package we can also use relevel(), reorder(), levels()<- 


# fct_recode() - re-encode/modifier factors
df$state <- fct_recode(df$state,
                       'AL' = 'Alabama',
                       'AK' = 'Alaska',
                       'AZ' = 'Arizona',
                       'AR' = 'Arkansas')


# fct_lump() - lump the rarest / most common levels into 'other'
# meet this issue in kaggle - Titanic
df <- rbind(df, df[-1, ])
df$state <- fct_lump(df$state)

# also can specify number of levels to keep
df <- rbind(df, df[-1, ], df, df[-2, ])
df$state %>% table()
df$state <- fct_lump(df$state, n = 2)
df$state


# fct_collapse() - merge levels of factor


## see also
# fct_inorder()
# fct_infreq()
# fct_rev()
# all these four functions are able to change level order
