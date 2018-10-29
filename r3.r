#Decision Tree for prediction. Used iris dataset

library(rpart)
library("rpart.plot")

X=read.csv(file.choose())
dataset= X[,c(4,9)]
# install.packages('caTools')
library(caTools)

set.seed(29)
split = sample.split(dataset$MemberType, SplitRatio = 0.75)
train = subset(dataset, split == TRUE)
test = subset(dataset, split == FALSE)


#model for decision tree. using variable, "dtm"
dtm = rpart(MemberType~., train, method = "class")

#plot decision tree
rpart.plot(dtm)

#addign various parameter.
rpart.plot(dtm, type=4, extra=101)

p <-predict(dtm, test, type = "class")
table(test[,2], p)


