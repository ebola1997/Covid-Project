#Menghilangkan Tweet dari data frame
klasifikasi <- data.lexicon

klasifikasi$total <- as.numeric(klasifikasi$total)
klasifikasi$scores <- as.numeric(klasifikasi$score)
klasifikasi$kelas <- as.factor(klasifikasi$kelas)
klasifikasi$positive <- as.numeric(klasifikasi$positive)
klasifikasi$negative <- as.numeric(klasifikasi$negative)


#Menampilkan plot untuk klasifikasi SVM
qplot(positive, negative, data = klasifikasi,
      color = kelas) #Hasil Terbaik

qplot(total, scores, data = klasifikasi, color = kelas)
qplot(positive, scores, data = klasifikasi, color = kelas)
qplot(negative, scores, data = klasifikasi, color = kelas)
qplot(total, positive, data = klasifikasi, color = kelas)
qplot(total, negative, data = klasifikasi, color = kelas)

#Membuat Klasifikasi SVM 
##classification Hyperplane
netral <- as.factor(klasifikasi$kelas == "negatif")
warna <- as.factor(klasifikasi$kelas)
hyperplane <- klasifikasi[c(2,3,4,5,6)]
hyperplane2 <- scale(hyperplane[, -5]) #Scale untuk standaraisasi Data (Li&Liu)
#memasukan binary C-classification model
#Wilayah negatif
binary <- svm(netral ~ positive + negative, 
              data = hyperplane2, kernel = "linear")
# plot data and separating hyperplane
plot(negative~positive, data = hyperplane2, col = warna)
(cf <- coef(binary))
abline(-cf[1]/cf[3], -cf[2]/cf[3], col = "black") #Tengah
# plot margin and mark support vectors
abline(-(cf[1] + 1)/cf[3], -cf[2]/cf[3], col = "Black") #Positif
abline(-(cf[1] - 1)/cf[3], -cf[2]/cf[3], col = "Red") #Negatif

#Wilayah positif
netral <- as.factor(klasifikasi$kelas == "positif")
binary <- svm(netral ~ positive + negative, 
              data = hyperplane2, kernel = "linear")
(cf <- coef(binary))
abline(-cf[1]/cf[3], -cf[2]/cf[3], col = "black") #Tengah
abline(-(cf[1] + 1)/cf[3], -cf[2]/cf[3], col = "Red") #Positif
abline(-(cf[1] - 1)/cf[3], -cf[2]/cf[3], col = "Black") #Negatif

###Hyperplane pada label Aspek
iseng <- data.aspect[c(2,3,4,5,6,7)]
iseng2 <- iseng[,-5]
iseng3 <- scale(iseng2[, -5])
iseng4 <- data.frame(iseng3)
iseng4$aspek <- iseng2$aspek
iseng4$kelas <- iseng$kelas

qplot(total, scores, data = iseng4, color = aspek)

penanda <- as.factor(data.aspect$aspek)
plot(scores~total, data = iseng4, col = penanda)


# plot data and separating hyperplane
plot(scores~total, data = iseng4, col = penanda)
netral <- as.factor(klasifikasi$kelas == "negatif")
binary <- svm(netral ~ total + scores, 
              data = iseng4, kernel = "linear")
(cf <- coef(binary))
abline(-cf[1]/cf[3], -cf[2]/cf[3], col = "black") #Tengah
abline(-(cf[1] + 1)/cf[3], -cf[2]/cf[3], col = "Red") 
abline(-(cf[1] - 1)/cf[3], -cf[2]/cf[3], col = "Red")
##
netral <- as.factor(klasifikasi$kelas == "positif")
binary <- svm(netral ~ total + scores, 
              data = iseng3, kernel = "linear")
(cf <- coef(binary))
abline(-cf[1]/cf[3], -cf[2]/cf[3], col = "black") #Tengah
abline(-(cf[1] + 1)/cf[3], -cf[2]/cf[3], col = "Red") 
abline(-(cf[1] - 1)/cf[3], -cf[2]/cf[3], col = "Red")
