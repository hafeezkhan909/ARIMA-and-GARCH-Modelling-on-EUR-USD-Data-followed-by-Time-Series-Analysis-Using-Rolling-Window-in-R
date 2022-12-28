# ARIMA-and-GARCH-Modelling-on-EUR-USD-Data-followed-by-Time-Series-Analysis-Using-Rolling-Window-in-R

In this project, ARIMA and GARCH modelling has been performed on the EURUSD data, followed by rolling window analysis on it.
Firstly, the EURUSD Data was pre-processed using Interpolation technique to take care of the null values present in the data using python. 
Once the data was cleaned up and ready for use, the following steps were carried out:

1.	ADF, PP, and KPSS test on the price observations of EURUSD data. 

| Using Price |	ADF test	|  PP test  |	KPSS test |
| :---: | :---: | :---: | :---: |
| p-value | 0.1261 | 0.05186 | 0.01 |

So, for the ADF and PP test, the H0 (null) hypothesis is that the time series is not stationary and the H1 (alternative) hypothesis is that the time series is stationary. As it can be observed that the p-values obtained for price were greater than 5%, i.e., 12.61% for ADF test and 5.186% for PP test, the H0 hypothesis was accepted. Consequently, when checking for the KPSS test, the p-value obtained was less than 5%, i.e., 1%. In this test, H0 hypothesis is that the time series is stationary, while the H1 hypothesis is that the time series is not stationary. So, as the value of the KPSS test was less than 5%, the H0 hypothesis was rejected. From these three results attained, it was concluded that the price time series was not stationary. Due to this, the first degree of integration of the price observations was done and the similar tests were carried out on that return observations. 

2.  Plot the time series graph of the price values

![image](https://user-images.githubusercontent.com/82383549/209842930-202f1f0e-851b-4aea-920c-505196912a67.png)

3.	Plot the time series graph of the return values 

![image](https://user-images.githubusercontent.com/82383549/209843161-4cc5f806-c9e4-4d4c-9de6-486043e4a876.png)

By plotting these two graphs, it was clearly seen that the price observations were not stationary, while the return observations were stationary, as the mean was 0 and standard deviation 1 throughout. 

4.	ADF, PP, and KPSS test on the return observations of EURUSD data. 

| Using Return |	ADF test |	PP test |	KPSS test |
| :---: | :---: | :---: | :---: |
| p-value |	0.01 | 0.01 |	0.1 |

As we can observe in the table above, the ADF and PP test was less than 5%, and KPSS test was greater then 5%. As a result, it can be substantiated that the time series was stationary, and we can move ahead for analysing and modelling of the data using ARIMA and GARCH models.

5.	Descriptive Statistics of the return observations

| Parameters |	Returns |
| :---: | :---: |
| Nobs	| 3344.000000 |
| NAs	| 0.000000 |
| Minimum	| -0.143324 |
| Maximum	| 0.159632 |
| 1st Quartile	| -0.003396 |
| 3rd Quartile	| 0.003346 |
| Mean	| -0.000061 |
| Median	| 0.000000 |
| Sum	| -0.204390 |
| SE Mean	| 0.000139 |
| LCL Mean	| -0.000334 |
| UCL Mean	| 0.000211 |
| Variance	| 0.000065 |
| Standard Deviation	| 0.008035 |
| Skewness	| 0.654367 |
| Kurtosis	| 95.021583 |

The Basic statistics table above shows 16 parameters about the return data. It shows that there was a total of 3344 observations seen, and no null values were to be found (as we took care of it in the beginning itself!). The minimum return value to be found was -0.143324, while the maximum return value was 0.159632. The mean, median, and sum of the data were -0.000061, 0.000000, -0.204390 respectively. "LCL" and "UCL" stand for lower/upper confidence limits, computed under the null hypothesis of independent and identically distributed. The LCL and UCL mean’s to be found in the data were -0.000334 and 0.000211 respectively. The variance and standard deviation calculated of the data was 0.000065 and 0.008035 respectively. It became clear by looking at the mean and standard deviation that the data exhibit stationarity. The value of skewness, i.e., 0.654367, indicated that the return data was moderately skewed, as it lied between 0.5 and 1. The kurtosis observed in the data was about 95.021583. This showed that the distribution was leptokurtic (fat tailed), as it had an excess kurtosis of more than 0.  

6.	Test for normality
The p-value attained while testing the data for normality was less than 2.2e-16, which meant that the H0 hypothesis (the time series data does not have normality) was rejected and therefore the return values of the data were normal.

7.	Test for autocorrelation
Similarly, when the return values were tested for autocorrelation the p-value recorded was less than 2.2e-16. The H0 hypothesis says that the time series does not have autocorrelation. But as the value was less than 5%, the H0 hypothesis was rejected and the H1 hypothesis accepted i.e., time series entails autocorrelation. 

8.	ARIMA Modelling
Initially the partial autocorrelation function (pacf) and auto correlation function (acf) of the time series data were plotted. The ARIMA models: Model 1 through Model 5 were created with the help auto ARIMA function. The Model 6 and Model 7 were consequently created by manually fixing the lags, which were determined from the pacf and acf graphs, respectively. 

![image](https://user-images.githubusercontent.com/82383549/209843433-fd86b70a-772a-4a96-a15e-b7ebd4a16601.png)

![image](https://user-images.githubusercontent.com/82383549/209843442-1212fbe0-d8c2-4a4e-ab85-a336d65787d8.png)

Model 1: The ARIMA model selected was an AR (2) model (with zero mean), as the auto ARIMA generated the optimal parameter values of (p=2, d=0, q=0), on both Akaike information criterion (aic), and Bayesian information criterion (bic).    

Model 2: The ARIMA model selected was an MA (2) model (with zero mean), as the auto ARIMA generated the optimal parameter values of (p=0, d=0, q=2), on aic.    

Model 3: The ARIMA model selected was an MA (1) model (with zero mean), as the auto ARIMA generated the optimal parameter values of (p=0, d=0, q=1), on bic.    

Model 4: The ARIMA model selected was an ARIMA (1,0,1) model (with zero mean), as the auto ARIMA generated the optimal parameter values of (p=1, d=0, q=1), on aic.    

Model 5: The ARIMA model selected was an ARIMA (0,0,1) model (with zero mean), as the auto ARIMA generated the optimal parameter values of (p=0, d=0, q=1), on bic.    

Model 6: The ARIMA model selected was an ARIMA (8,0,0) model (with zero mean), and the lags were fixed on r(t-1), r(t-2), r(t-7), and r(t-8).    

Model 7: The ARIMA model selected was an ARIMA (0,0,9) model (with zero mean), and the lags were fixed on r(t-1), r(t-7), and r(t-9).    

9.	In case of ARIMA modelling, the forecast evaluation was conducted by considering 50% of the observations as the training set and the remaining 50% observations as the test set. 

The rolling window analysis was used for the back testing of the models in which initially the first 50% observations were used to train the model and forecast 1 observation ahead of the training data (using it as the testing data) [2]. After this was performed, the window was shifted down by a stride of 1 (removing the first observation from the window and including the previous test observation in the window, to predict the next test observation). This way the model was step-by-step trained on the former 50% data to forecast latter 50% of the data (testing data). 

Now this testing data of the 7 models was evaluated with the help of Mean Absolute Error (MAE) and Mean Squared Error (MSE). The following table shows the MAE and MSE attained by the various models.

| Models | MAE (%) |	MSE (%) |
| :---: | :---: | :---: |
| Model 1 |	0.3735856	|	0.002622164 |
| Model 2	|	0.3739174	|	0.002625655 |
| Model 3	|	0.3752014	|	0.002640315 |
| Model 4	|	0.3740866	|	0.002627469 |
| Model 5	|	0.3752014	|	0.002640315 |
| Model 6	|	0.3740381	|	0.002626942 |
| Model 7	|	0.3750563	|	0.002638665 |

As it can be observed in the table above, Model 1 and Model 2 attained the least amount of MAE and MSE percentage. The MAE of the models was low as they performed well in keeping the average error between the predictions and intended targets substantially low. Similarly, the MSE was also low as well, which measured the amount of error in the models and assessed the average squared difference between the observed and predicted values. 

Due to this analysis, it was safely concluded that AR (2) and MA (2) models were the best fit models (mainly AR (2)) for the EURUSD data and can be used for forecasting the future returns. The following equation depicts Model 1:

Model_1 = (-0.2409)Model_1(t-1) + (-0.0832)Model_1(t-2)

Moving ahead, we plotted the forecasts for the test data, which showed how the models behaved. Below are two figures that depict the behaviour of AR (2) and MA (2) models. The plotted forecasts for rest of the models can be found in the program.

![image](https://user-images.githubusercontent.com/82383549/209843659-ea35c2ff-f5df-4b72-82fb-91c4b3840301.png)

![image](https://user-images.githubusercontent.com/82383549/209843668-a8a7d61d-788e-4837-b66d-df61e8927c38.png)

10.	Test for Heteroscedasticity

The ARCH test was used on the return data and residual of the AR (2) model in order to determine the presence or absence of heteroscedasticity, having the significance level of 1%. 

11.	GARCH Modelling

Beginning with the GARCH modelling, we first determined what the GARCH order would be. Running the function of GARCH on return data, it was found that the alpha (ARCH order) and beta (GARCH order) values were both 0.05, stating that the GARCH order of (p, q) was (1,1). Therefore, we used symmetric GARCH, which indicated that there was equal amount of positive news and negative news in the data.

Now as the AR (2) model outperformed all the other models based on MAE and MSE, we consequently used it in determining the ARMA order in GARCH specifications.

The table below shows the optimal parameters of GARCH model using Normal Distribution model.

| OPTIMAL PARAMETERS | ESTIMATE |	PR (> mod(T)) |
| :---: | :---: | :---: |
| MU | 0.000008 |	0.921917 |
| AR1	|	-0.082229	|	0.000016 |
| AR2	|	0.000080	|	0.996596 |
| OMEGA	|	0.000000	|	0.754374 |
| ALPHA1	|	0.048044 | 0.000000 |
| BETA1	|	0.950951 | 0.000000 |

From the table, it was deduced that ar1, alpha1, and beta1 were significant as the values were less than 0.05. Also, omega (constant term), alpha1, and beta1 were positive, and the sum of alpha1 and beta1 was less than 1. Since the GARCH model satisfied all the basic conditions, it substantiated that its robustness. 

The graph below illustrates our previous claim i.e., there is an equal amount of impact of the positive news and negative news observed in the return data. 

![image](https://user-images.githubusercontent.com/82383549/209843994-2539afae-eacd-45f5-8f25-86b3d4e4235b.png)

Similarly, the optimal parameters and the impact of Student’s t Distribution and Skewed Student’s t Distribution models have been done in the program, which depict their robustness’. 

12.	In case of GARCH modelling, the forecast evaluation was conducted by considering 50% of the observations as the training set and the remaining 50% observations as the test set. 

In this section, we will check the performance of how many predicted and actual values are similar. In case our return is more negative (Return << VaR), then we call it as an exception, and therefore we are trying to find out how many such exceptions are there in the data, using the ugarchroll function [2]. This function will help in doing the back testing of the historical data, based on the model that we have specified. 

The functions parameters were set as follows: the training started from 100th observation, so as to avoid the convergence problem. A window of size of 400 was used, which had a moving characteristic, and using this window as the training data, the immediate next value was forecasted. We used a hybrid solver and calculated the VaR, with an alpha of 1% and a confidence level of 99%. 

3 models were used for this, namely: Normal Distribution, Student’s t Distribution, and Skewed Student’s t Distribution. Using the unconventional and conventional coverage provided in the back testing report, we determined that the Normal Distribution model has the best performance. These are the kinds of statistical tests which tell us if the Actual VaR has exceeded the 1% alpha. The H0 hypothesis in both these coverages say: Correct Exceedances and Independence of Failure.  All the models attained a p-value of more than 5%, so we don’t reject the H0 hypotheses in any case. Finally, the Actual VaR exceedance with respect to expected exceedance in Normal Distribution attained a lower ratio when compared against the Student’s t and Skewed Student’s t Distributions. As a result, it showed that utilizing the Normal Distribution model to forecast the values had little deviation, making it a robust model.

The table below shows the ratio of Actual VaR exceed with respect to Expected Exceed for the 3 models.

| MODEL |	ACTUAL% |
| :---: | :---: |
| NORMAL DISTRIBUTION	| 1.20 |
| STUDENT’S T DISTRIBUTION	| 1.33 |
| SKEWED STUDENT’S T DISTRIBUTION	| 1.26 |

The figure below gives us an illustration of the actual values (black lines) and the predicted values (green lines) when using the Normal Distribution model.

![image](https://user-images.githubusercontent.com/82383549/209844181-0b8de9e9-e002-4a91-8463-5c3a785f427f.png)

References:

1.	https://rdrr.io/cran/greybox/man/ro.html
2.	https://www.rdocumentation.org/packages/rugarch/versions/1.4-9/topics/ugarchroll-methods

