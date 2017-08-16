"""
    Quick reference / cheatsheet for pandas
    
    https://github.com/DataMininginAction/pandas-zh
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

### Create objects in pandas --------------------------------------------------
# Series
s = pd.Series([1, 3, 5, 7, np.nan, 11])
s

# DataFrame with date index
dates = pd.date_range('20170707', periods = 7)
dates

# using np.array
df = pd.DataFrame(np.random.randn(7, 4), index = dates, columns = list('ABCD'))
df

# using dictionary
my_dict = {'A': np.arange(4),
           'B': pd.Timestamp('20170707'),
           'C': pd.Series(np.random.randn(4)),
           'D': np.array([2] * 4, dtype = 'int32'),
           'E': pd.Categorical(['test', 'train', 'test', 'train']),
           'F': ['Monday', 'Wednesday', 'Thursday', 'Friday']}
df2 = pd.DataFrame(my_dict)
df2

# check data types
s.dtypes  # or .dtype
df2.dtypes


### View data -----------------------------------------------------------------
# head and tail
df2.head()
df2.tail()

# check index (row wise)
s.index
df.index

# check columns (column wise, for DataFrame)
df.columns
df2.columns

# check values
s.values
df.values
df2.values

# transpose
df.T  # from numpy -->
arr = np.array([[1, 3, 4],
                [2, 5, 6]])
arr
arr.T  # won't change arr

# summary of the DataFrame
s.describe()
df.describe()
df2.describe()  # only for numeric variables
df2.info()

# sort by columns
df.sort_index(axis = 1, ascending = False)  # row wise
df.sort_index(axis = 0, ascending = False)  # col wise


### Data selection - index and slicing ----------------------------------------
# select elements of Series
s[0]
s[:3]
s['0']  # --> ERROR!!

# select columns of DataFrame
# 1. use columns
df['A']  # --> Series
df.A
df[['A']]  # --> DataFrame
df['A', 'B']  # --> ERROR!!
df[['A', 'B']]
df[:, ['A', 'B']]  # --> ERROR!!

# 2. use integers --> ERROR!!
df[:, [1, 2]]

# select rows of DataFrame
# 1. use index 
df['2017-07-07']  # --> ERROR!!, might be the data type is datetime

# 2. use integers
df[0:4]
df[0:4, :]  # --> ERROR!!

"""
    Seems that indexing and slicing is not as easy as I think... 
    Actually, .loc and .iloc is recommended
"""

# rows
df.loc['2017-07-07':'2017-07-09']  # end included
df.iloc[0:3]  # end excluded

# columns
df.loc[:, ['A', 'B']]
df.iloc[:, ['A', 'B']]  # --> ERROR!!

# rows and columns
df.loc['2017-07-07':'2017-07-09', ['A', 'C']]
df.iloc[0:2, 'A']  # --> ERROR!!
df.iloc[:2, :3]

"""
    Summary:
        1. loc can handle row + column selection
        2. iloc also works well but only for integers, like numpy ndarray
"""

# ONE MORE IMPORTANT WAY: use boolean
df[df.A > 0]
df[df.A > 0, :]  # --> ERROR!!

df[df > 0].iloc[:, 3]  # method chaining

# using isin()
df2[df2['F'].isin(['Monday', 'Wednesday'])]


### Add values ----------------------------------------------------------------
# add one column to the DataFrame
new = pd.Series([1, 2, 3, 4, 5, 6], index = pd.date_range('20170709', periods = 6))
new
df['F'] = new
df

# add one row to the DataFrame
new_row = df[2]
df.append(new_row)

# update value
df.at[dates[0], 'A'] = 0
df.iat[0, 1] = 2


### Missing data --------------------------------------------------------------
# we use np.nan to stand for missing value

# drop the observation with missing value
df.dropna(how = 'any')  # won't change df

# fill na
df.fillna(value = 5)  # won't change df


# is.na() (this is in R format)
pd.isnull(df)


### Calculation ---------------------------------------------------------------
# missing data / non-numeric won't be included
df2.mean()  # default by column
df2.C.mean()
df2.mean(1)  # by row
df.loc[:, ['C', 'D']].mean()

s.value_counts()  # value count
# str method .str.method()


### Apply functions -----------------------------------------------------------
# default by column
df2.apply(np.max)


### Combine -------------------------------------------------------------------
# concat
#   concat - like rbind() and cbind() in R
df3 = pd.DataFrame(np.random.randn(10, 4))
pieces = [df3[:3], df3[3:7], df3[7:]]  # --> concate pieces[0], pieces[1], pieces[2]

pd.concat(pieces)

#   join - like merge in R
#   by key
left_df = pd.DataFrame({'key': [1001, 2001, 1002, 1005],
                        'x': [2, 3, 1, 4],
                        'y': [3, 2, 1, 5]})
    
right_df = pd.DataFrame({'key': [1002, 1006, 1003],
                         'z': [2, 2, 3]})

pd.merge(left_df, right_df, on = 'key')


### Groupby -------------------------------------------------------------------
df5 = pd.DataFrame({'A': ['foo', 'bar', 'foo', 'bar', 
                          'foo', 'bar', 'foo', 'bar'],
                   'B' : ['one', 'one', 'two', 'three', 
                          'two', 'two', 'one', 'three'],
                   'C' : np.random.randn(8),
                   'D' : np.random.randn(8)})

df5.groupby('A').mean()


### Reshape -------------------------------------------------------------------
#   stack


### Pivot table ---------------------------------------------------------------


### Time series ---------------------------------------------------------------
#   create time indexed data
rng = pd.date_range('2017-01-01', periods = 190, freq = 'D')
ts  = pd.Series(np.random.randint(0, 1000, len(rng)), index = rng)
ts.head()

#   resample
ts.resample('M', how = 'mean')


### Categorical ---------------------------------------------------------------
df = pd.DataFrame({'id': [1, 2, 3, 4, 5, 6],
                   'grade': ['a', 'b', 'b', 'a', 'e', 'e']})

df['new_grade'] = df['grade'].astype('category')
df['new_grade']

#   computing
df.groupby('new_grade').size()  # like table() in R
