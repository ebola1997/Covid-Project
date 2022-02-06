#Membuat stopwords dan Mengaplikasikan stopwords
myStopwords <- readLines("stopword_list_id.txt") #File stopword dapat diganti sesuai dengan kamus yang anda punya
myStopwords <- c(myStopwords, "c") ##Menghilangkan kata combine pada saat tokenizing

#Menghilangkan kata meminta pada stopwords karena dianggap kata negatif
match("meminta", myStopwords) 
myStopwords[392]

#Menghilangkan kata tidak pada stopwords karena dianggap kata negasi (penyangkalan)
match("tidak", myStopwords)   
myStopwords[726]

# proses
myStopwords <- removeWords(myStopwords, "meminta") 
myStopwords <- removeWords(myStopwords, "tidak")

kamus_stopword <- data.frame( text = myStopwords) #Melihat kumpuluan kata stopword pada dataframe


datastop <- as.character(tokenize) #Mengubah data menjadi karakter agar dapat dilakukan proses stopword
head(datastop,3)

datastop <- removeWords(datastop, myStopwords) # Mengaplikasikan stopword  
head(data.alay$text,3) #kata  yang belum di-stopword
head(datastop,3)

# Menghilangkan tanda pada kata
datastop <- strip(datastop) 

data.stopword <- data.frame(text = datastop) #mengubah data menjadi dataframe

#Alasan tidak menggunakan proses Stemming, karena merubah arti dari kata
head(data.alay,1)
head(data.stemming,1)
head(data.stopword,1)

