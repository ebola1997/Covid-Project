##Data Aspect-based dilakukan secara manual berdasarkan kriteria tertentu

data.aspect <- read.csv(file.choose(), header = T)
percobaan <- data.aspect

data.aspect <- data.lexicon
data.aspect$aspek <- percobaan$aspek



data.aspect$kelas <- as.factor(data.aspect$kelas)
data.aspect$aspek <- as.factor(data.aspect$aspek)
