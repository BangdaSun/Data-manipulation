"""
    Quick reference / cheatsheet for numpy
    
    http://www.python-course.eu/numpy.php
"""


import numpy as np


### Create sequence (not the sequences need to be typed one by one) -----------   
# array()
lst = [1.1, 2.3, 2.1, 3.2, 4.3, 1.2]
narr = np.array(lst)

# arange()
# return np.array rather than list iterator like range() does
x = np.arange(10)  # [0, 10)
y = np.arange(10, step = 2)  # [0, 10) by 2


# linspace()
# return np.array, but specify number of elements, end will included by default (endpoint = True) and should input at least two args
x = np.linspace(1, 10, num = 10)  # [1, 10]
y = np.linspace(1, 10, num = 9, endpoint = False)


### Create special arrays -----------------------------------------------------
# ones()
x = np.ones(5)
y = np.ones((5, 6))

# zeros()
x = np.zeros(5)
y = np.zeros((5, 6))

# eye matrix
x = np.identity(6)


### Shape ---------------------------------------------------------------------
x = np.random.randint(0, 100, size = (3,5))
x.shape
x.shape = (5, 3)  # by row
x.reshape((3, 5))


### Indexing and slicing ------------------------------------------------------
# index start from 0
# slicing rule: [start:end:step] --> [start, end)

# a 3 by 3 example: slice index
arr2d = np.array([[3, 4, 5], [5, 2, 1], [1, 2, 3]])

# traditional way
# one element --> just specify location (i, j)
arr2d[2][1]  # row 3 and col 2

# slicing
# one row + multi col
arr2d[2][1:3]
arr2d[2, :][1:3]
arr2d[2, :][:, 1:3]  # --> ERROR!!

# multi row + one col
arr2d[:2, :][2]  # --> ERROR!!
arr2d[:2, :][:, 2]
arr2d[:2][:, 2]

# multi row + multi col
arr2d[:2, :][:, :2]

# alternative way: using one bracket
# row index
# 1st row
arr2d[0]
arr2d[0, :]    
arr2d[:1, :]   # stop before the 2nd row (index = 1)

# 2nd row
arr2d[1]
arr2d[1, :]
arr2d[1:2, :]  # start at the 2nd row (index = 1) and stop at the 3rd row (index = 2)

# 3rd row
arr2d[2]
arr2d[2, :]
arr2d[2:, :]   # start at the 3rd row (index = 2)

# 1st row and 2nd row
arr2d[0:2]     # start at the 1st row (index = 0) and stop before the 3rd row (index = 2)
arr2d[0:2, :]
arr2d[:2, :]   # stop before the 3rd row (index = 2)

# 2nd row and 3rd row
arr2d[1:]      # start at the 2nd row (index = 1)
arr2d[1:3]     # start at the 2nd row (index = 1) and stop before the 4th row (index = 3)
arr2d[1:, ]
arr2d[1:3, :]

# 1st row and 3rd row
arr2d[[0, 2]]
arr2d[[0, 2], :]

# column index
# 1st column
arr2d[:, 0]
arr2d[:, :1]   # stop before the 2nd column (index = 1)

# 2nd column
arr2d[:, 1]
arr2d[:, 1:2]  # start at the 2nd column (index = 1) and stop before the 3rd column (index = 2)

# 3rd column
arr2d[:, 2]
arr2d[:, 2:]

# 1st column and 2nd column
arr2d[:, 0:2]  # start at the 1st column (index = 0) and stop before the 3rd column (index = 2)
arr2d[:, :2]   # stop before the 3rd column

# 2nd column and 3rd column
arr2d[:, 1:3]  # start at the 2nd column (index = 1) and stop before the 4th column (index = 3)
arr2d[:, 1:]   # start at the 2nd column

# 1st column and 3rd column
arr2d[:, [0, 2]]

# what if we want to do exclude operation?
# use :-, idx start from 1 (actually it's the same idea of exclud endpoint)
# example: exclude row 1 and last row
arr2d[1:-1]


"""
    NOTE:
    slicing will create view on original array --> original array will be modified if we modify view
    slice = arr2d[:2]
    slice[0] = 100 --> will change arr2d
    
    whereas in build-in list we will get copy
    
"""

tiny_slice = arr2d[:2, :2]
tiny_slice[0, 0] = 100
arr2d

np.may_share_memory(tiny_slice, arr2d)  # --> True

# to avoid this issue, use .copy()
tiny_slice = arr2d.copy()[:2, :2]
tiny_slice[0, 0] = 10000
arr2d


### Numerical operations ------------------------------------------------------

# scalar

# arithmetic on two arrays 
# add / minus / multiply / divide
x = np.array([[11, 12, 13], 
              [21, 22, 23],
              [31, 32, 33]])
    
y = np.ones((3, 3)) 
x + y
x - y
x * y  # like dot multiply in matlab
x / y

# matrix multiplication
np.dot(x, y)

X = np.matrix(x)
Y = np.matrix(y)
X * Y

# comparison operator
x < y
np.array_equal(x, y)


# logical operator
np.logical_and(x < 30, y > 0)
x < 30 and y > 0  ## --> ERROR!!

# broadcasting - perform arithmetic operations on arrays of different shapes
z = np.array([1, 2, 3])
x * z  # [1, 2, 3] --> [[1, 2, 3], [1, 2, 3], [1, 2, 3]]

# to column
z = np.array([1, 2, 3])
z[:, np.newaxis]  # --> z.transpose()


### Flatten and reshape -------------------------------------------------------
