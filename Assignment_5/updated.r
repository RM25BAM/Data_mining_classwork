options(repos = c(CRAN = "http://cran.rstudio.com"))
install.packages("tm")
install.packages("proxy")
install.packages("lsa")

library(lsa) # nolint
library(tm)
library(proxy)


doc1 <- readLines("/Users/npiedrabuena/Desktop/dataminingR/Assignment_5/document1.txt") #doc 3 from moodle
doc2 <- readLines("/Users/npiedrabuena/Desktop/dataminingR/Assignment_5/document2.txt") #doc4 from moodle
preprocessDocument <- function(doc){ #this is the function for preprocessing we split to get it as a vector later
  doc <- tolower(doc)
  doc <- removePunctuation(doc)
  doc <- stripWhitespace(doc)
  doc <- unlist(strsplit(doc, "\\s+"))
  return(doc)
}
doc1 <- preprocessDocument(doc1)
doc2 <- preprocessDocument(doc2)
allWords <- unique(c(doc1, doc2))
freqVector <- function(doc, vocab){ # this creates the frequency for the vecotr meaning if its found many times it will add that frequency to use for cosine
  sapply(vocab, function(word){
    sum(doc == word)
  })
}
doc1Freq <- freqVector(doc1, allWords)
doc2Freq <- freqVector(doc2, allWords)
cos_sim <- cosine(matrix(c(doc1Freq, doc2Freq), ncol=2))
cos_sim_rounded <- signif(cos_sim[1, 2], digits = 2)
cat("The cosine similarity: ")
print(cos_sim_rounded)
getTop10Words <- function(freqVector, allWords) {
  stopWords <- stopwords("en")
  filteredWords <- allWords[!allWords %in% stopWords]
  filteredFreqVector <- freqVector[!allWords %in% stopWords]
  
  wordFreqs <- data.frame(Word = filteredWords, Frequency = filteredFreqVector)
  top10Words <- head(wordFreqs[order(-wordFreqs$Frequency),], 10)
  return(top10Words)
}
top10WordsDoc1 <- getTop10Words(doc1Freq, allWords)
top10WordsDoc2 <- getTop10Words(doc2Freq, allWords)
cat("Top 10 words in Document 1:\n")
print(top10WordsDoc1, row.names = FALSE)
cat("\nTop 10 words in Document 2:\n")
print(top10WordsDoc2, row.names = FALSE)