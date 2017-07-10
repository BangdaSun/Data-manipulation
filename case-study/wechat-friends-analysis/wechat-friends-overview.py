# coding: utf-8

# In[1]:

"""
    itchat: A complete and graceful API for Wechat
    developed by LitterCoder
        http://itchat.readthedocs.io/zh/latest/
        https://github.com/littlecodersh/ItChat
    
    Overview of my wechat friends
"""
import itchat as ic
ic.login()


# In[2]:

friends = ic.get_friends(update = True)[0:]
print(friends[0])


# In[3]:

# Sex distribution of my friends
male, female, unknown = 0, 0, 0
for i in friends[1:]:
    sex = i['Sex']
    if sex == 1:
        male += 1
    elif sex == 2:
        female += 1
    else:
        unknown += 1

total = float(male + female + unknown)
sex_info = (male, float(male)*100 / total, female, float(female)*100 / total, unknown, float(unknown)*100 / total)
print('male: %d -> %f %%\nfemale: %d -> %f %%\nunknown: %d -> %f %%' % sex_info)


# In[4]:

# Create a DataFrame to store all friends information
import pandas as pd
# Some informations like NickName, RemarkName are personal privacy, I will not display them here
friends_private_df = pd.DataFrame(friends[1:])


# In[5]:

friends_public_df = friends_private_df.loc[:, ['City', 'Province']]
friends_public_df.iloc[:20]


# In[6]:

friends_public_df.groupby('Province').count()


# In[7]:

# Convert 'NewYork' to 'New York'
idx_ny = friends_public_df['Province'] == 'NewYork'
friends_public_df.loc[idx_ny, ['Province']] = 'New York'


# In[8]:

# Top 10 locations my friends come from
friends_public_df.groupby('Province').count().sort(['City'], ascending = False).head(10)


# In[9]:

# Friends in Zhejiang
friends_zj = friends_public_df.loc[friends_public_df['Province'] == friends_public_df.iloc[0, 1]]
friends_zj.head()


# In[10]:

# Friends in cities of Zhejiang
friends_zj['City'].value_counts()
