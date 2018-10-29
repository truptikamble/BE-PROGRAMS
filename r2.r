dataset=read.csv(file.choose())
dataset=dataset[,c(6,8,9)]
dataset$Outcome=factor(dataset$Outcome,levels = c(0,1))
library(caTools)
split=sample.split(dataset$Outcome,SplitRatio = 0.75)
train=subset(dataset,split==TRUE)
test=subset(dataset,split==FALSE)
library(e1071)
classifier=naiveBayes(x=train[-3],y=train$Outcome)
y_pred=predict(classifier,newdata = test[-3])
confusionMatrix=table(test[,3],y_pred)
confusionMatrix
