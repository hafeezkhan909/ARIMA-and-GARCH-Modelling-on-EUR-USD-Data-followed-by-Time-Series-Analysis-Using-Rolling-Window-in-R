# ARIMA-and-GARCH-Modelling-on-EUR-USD-Data-followed-by-Time-Series-Analysis-Using-Rolling-Window-in-R

In this project, ARIMA and GARCH modelling has been performed on the EURUSD data, followed by rolling window analysis on it.
Firstly, the EURUSD Data was pre-processed using Interpolation technique to take care of the null values present in the data using python. 
Once the data was cleaned up and ready for use, the following steps were carried out:

1.	ADF, PP, and KPSS test on the price observations of EURUSD data. 


So, for the ADF and PP test, the H0 (null) hypothesis is that the time series is not stationary and the H1 (alternative) hypothesis is that the time series is stationary. As it can be observed that the p-values obtained for price were greater than 5%, i.e., 12.61% for ADF test and 5.186% for PP test, the H0 hypothesis was accepted. Consequently, when checking for the KPSS test, the p-value obtained was less than 5%, i.e., 1%. In this test, H0 hypothesis is that the time series is stationary, while the H1 hypothesis is that the time series is not stationary. So, as the value of the KPSS test was less than 5%, the H0 hypothesis was rejected. From these three results attained, it was concluded that the price time series was not stationary. Due to this, the first degree of integration of the price observations was done and the similar tests were carried out on that return observations. 

Plot the time series graph of the price values
![image](https://user-images.githubusercontent.com/82383549/209842930-202f1f0e-851b-4aea-920c-505196912a67.png)
