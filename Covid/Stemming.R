####Tidak digunakan karena merubah makna pada data


#Memasukan Kata Dasar Bahasa Indonesia
katadasaR("kemiskinan") #Contoh = Akan Menghasilkan kata Miskin
katadasar("menekan") #Contoh kalimat yang tidak memiliki makna setelah proses Stemming

skripsi <- as.character(data.alay$text)
#Menghapus kata imbuhan dan mengganti jadi kata dasar
#Menambahkan Fungsi stemming pada R
stemming <- function(x){paste(lapply(x,katadasar),collapse = " ")}

#Mengaplikasikan fungsi stemming pada data tweet
skripsi <- lapply(tokenize_words(skripsi[]), stemming)
skripsi[4] #contoh tweet yang sudah di stemming (angka 32 adalah contoh tweet 32)


#Mengganti manual data yang tidak normal
skripsi[4] <- "ppkm panjang sampe agustus pilih masyarakat dan pemerintah adalah sama yaitu antara hadap ancam selamat jiwa akibat covid dan hadap ancam ekonomi hilang mata cari dan kerja kata jokowi"

data.stemming <- data.frame(text = skripsi)

save_as_csv(data.stemming, "data.stemming")

# Stemming tidak dipakai karena dapat mengubah makna pada kata
