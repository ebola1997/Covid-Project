#Proses lexicon


#Memasukan kamus lexicon positif dan negatif ke dalam bentuk dataframe
positif <- read.csv(file.choose(), header = F)
negatif <- read.csv(file.choose(), header = F)
positif <- as.character(positif$V1)
negatif <- as.character(negatif$V1)
#Menambahkan kata baru pada kamus berdasarkan data
positif = c(positif,"suka","nice","sembuh"
            ,"ekonomi maju", "ekonomi pulih", "pemulihan ekonomi", "bangkitkan ekonomi")
negatif = c(negatif, "payah", "meminta", "covid", "terancam",
                 "ekonomi turun", "tidak kerja", "dirumahkan", "pecat", "dipecat", "ekonomi rusak", "tidak makan",
             "koruptor", "kemelesetan ekonomi", "krisis covid", "krisis covid ekonomi", "ekonomi berantakan", "ekonomi krisis"
             , "ancaman ekonomi", "ekonomi mendek","kecam", "minta")

kamus_positif = data.frame(positif)
kamus_negatif = data.frame(negatif)

##Pencocokan data pada kamus lexicon dengan bantuan ngram - trigram karena terdapat 3 kata pada kamus
data = data.frame(text = datastop)


score.sentiment = function(data, positif, negatif, .progress='none')
{
  require(plyr)
  require(stringr)
  sentimen = laply(data, function(datastop, positif, negatif) {
    tokenizing <- tokenize_ngrams(datastop, n = 3, n_min = 1)
    words <- unlist(tokenizing)
    pos.matches = match(words, positif)
    neg.matches = match(words, negatif)
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    sentimen = sum(pos.matches) + sum(neg.matches)
    return(sentimen)
  }, positif, negatif, .progress=.progress)
  require(plyr)
  require(stringr)
  positif = laply(data, function(datastop, positif, negatif) {
    tokenizing <- tokenize_ngrams(datastop, n = 3, n_min = 1)
    words <- unlist(tokenizing)
    pos.matches = match(words, positif)
    neg.matches = match(words, negatif)
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    positif = sum(pos.matches)
    return(positif)
  }, positif, negatif, .progress=.progress)
  require(plyr)
  require(stringr)
  negatif = laply(data, function(datastop, positif, negatif) {
    tokenizing <- tokenize_ngrams(datastop, n = 3, n_min = 1)
    words <- unlist(tokenizing)
    pos.matches = match(words, positif)
    neg.matches = match(words, negatif)
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    negatif = sum(neg.matches)
    return(negatif)
  }, positif, negatif, .progress=.progress)
  require(plyr)
  require(stringr)
  scores = laply(data, function(datastop, positif, negatif) {
    tokenizing <- tokenize_ngrams(datastop, n = 3, n_min = 1)
  words <- unlist(tokenizing)
  pos.matches = match(words, positif)
  neg.matches = match(words, negatif)
  pos.matches = !is.na(pos.matches)
  neg.matches = !is.na(neg.matches)
  scores = sum(pos.matches) + sum(neg.matches)
  return(scores)
}, positif, negatif, .progress=.progress)
  scores.df = data.frame(text=data,
                         total=sentimen, 
                         positive=positif, 
                         negative=negatif, 
                         scores = positif - negatif)
  return(scores.df)
}



data.lexicon = score.sentiment(data$text, positif, negatif)
View(data.lexicon)

#Pemberian label kelas berdasarkan hasil score
data.lexicon$kelas <- ifelse(data.lexicon$score<0, "negatif",ifelse(data.lexicon$score==0,"netral","positif"))

save_as_csv(data.lexicon, "data_label.csv")

table(data.lexicon$kelas)

#Melihat total data dalam bentuk angka
sum(data.lexicon$total) #Hasil seluruh sentimen
sum(data.lexicon$score==0) #Hasil Sentimen Netral
sum(data.lexicon$score<0) #Hasil Sentimen Negatif
sum(data.lexicon$score>0) #Hasil Sentimen Positif

sum(data.lexicon$positive) #Melihat total kata positif
sum(data.lexicon$negative) #Melihat total kata negatif

##Data Aspect-based dilakukan secara manual berdasarkan kriteria tertentu
data.aspect <- read.csv(file.choose(), header = T)
