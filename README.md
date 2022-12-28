# ARIMA-and-GARCH-Modelling-on-EUR-USD-Data-followed-by-Time-Series-Analysis-Using-Rolling-Window-in-R

In this project, ARIMA and GARCH modelling has been performed on the EURUSD data, followed by rolling window analysis on it.
Firstly, the EURUSD Data was pre-processed using Interpolation technique to take care of the null values present in the data using python. 
Once the data was cleaned up and ready for use, the following steps were carried out:

1.	ADF, PP, and KPSS test on the price observations of EURUSD data. 


So, for the ADF and PP test, the H0 (null) hypothesis is that the time series is not stationary and the H1 (alternative) hypothesis is that the time series is stationary. As it can be observed that the p-values obtained for price were greater than 5%, i.e., 12.61% for ADF test and 5.186% for PP test, the H0 hypothesis was accepted. Consequently, when checking for the KPSS test, the p-value obtained was less than 5%, i.e., 1%. In this test, H0 hypothesis is that the time series is stationary, while the H1 hypothesis is that the time series is not stationary. So, as the value of the KPSS test was less than 5%, the H0 hypothesis was rejected. From these three results attained, it was concluded that the price time series was not stationary. Due to this, the first degree of integration of the price observations was done and the similar tests were carried out on that return observations. 

2.  Plot the time series graph of the price values

![image](https://user-images.githubusercontent.com/82383549/209842930-202f1f0e-851b-4aea-920c-505196912a67.png)

3.	Plot the time series graph of the return values 

![image](https://user-images.githubusercontent.com/82383549/209843161-4cc5f806-c9e4-4d4c-9de6-486043e4a876.png)

By plotting these two graphs, it was clearly seen that the price observations were not stationary, while the return observations were stationary, as the mean was 0 and standard deviation 1 throughout. 

4.	ADF, PP, and KPSS test on the return observations of EURUSD data. 


As we can observe in the table above, the ADF and PP test was less than 5%, and KPSS test was greater then 5%. As a result, it can be substantiated that the time series was stationary, and we can move ahead for analysing and modelling of the data using ARIMA and GARCH models.

5.	Descriptive Statistics of the return observations


The Basic statistics table above shows 16 parameters about the return data. It shows that there was a total of 3344 observations seen, and no null values were to be found (as we took care of it in the beginning itself!). The minimum return value to be found was -0.143324, while the maximum return value was 0.159632. The mean, median, and sum of the data were -0.000061, 0.000000, -0.204390 respectively. "LCL" and "UCL" stand for lower/upper confidence limits, computed under the null hypothesis of independent and identically distributed. The LCL and UCL mean’s to be found in the data were -0.000334 and 0.000211 respectively. The variance and standard deviation calculated of the data was 0.000065 and 0.008035 respectively. It became clear by looking at the mean and standard deviation that the data exhibit stationarity. The value of skewness, i.e., 0.654367, indicated that the return data was moderately skewed, as it lied between 0.5 and 1. The kurtosis observed in the data was about 95.021583. This showed that the distribution was leptokurtic (fat tailed), as it had an excess kurtosis of more than 0.  

6.	Test for normality
The p-value attained while testing the data for normality was less than 2.2e-16, which meant that the H0 hypothesis (the time series data does not have normality) was rejected and therefore the return values of the data were normal.

7.	Test for autocorrelation
Similarly, when the return values were tested for autocorrelation the p-value recorded was less than 2.2e-16. The H0 hypothesis says that the time series does not have autocorrelation. But as the value was less than 5%, the H0 hypothesis was rejected and the H1 hypothesis accepted i.e., time series entails autocorrelation. 

8.	ARIMA Modelling
Initially the partial autocorrelation function (pacf) and auto correlation function (acf) of the time series data were plotted. The ARIMA models: Model 1 through Model 5 were created with the help auto ARIMA function. The Model 6 and Model 7 were consequently created by manually fixing the lags, which were determined from the pacf and acf graphs, respectively.  
