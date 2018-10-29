data = read.csv(file.choose())
data = data[,c(1,5)]
names(data)
data$date = as.Date(data$date)
df = data.frame(date = data$date , snowfall = data$snowfall,
                year = as.numeric(format(data$date , format="%Y")),
                month = as.numeric(format(data$date, format="%m")),
                day = as.numeric(format(data$date , format = "%d")))
head(df,n=21)
maxSubset = subset(df , year==2018)
maxSnow = which.max(maxSubset$snowfall)
maxSubset[maxSnow,]
weekdays(maxSubset[maxSnow,1])
