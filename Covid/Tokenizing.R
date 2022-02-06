#Mengaplikasikan Tokenizing data tweet (memecah data tweet)
tokenize <- tokenize_words(data.alay$text)

#Melihat data yang sudah menjadi bentuk token
head(data.alay$text,1)
head(tokenize,1)

# melihat total kata pada total data tweet
data.token <- as.character(tokenize)
data.token <- data.frame(text=data.token)
View(data.token)
save_as_csv(data.token,"data-token.csv")


# melihat total kata pada setiap data tweet
total_kata <- unnest_tokens(data.alay, input = text, output = word)
# save
write.csv(total_kata, "total_kata_dttoken.csv", row.names = T)

# fungsi token (trigram yang digunakan dalam lexicon)
trigram <- tokenize_ngrams(data.alay$text, n = 3, n_min = 1)
trigram[1]
tokenize[1]
?tokenize_ngrams
