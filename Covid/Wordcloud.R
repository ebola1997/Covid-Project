#Membuat WordCloud
class(skripsi)
awankata <- as.character(datastop)
wordcloud(awankata)

#Membuat wordcloud dengan warna
wordcloud(awankata, min.freq = 2,max.words=1000,random.order=F,colors=brewer.pal(8,"Dark2"))


wordcloud(metal, min.freq = 2,max.words=1000,random.order=F,colors=brewer.pal(8,"Dark2"))

awankata <- str_c(datastop, collapse = " ")
frekuensikata <- 
  Corpus(VectorSource(awankata)) %>%
  TermDocumentMatrix() %>%
  as.matrix()
frekuensikata <- sort(rowSums(frekuensikata), decreasing=TRUE)
frekuensikata <- data.frame(kata = names(frekuensikata), frekuensi=frekuensikata, row.names = NULL)
wordcloud <- wordcloud2(data = frekuensikata, size = 1, shape = 'circle', color = "random-dark", 
                        minRotation = 1, maxRotation = 0)
wordcloud

