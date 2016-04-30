install.packages("data.table")
library(data.table)
install.packages("bit64")
library(bit64)

setwd("/Users/lucy/Desktop/cobming/")
temp<- list.files(pattern="*.csv")
hawaiiset <- do.call(rbind, lapply(temp, fread))
write.csv(hawaiiset,"/Users/lucy/Desktop/hawaiiset-total.csv")
