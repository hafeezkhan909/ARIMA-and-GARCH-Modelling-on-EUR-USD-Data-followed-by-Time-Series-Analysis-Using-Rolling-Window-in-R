#MOHAMMED ABDUL HAFEEZ KHAN - 2019A7TS0091U

#Import libraries
library(forecast)
library(tseries)
library(fBasics)
library("greybox")
library(FinTS)
library(rugarch)

#Remove all variables from the memory
rm(list=ls()) 

#Set the working directory
setwd("C:\\Users\\HAFEEZ KHAN\\Desktop\\FRAM\\Assignment")

#Read the csv file
data = read.csv("DATA.csv",header = T)

#Extract Prices
price_eurusd = data[,2]

plot(price_eurusd,type="l")
#Test for stationarity at level
'
adf test & pp test: H0: series is not stationary
			              H1: series is stationary

*if p-value<0.05: reject null hypothesis
'

adf.test(price_eurusd)
pp.test(price_eurusd)
'
kpss test:	H0: series is stationary
            H1: series is not staionary
*if p-value<0.05: reject null hypothesis
'
kpss.test(price_eurusd)

#Calculate Log returns
ret_eurusd = diff(log(price_eurusd))

plot(ret_eurusd, type="l")

#Test for Stationarity at 1st Difference
adf.test(ret_eurusd)
pp.test(ret_eurusd)
kpss.test(ret_eurusd)

#Descriptive statistics
basicStats(ret_eurusd)

#Test for normality
jarque.bera.test(ret_eurusd)
#Test for autocorrelation
Box.test(ret_eurusd,10,type="Ljung-Box")

#ARIMA Modeling

#Lag structure of AR Model
pacf(ret_eurusd,10)
auto.arima(ret_eurusd,max.p = 10,max.d = 0, max.q = 0, ic="aic")
auto.arima(ret_eurusd,max.p = 10,max.d = 0, max.q = 0, ic="bic")


#Lag Structure of MA Model
acf(ret_eurusd,10)
auto.arima(ret_eurusd,max.p = 0,max.d = 0, max.q = 10, ic="aic")
auto.arima(ret_eurusd,max.p = 0,max.d = 0, max.q = 10, ic="bic")

#Lag Structure of ARMA Model
auto.arima(ret_eurusd,max.p = 10,max.d = 0, max.q = 10, ic="aic")
auto.arima(ret_eurusd,max.p = 10,max.d = 0, max.q = 10, ic="bic")


#Save the models
model_1 = arima(ret_eurusd, order=c(2,0,0),include.mean = FALSE) #auto.arima(ret_eurusd,max.p = 10,max.d = 0, max.q = 0, ic="aic") and auto.arima(ret_eurusd,max.p = 10,max.d = 0, max.q = 0, ic="bic")
model_2 = arima(ret_eurusd, order=c(0,0,2),include.mean = FALSE) #auto.arima(ret_eurusd,max.p = 0,max.d = 0, max.q = 10, ic="aic")
model_3 = arima(ret_eurusd, order=c(0,0,1),include.mean = FALSE) #auto.arima(ret_eurusd,max.p = 0,max.d = 0, max.q = 10, ic="bic")
model_4 = arima(ret_eurusd, order=c(1,0,1),include.mean = FALSE) #auto.arima(ret_eurusd,max.p = 10,max.d = 0, max.q = 10, ic="aic")
model_5 = arima(ret_eurusd, order=c(0,0,1),include.mean = FALSE) #auto.arima(ret_eurusd,max.p = 10,max.d = 0, max.q = 10, ic="bic")
model_6 = arima(ret_eurusd, order=c(8,0,0), fixed = c(NA,NA,0,0,0,0,NA,NA,0)) #AR[8] induced from graphical analysis
model_7 = arima(ret_eurusd, order=c(0,0,9),fixed = c(NA,0,0,0,0,0,NA,0,NA,0)) #MA[9] induced from graphical analysis

model_1
#Model Diagnostics
Box.test(model_1$residuals,10,type = "Ljung-Box")
#et1 = residuals(model_1)
#acf(et1,10)

Box.test(model_2$residuals,10,type = "Ljung-Box")
#et2 = residuals(model_2)
#acf(et2)

Box.test(model_3$residuals,10,type = "Ljung-Box")
#et3 = residuals(model_3)
#acf(et3)

Box.test(model_4$residuals,10,type = "Ljung-Box")
#et4 = residuals(model_4)
#acf(et4)

Box.test(model_5$residuals,10,type = "Ljung-Box")
#et5 = residuals(model_5)
#acf(et5)

Box.test(model_6$residuals,10,type = "Ljung-Box")
et6 = residuals(model_6)
acf(et6,10)

Box.test(model_7$residuals,10,type = "Ljung-Box")
et7 = residuals(model_7)
acf(et7,10)

'
conducting the forecast evaluation on each model by considering 50% of the observations as the training set and the 
remaining 50% observations as the test set.
'

mean_absolute_error <- function(r){
  se = 0
  for(i in 1:1672){
    j = abs(r$holdout[i] - r$pred[i])
    se = se + j
  }
  mae = (se/1672)*100
  return(mae)
}

mean_squared_error <- function(r){
  sse = 0
  for(i in 1:1672){
    d = (r$holdout[i] - r$pred[i])^2 
    sse = sse + d
  }
  mse = (sse/1672)*100
  return(mse)
}
ourCall1 <- "predict(arima(ret_eurusd, order=c(2,0,0), include.mean = FALSE),n.ahead=h)"
ourValue1 <- "pred"
returnedValues1 <- ro(ret_eurusd, h=1, origins=1672, call=ourCall1, value=ourValue1, ci=TRUE, co=TRUE)

mean_absolute_error(returnedValues1)
mean_squared_error(returnedValues1)
plot(returnedValues1)


ourCall2 <- "predict(arima(ret_eurusd, order=c(0,0,2), include.mean = FALSE),n.ahead=h)"
ourValue2 <- "pred"
returnedValues2 <- ro(ret_eurusd, h=1, origins=1672, call=ourCall2, value=ourValue2, ci=TRUE, co=TRUE)
mean_absolute_error(returnedValues2)
mean_squared_error(returnedValues2)
plot(returnedValues2)


ourCall3 <- "predict(arima(ret_eurusd, order=c(0,0,1),include.mean = FALSE),n.ahead=h)"
ourValue3 <- "pred"
returnedValues3 <- ro(ret_eurusd, h=1, origins=1672, call=ourCall3, value=ourValue3, ci=TRUE, co=TRUE)
mean_absolute_error(returnedValues3)
mean_squared_error(returnedValues3)
plot(returnedValues3)


ourCall4 <- "predict(arima(ret_eurusd, order=c(1,0,1),include.mean = FALSE),n.ahead=h)"
ourValue4 <- "pred"
returnedValues4 <- ro(ret_eurusd, h=1, origins=1672, call=ourCall4, value=ourValue4, ci=TRUE, co=TRUE)
mean_absolute_error(returnedValues4)
mean_squared_error(returnedValues4)
plot(returnedValues4)


ourCall5 <- "predict(arima(ret_eurusd, order=c(0,0,1),include.mean = FALSE),n.ahead=h)"
ourValue5 <- "pred"
returnedValues5 <- ro(ret_eurusd, h=1, origins=1672, call=ourCall5, value=ourValue5, ci=TRUE, co=TRUE)
mean_absolute_error(returnedValues5)
mean_squared_error(returnedValues5)
plot(returnedValues5)
#apply(abs(returnedValues4$holdout - returnedValues4$pred),1,mean,na.rm=TRUE) / mean(returnedValues4$actuals)

ourCall6 <- "predict(arima(ret_eurusd, order=c(8,0,0), fixed = c(NA,NA,0,0,0,0,NA,NA,0)),n.ahead=h)"
ourValue6 <- "pred"
returnedValues6 <- ro(ret_eurusd, h=1, origins=1672, call=ourCall6, value=ourValue6, ci=TRUE, co=TRUE)
mean_absolute_error(returnedValues6)
mean_squared_error(returnedValues6)
plot(returnedValues6)

ourCall7 <- "predict(arima(ret_eurusd, order=c(0,0,9),fixed = c(NA,0,0,0,0,0,NA,0,NA,0)),n.ahead=h)"
ourValue7 <- "pred"
returnedValues7 <- ro(ret_eurusd, h=1, origins=1672, call=ourCall7, value=ourValue7, ci=TRUE, co=TRUE)
mean_absolute_error(returnedValues7)
mean_squared_error(returnedValues7)
plot(returnedValues7)

#Recursive Prediction (One Day Ahead)
predict(model_1,1)
predict(model_2,1)
predict(model_3,1)
predict(model_4,1)
predict(model_5,1)
predict(model_6,1)
predict(model_7,1)
#Recursive Prediction (One Week Ahead)
predict(model_1,5)
predict(model_2,5)
predict(model_3,5)
predict(model_4,5)
predict(model_5,5)
predict(model_6,5)
predict(model_7,5)
#ARCH & GARCH Modelling

#ARCH Test
arch = ArchTest(ret_eurusd,10)
arch
plot.ts(ret_eurusd)
#plot.ts(model_1$residuals)

garch(x=ret_eurusd, grad="numerical", trace=FALSE)
#garch(x=model_1$residuals, grad="numerical", trace=FALSE)

#Use the return series
#1. Normal Distribution
spec1 =ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1, 1)),
                  mean.model = list(armaOrder = c(2, 0)),
                  distribution.model = "norm")
garch_fit_1 = ugarchfit(spec = spec1, data = ret_eurusd)
garch_fit_1

new_model1 = newsimpact(garch_fit_1)
plot(new_model1$zx, new_model1$zy, ylab=new_model1$yexpr, new_model1$xepr, main="News Impact Curve")

mod_garch1 = ugarchroll(spec1, data = ret_eurusd, n.start = 100, refit.every = 1, refit.window = "moving", window.size = 400, calculate.VaR = TRUE, VaR.alpha = 0.01, solver="hybrid", keep.coef = TRUE)

mod_garch1
report(mod_garch1, type = "VaR", VaR.alpha = 0.01, conf.level = 0.99)

mod_garch1@forecast$VaR[,1]
mod_VaR <- zoo(mod_garch1@forecast$VaR[,1])

mod_actual <- zoo(mod_garch1@forecast$VaR[,2])
plot(mod_actual, type='b', main="Backtesting", xlab="Values", ylab="VaR%")
lines(mod_VaR, col="green")

#2. Standard Deviation model
spec2 =ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1, 1)),
                  mean.model = list(armaOrder = c(2, 0)),
                  distribution.model = "std")
garch_fit_2 = ugarchfit(spec = spec2, data = ret_eurusd)
garch_fit_2

new_model2 = newsimpact(garch_fit_2)
plot(new_model2$zx, new_model2$zy, ylab=new_model2$yexpr, new_model2$xepr, main="News Impact Curve")

mod_garch2 = ugarchroll(spec2, data = ret_eurusd, n.start = 100, refit.every = 1, refit.window = "moving", window.size = 400, calculate.VaR = TRUE, VaR.alpha = 0.01, solver="hybrid", keep.coef = TRUE)

mod_garch2
report(mod_garch2, type = "VaR", VaR.alpha = 0.01, conf.level = 0.99)

mod_garch2@forecast$VaR[,1]
mod_VaR2 <- zoo(mod_garch2@forecast$VaR[,1])

mod_actual2 <- zoo(mod_garch2@forecast$VaR[,2])
plot(mod_actual2, type='b', main="Backtesting", xlab="Date", ylab="VaR%")
lines(mod_VaR2, col="green")

#3. Squared Standard Deviation model
spec3 =ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1, 1)),
                  mean.model = list(armaOrder = c(2, 0)),
                  distribution.model = "sstd")
garch_fit_3 = ugarchfit(spec = spec3, data = ret_eurusd)
garch_fit_3

new_model3 = newsimpact(garch_fit_3)
plot(new_model3$zx, new_model3$zy, ylab=new_model3$yexpr, new_model3$xepr, main="News Impact Curve")

mod_garch3 = ugarchroll(spec3, data = ret_eurusd, n.start = 100, refit.every = 1, refit.window = "moving", window.size = 400, calculate.VaR = TRUE, VaR.alpha = 0.01, solver="hybrid", keep.coef = TRUE)

mod_garch3
report(mod_garch3, type = "VaR", VaR.alpha = 0.01, conf.level = 0.99)

mod_garch3@forecast$VaR[,1]
mod_VaR3 <- zoo(mod_garch1@forecast$VaR[,1])

mod_actual3 <- zoo(mod_garch1@forecast$VaR[,2])
plot(mod_actual3, type='b', main="Backtesting", xlab="Date", ylab="VaR%")
lines(mod_VaR3, col="green")