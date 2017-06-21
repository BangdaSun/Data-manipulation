"""

    Data manipulation using pandas, use iris data as an example
    
"""
import numpy as np
import pandas as pd

iris = pd.read_csv("C://Users//Bangda//Desktop//iris.csv", index_col = 0)
iris.head()

### Get the summary of data frame. Notice that Species is not returned, it's a categorical variable
iris.describe()

### Select variables - Extract columns as sub data frame
length = iris[['Sepal.Length', 'Petal.Length']]
length.head()

### Filter observations - Extract rows as sub data frame
larger_length = np.logical_and(iris['Sepal.Length'] > 5.8, iris['Petal.Length'] > 4.35)
larger_length_df = iris[larger_length]
larger_length_df.head()

### Group by categorical variable and compute summary statistics
iris.groupby('Species').mean()

### Split into two sets
test_idx = np.random.randint(0, iris.shape[0] + 1, iris.shape[0] / 5.)
testing  = iris.iloc[test_idx]
testing.head()

training = iris.iloc[~test_idx]
training.head()
