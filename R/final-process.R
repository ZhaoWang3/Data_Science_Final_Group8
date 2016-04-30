#read the data and keep nine decimal places,the units of data is billion
data1<-read.csv("~/Desktop/total_hawaii.csv")
data1.fulldigits <- format(data1, digits = 20)
#import the time date
datatem<-read.csv("~/Desktop/time.csv")
#Add month and year data into dataset
tem<-datatem
data1<-data.frame(tem,data1.fulldigits)
#import the temperature and vacation date
datatem2<-read.csv("~/Desktop/temperature&vacation.csv")
#Add temperature data into dataset
tem<-datatem2
data1<-data.frame(data2,tem)
#clear missing data
data1<-na.omit(data1)
write.csv(data1,"/Users/lucy/Desktop/total_hawaii.csv")