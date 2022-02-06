#Preprocess Cleansing
#Menghapus tweet yang sama
tweet <- distinct(covid)
tweet$text[254]
#Mengubah tweet menjadi bentuk karakter
tweets <- as.character(tweet$text)

#menghapus enter
tweets[254]
tweets <- gsub( "\n"," ",tweets)
tweets[254]

# menghapus emoji
tweets <- gsub("[^\x01-\x7F]", " ", tweets) 
tweets[254]

## Remove URLs
tweets <- gsub("http\\S+\\s*", " ",  tweets) 
tweets[254]

# menghapus karakter "&"
tweets[69] 
tweets = gsub("&amp", " ", tweets) 

#menghapus rt
tweets[82] 
tweets <- gsub(" RT ", " ", tweets)

#menghapus username
tweets[82]
tweets <- gsub("@\\w+", " ", tweets)

## Remove Hashtag
tweets[82]
tweets <- gsub("#\\S+", " ", tweets) 


#menghapus blank spaces, tanda dan nomor
tweets[82]
tweets <- strip(tweets)



# perbandingan sebelum dan sesudah seluruh proses cleaning
covid$text[1]
tweets[1]

# menyimpan data cleaning dalam bentuk dataframe
data.clean <- data.frame(text = tweets)
save_as_csv(data.clean, "data_clean.csv")



# memasukan lexicon (kamus) bahasa Indonesia
kamus_singkatan <- read.csv("kamus-alay.csv")

#data tweet sebelum normalisasi
tweets <- as.character(data.clean$text) #apabila sudah tertiban
tweets[1]


# NORMALISASI
# mengganti kata slang dengan kata yang terdapat pada lexicon
tweets <- replace_internet_slang(tweets, slang = paste0("\\b",
                                                        kamus_singkatan$slang, "\\b"),
                                 replacement = kamus_singkatan$formal, ignore.case = TRUE)
tweets[1]

# untuk demo
percobaan <- "jgn jd org bodoh"
percobaan <- replace_internet_slang(percobaan, slang = paste0("\\b",
                                                        kamus_singkatan$slang, "\\b"),
                                 replacement = kamus_singkatan$formal, ignore.case = TRUE)

percobaan


# hasil perbandingan sebelum dan sesudah normalisasi
tweet$text[1]
tweets[1]

# Menghilangkan tanda pada bacaan (titik, koma dll) dan menjadikan ke lower text dan merapihkan kata
tweets <- strip(tweets)

# memasukan data normalisasi ke dalam dataframe
data.alay <- data.frame(text = tweets)
save_as_csv(data.alay, "data_alay.csv")


# number of tweet rows after duplicated text removed
nrow(data.alay)

