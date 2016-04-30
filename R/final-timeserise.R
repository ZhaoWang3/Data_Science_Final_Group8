install.packages("timeDate")
library(timeDate)
install.packages("forecast")
library(forecast)

data1<-read.csv("~/Desktop/total_hawaii.csv",header=FALSE)
#transform data to time series, unit is month, start time ponint is jan 2007
tdata<- ts(data1[[3]],start=c(2007,1), frequency = 12)
#observe trend
plot(tdata)

acf(data1$V3)
#2007-2014 as traindata, 2015 as valitation data
traindata<-window(tdata,start=2007,end=2014+11/12)
testdata<-window(tdata,start=2015)

#Seasonal Decomposition of Time Series by Loess,raw;seasonal;trend;residual term
plot(stl(traindata,s.window="periodic"))  

#use holt-winters
pred_holt<-holt(traindata,h=12,damped=F,initial="simple",beta=0.65)
accuracy(pred_holt)#166
plot(pred_holt)

#use simple exponential smoothing 
pred_ses <- ses(traindata,h=12,initial='simple',alpha=0.2)
accuracy(pred_ses)#123
plot(pred_ses)

pred_naive<-naive(traindata,h=12)
accuracy(pred_naive)#132

pred_snaive<-snaive(traindata,h=12)
accuracy(pred_snaive)#123
plot(pred_snaive)


pred_hw<-hw(traindata,h=12,seasonal='multiplicative')
accuracy(pred_hw)#42.8
plot(pred_hw)

fit1<-ets(traindata)
accuracy(predict(fit1,12),testdata) #42.43
plot(fit1)

#stl+ets(AAN), compare to ets can avoid seasonality being ignored.
pred_stlf<-stlf(traindata)
accuracy(pred_stlf)#34.99
plot(pred_stlf)

fit2<-auto.arima(traindata)
accuracy(forecast(fit2,h=12),testdata) #45
plot(fit2)

ma = arima(traindata, order = c(0, 1, 3),   seasonal=list(order=c(0,1,3), period=12))
p<-predict(ma,12)
accuracy(p$pred,testdata)  #48


