#install.packages("mlbench")
library(mlbench)
library(caret)
data("BostonHousing")


smp_size <- floor(0.75 * nrow(BostonHousing))

## set the seed to make your partition reproducible
rmsev<-c()
rmse1v<-c()

for (i in 1:100){
set.seed(i)
train_ind <- sample(seq_len(nrow(BostonHousing)), size = smp_size)

train <- BostonHousing[train_ind, ]
test <- BostonHousing[-train_ind, ]



fit_lg<-train(medv~.,data=train,method="glm")

pred = predict(fit_lg, newdata=test)
#pred
mean_abs_error<-mean(abs((pred-test$medv)/test$medv))
rsq<-sqrt(mean(abs((pred-test$medv)/test$medv)^2))
rmse1<-(1/length(pred))*sum((pred-test$medv)^2)


ctrl <- trainControl(method = "repeatedcv", number = 10, savePredictions = TRUE)

mod_fit <- train(medv~.,  data=train, method="glm", family="gaussian",
                 trControl = ctrl, tuneLength = 5)



train1<-train[train$chas==0,names(train)!='chas']
train2<-train[train$chas==1,names(train)!='chas']
fit_lg1<-train(medv~.,data=train1,method="glm")
fit_lg2<-train(medv~.,data=train2,method="glm")
vect_pred1<-predict(fit_lg1,newdata=test[test$chas==0,names(train)!='chas'])
vect_pred2<-predict(fit_lg2,newdata=test[test$chas==1,names(train)!='chas'])
vect_pred<-c(vect_pred1,vect_pred2)
vect_real<-c(test[test$chas==0,names(test)=='medv'],test[test$chas==1,names(test)=='medv'])

rmse<-(1/length(vect_pred))*sum((vect_pred-vect_real)^2)
rmsev[i]<-rmse
rmse1v[i]<-rmse1
print(i)
}


mean(abs(rmsev-rmse1v))

mean(rmsev-rmse1v)



###########

dataset<-BostonHousing

#Make train and test sets.  Test set will be the holdout set on which we compare the models.
set.seed(123)
train_ind <- sample(seq_len(nrow(BostonHousing)), size = smp_size)
train <- dataset[train_ind, ]
test <- dataset[-train_ind, ]


#First make model with dataset as it is:

fit_lg<-train(medv~.,data=train,method="glm")



#Make all models partitioning by factor variables






# 
# View(cbind(test,pred))
# 
# 
# pred_train<-predict(fit_lg, newdata=train)
# rmse_train<-(1/length(pred_train))*sum((pred_train-train$medv)^2)
# sqrt(rmse_train)

