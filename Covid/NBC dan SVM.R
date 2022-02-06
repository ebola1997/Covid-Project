##Pembagian data 60:40
#Pembagian data dibagi secara random
library(caTools)
set.seed(123)
split = sample(1:nrow(data.aspect), 0.60*nrow(data.aspect))
datalatih = data.frame(data.aspect)[split,]
datauji= data.frame(data.aspect)[-split,]
table(datalatih$kelas)
table(datauji$kelas)
table(data.lexicon$kelas)
datalatih$kelas <- as.factor(datalatih$kelas)
datauji$kelas <- as.factor(datauji$kelas)
##Parameter data yang digunakan untuk SVM
parameter1 = c("total", "positive", "negative", "scores", "kelas")
parameter2 = c("positive", "negative", "kelas")


datalatih <- datalatih[,parameter1]
datauji <- datauji[,parameter1]

#Naive Bayes Classifier pada faktor sentimen
modelNBC <- naiveBayes(kelas~ positive + negative, data = datalatih, threshold = 0.001, eps = 1)
print(modelNBC)
prediksi <- predict(modelNBC, datauji[, parameter2], type = "class") 
print(prediksi)
tabel <- table(Prediksi = prediksi, Aktual = datauji$kelas)
tabel
cfm <- confusionMatrix(tabel)
cfm

##Klasifikasi SVM Radial
#Latih svm 
modelSVM1 <- svm(kelas~positive+negative, data = datalatih, kernel = "radial", cost = .1, scale = TRUE)
print(modelSVM1)
plot(modelSVM1, datalatih[, parameter2])
latih <- predict(modelSVM1, datalatih[, parameter2])
tabel <- table(Aktual = datalatih$kelas, Prediksi = latih)
tabel
confusionMatrix(tabel)
#Uji svm
tuned <- tune(svm, kelas~positive+negative, data = datauji, kernel = "radial", ranges= list(gamma=seq(0,10,1), cost=c(0.000001,0.00001,0.0001,0.001,0.01,.1,1,10,10)))
summary(tuned)
modelterbaik <- tuned$best.model
summary(modelterbaik)
svmuji <- predict(modelterbaik, datauji[,parameter2])
svmuji
plot(bestmodel, datauji[,parameter2])
plot(svmuji)
radial <- table(Aktual = datauji$kelas, Prediksi = svmuji) #Tabel Confusion
radial
confusionMatrix(radial)

##Klasifikasi SVM Linear
#Latih svm 
modelSVM2 <- svm(kelas~positive+negative, data = datalatih, kernel = "linear", cost = .1, scale = TRUE)
print(modelSVM2)
plot(modelSVM2, datalatih[, parameter2])
latih <- predict(modelSVM2, datalatih[, parameter2])
tabel <- table(Aktual = datalatih$kelas, Prediksi = latih)
tabel
confusionMatrix(tabel)
#Uji svm
tuned <- tune(svm, kelas~positive+negative, data = datauji, kernel = "linear", ranges= list(gamma=seq(0,10,1), cost=c(0.000001,0.00001,0.0001,0.001,0.01,.1,1,10,10)))
summary(tuned)
plot(tuned)
modelterbaik <- tuned$best.model
summary(modelterbaik)
svmuji2 <- predict(modelterbaik, datauji[,parameter2])
svmuji2
plot(modelterbaik, datauji[,parameter2])
plot(svmuji2)
linear <- table(Aktual = datauji$kelas, Prediksi = svmuji2) #Tabel Confusion
linear
confusionMatrix(linear)

##Klasifikasi SVM Sigmoid
#Latih svm 
modelSVM3 <- svm(kelas~positive+negative, data = datalatih, kernel = "sigmoid", cost = .1, scale = TRUE)
print(modelSVM3)
plot(modelSVM3, datalatih[, parameter2])
latih <- predict(modelSVM3, datalatih[, parameter2])
tabel <- table(Aktual = datalatih$kelas, Prediksi = latih)
tabel
confusionMatrix(tabel)
#Uji svm2* (80%*67%) / ( 80% + 67%) 
tuned <- tune(svm, kelas~positive+negative, data = datauji, kernel = "sigmoid", ranges= list(gamma=seq(0,10,1), cost=c(0.000001,0.00001,0.0001,0.001,0.01,.1,1,10,10)))
summary(tuned)
plot(tuned)
modelterbaik <- tuned$best.model
summary(modelterbaik)
svmuji3 <- predict(modelterbaik, datauji[,parameter2])
svmuji3
plot(modelterbaik, datauji[,parameter2])
plot(svmuji3)
sigmoid <- table(Aktual = datauji$kelas, Prediksi = svmuji3) #Tabel Confusion
sigmoid
confusionMatrix(sigmoid)

##Klasifikasi SVM polynomial
#Latih svm 
modelSVM4 <- svm(kelas~positive+negative, data = datalatih, kernel = "polynomial", cost = .1, scale = TRUE)
print(modelSVM4)
plot(modelSVM4, datalatih[, parameter2])
latih <- predict(modelSVM4, datalatih[, parameter2])
tabel <- table(Aktual = datalatih$kelas, Prediksi = latih)
tabel
confusionMatrix(tabel)
#Uji svm
tuned <- tune(svm, kelas~positive+negative, data = datalatih, kernel = "polynomial", ranges= list(gamma=seq(0,10,1), cost=c(0.000001,0.00001,0.0001,0.001,0.01,.1,1,10,10)))
summary(tuned)
plot(tuned)
modelterbaik <- tuned$best.model
summary(modelterbaik)
svmuji4 <- predict(modelterbaik, datalatih[,parameter2])
svmuji4
plot(modelterbaik, datalatih[,parameter2])
plot(svmuji4)
polynomial <- table(Aktual = datalatih$kelas, Prediksi = svmuji4) #Tabel Confusion
polynomial
confusionMatrix(polynomial)
