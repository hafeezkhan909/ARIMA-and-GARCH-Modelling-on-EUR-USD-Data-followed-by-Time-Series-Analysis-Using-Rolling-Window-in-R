import pandas as pd
dataset = pd.read_csv('EURUSD.csv') #Reading the values from the dataset(csv file)
dataset.info()

'''
RangeIndex: 3345 entries, 0 to 3344
Data columns (total 2 columns):
 #   Column  Non-Null Count  Dtype  
---  ------  --------------  -----  
 0   Date    3345 non-null   object 
 1   Price   3319 non-null   float64
dtypes: float64(1), object(1)
memory usage: 52.4+ KB
'''
