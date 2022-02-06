#Meminta izin kepada twitter dengan meruning berikut:
##Autenti via web
token <- create_token(
  app = "Tedi_Covid19",
  consumer_key = "LyfTOhXH7ztBjrkBtTuLj9sJ1",  
  consumer_secret = "9rbDm5zBj4gcdJdbEsUHWjOkPial6659ZOLVRiqeOH92bEHjR8",
  access_token = "821731748-Puj571UdBp0yW6x9RkskKKJu2bkANNJlA0PKzKee",
  access_secret = "iBP9OOcVH8fY22EJk9HNm76AIf1JRmD7FObz3kBrKDf5d")
identical(token,get_token())

#Mencari tweet tentang kata yang ada perlukan (covid)
## tweets adalah nama data anda pada R (nama dapat diganti)
#n = jumlah, include_rts = data retweet diambil (jika iya = TRUE, jika tidak = FALSE), dan lang = bahasa
## jika ingin info lebih lanjut coding "?search_tweets" untuk lebih jelas (tanpa tanda kutip ")

mining <- search_tweets("covid ekonomi OR dampak covid ekonomi", 
                        n=2000, 
                        lang = "id",
                        include_rts = TRUE,
                        tweet_mode = "extended")

mining %>% ts_plot(by = "hours") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold.italic", colour = "black")) +
  theme(panel.background = element_rect(fill = "white"),
    plot.background = element_rect(
    fill = "white",
    colour = "black",
    size = 3
    )
  ) +
  labs(
    # Berikan label untuk x
    x = "Waktu Dalam Jam",
    # Berikan label untuk y
    y = "Frekuensi Tweet",
    # Berikan judul
    title = "Frekuensi Tweet Dengan Kata Kunci Dampak covid + ekonomi",
    # Memberi sub-judul
    subtitle = "per hari",
    # Memberi caption
    caption = paste0("Sumber: Twitter, Tanggal: ", "21-08-02"))


#Mengambil data text
covid <- mining %>% select(text)
head(covid,10)
View(covid)

#Melihat hasil
mining$text[67]

##save datanya ke dalam bentuk rds
saveRDS(covid,file = 'tweet-mentah.rds')

##Save datanya ke dalam bentuk csv (excel)
##Data akan disimpan kedalam folder documents
save_as_csv(mining, "covid_mining.csv")


Selesai
######################################
##Load dataset rds
tweet <- readRDS('tweet-mentah.rds')

##Load dataset csv / excel ##Anda dapat membaca data lain
tweets <- read.csv('covid_mining.csv')





