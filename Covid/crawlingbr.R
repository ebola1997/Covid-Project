
  mining3 <- search_tweets("\\dampak covid\\,ekonomi",
                          n=1000, 
                          lang = "id",
                          include_rts = FALSE,
                          tweet_mode = "extended")
  
  
  mining4 <- search_tweets("covid ekonomi OR dampak covid ekonomi", 
                          n=2000, 
                          lang = "id",
                          include_rts = FALSE,
                          tweet_mode = "extended")

  datacrawlingbr <- mining4[c("created_at","text")]
  save_as_csv(datacrawlingbr,"crawlingbr.csv")
  
  read.csv(file.choose(), header = T)
  databaru <- read.csv(file.choose(), header = T)

  
  dataraw1 <- "dampak covid membuat ekonomi masyarakat Indonesia hancur"
  dataraw2 <- "dampak covid menjadi beban ekonomi masyarakat Indonesia"
  dataraw3 <- "dampak covid membuat ekonomi pemerintah meningkat, semakin makmur dan penuh kebahagiaan"
  dataraw4 <- "dampak covid membuat ekonomi usaha farmasi meningkat, maju dan sukses"
  dataraw5 <- c(dataraw1,dataraw2,dataraw3,dataraw4)
  
  predict(bestmodel, score.sentiment(dataraw5, positif, negatif))  

  
  
  
  datahari1 <- data.frame(text=dataraw5,label=predict(bestmodel, score.sentiment(dataraw5, positif, negatif)))  
  
  table(datahari1$label)
  
  datahari26 <- read.csv(file.choose(), header = TRUE)
  datasethari26 <- datahari26 %>% select(text)
  datasethari26 <- data.frame(text=datasethari26$text,label=predict(bestmodel, score.sentiment(datasethari26$text, positif, negatif)))
  
  
  datahari27 <- read.csv(file.choose(), header = TRUE)
  datasethari27 <- datahari27 %>% select(text)
  datasethari27 <- data.frame(text=datasethari27$text,label=predict(bestmodel, score.sentiment(datasethari27$text, positif, negatif)))
  
  datahari28 <- read.csv(file.choose(), header = TRUE)
  datasethari28 <- datahari28 %>% select(text)
  datasethari28 <- data.frame(text=datasethari28$text,label=predict(bestmodel, score.sentiment(datasethari28$text, positif, negatif)))
  
  datahari29 <- read.csv(file.choose(), header = TRUE)
  datasethari29 <- datahari29 %>% select(text)
  datasethari29 <- data.frame(text=datasethari29$text,label=predict(bestmodel, score.sentiment(datasethari29$text, positif, negatif)))
  
  datahari30 <- read.csv(file.choose(), header = TRUE)
  datasethari30 <- datahari30 %>% select(text)
  datasethari30 <- data.frame(text=datasethari30$text,label=predict(bestmodel, score.sentiment(datasethari30$text, positif, negatif)))
  
  datahari1okt <- read.csv(file.choose(), header = TRUE)
  datasethari1okt <- datahari1okt %>% select(text)
  datasethari1okt <- data.frame(text=datasethari1okt$text,label=predict(bestmodel, score.sentiment(datasethari1okt$text, positif, negatif)))
  
  datahari2okt <- read.csv(file.choose(), header = TRUE)
  datasethari2okt <- datahari2okt %>% select(text)
  datasethari2okt <- data.frame(text=datasethari2okt$text,label=predict(bestmodel, score.sentiment(datasethari2okt$text, positif, negatif)))
  
  datahari3okt <- read.csv(file.choose(), header = TRUE)
  datasethari3okt <- datahari3okt %>% select(text)
  datasethari3okt <- data.frame(text=datasethari3okt$text,label=predict(bestmodel, score.sentiment(datasethari3okt$text, positif, negatif)))
  
  datahari4okt <- read.csv(file.choose(), header = TRUE)
  datasethari4okt <- datahari4okt %>% select(text)
  datasethari4okt <- data.frame(text=datasethari4okt$text,label=predict(bestmodel, score.sentiment(datasethari4okt$text, positif, negatif)))
  
  datahari5okt <- read.csv(file.choose(), header = TRUE)
  datasethari5okt <- datahari5okt %>% select(text)
  datasethari5okt <- data.frame(text=datasethari5okt$text,label=predict(bestmodel, score.sentiment(datasethari5okt$text, positif, negatif)))
  
  table(datasethari5okt$label)

  # menampilkan frekuensi tweet
  mining4 %>% ts_plot(by = "days") +
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
      x = "Waktu Dalam Hari",
      # Berikan label untuk y
      y = "Frekuensi Tweet",
      # Berikan judul
      title = "Frekuensi Tweet Dengan Kata Kunci Dampak covid + ekonomi",
      # Memberi caption
      caption = paste0("Sumber: Twitter, Tanggal: ", "26 September - 5 Oktober, 2021"))  
  