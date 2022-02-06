#Menghilangkan Tweet dari data frame
klasifikasi <- data.lexicon

klasifikasi$total <- as.numeric(klasifikasi$total)
klasifikasi$scores <- as.numeric(klasifikasi$score)
klasifikasi$kelas <- as.factor(klasifikasi$kelas)
klasifikasi$positive <- as.numeric(klasifikasi$positive)
klasifikasi$negative <- as.numeric(klasifikasi$negative)


#Menampilkan plot untuk klasifikasi SVM
qplot(negative, positive, data = klasifikasi,
      color = kelas) + scale_colour_manual(values = c("black", "red", "green")) #Hasil Terbaik


qplot(total, scores, data = klasifikasi, color = kelas)
qplot(positive, scores, data = klasifikasi, color = kelas)
qplot(negative, scores, data = klasifikasi, color = kelas)
qplot(total, positive, data = klasifikasi, color = kelas)
qplot(total, negative, data = klasifikasi, color = kelas)

#Membuat Klasifikasi SVM 
##classification Hyperplane
colors <- c("black", "red", "green")
warna <- as.factor(klasifikasi$kelas)
hyperplane <- klasifikasi[c(2,3,4,5,6)]
hyperplane2 <- scale(hyperplane[, -5]) #Scale untuk standaraisasi Data (Li&Liu)
#memasukan binary C-classification model

#Wilayah negatif
netral <- as.factor(klasifikasi$kelas == "negatif")
binary <- svm(netral ~ negative + positive, 
              data = hyperplane2, kernel = "linear")
# plot data and separating hyperplane
plot(positive~negative, data = hyperplane2, col = colors[factor(warna)])
(cf <- coef(binary))
abline(-cf[1]/cf[3], -cf[2]/cf[3], col = "black") #Tengah
# plot margin
abline(-(cf[1] + 1)/cf[3], -cf[2]/cf[3], col = "Orange") #Positif
abline(-(cf[1] - 1)/cf[3], -cf[2]/cf[3], col = "Red") #Negatif

#Wilayah positif
netral <- as.factor(klasifikasi$kelas == "positif")
binary <- svm(netral ~ negative + positive, 
              data = hyperplane2, kernel = "linear")
(cf <- coef(binary))
abline(-cf[1]/cf[3], -cf[2]/cf[3], col = "black") #Tengah
abline(-(cf[1] + 1)/cf[3], -cf[2]/cf[3], col = "Red") #Positif
abline(-(cf[1] - 1)/cf[3], -cf[2]/cf[3], col = "Black") #Negatif


