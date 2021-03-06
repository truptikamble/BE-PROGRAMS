library("datasets")
data("iris")
names(iris)
str(iris)
dim(iris)
max(iris$Sepal.Length)
min(iris$Sepal.Length)
sd(iris$Sepal.Length)
var(iris$Sepal.Length)
range(iris$Sepal.Length)
mean(iris$Sepal.Length)
apply(iris[1:4], MARGIN=2, quantile)  
quantile(iris$Sepal.Length)
hist(iris$Sepal.Length)
boxplot(iris$Sepal.Length)
boxplot(iris[,-5])
