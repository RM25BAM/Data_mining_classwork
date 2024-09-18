


options(repos = c(CRAN = "http://cran.rstudio.com"))
install.packages("tm")
install.packages("proxy")
install.packages("lsa")

library(lsa) # nolint
library(tm)
library(proxy)


doc1 <- readLines("/Users/npiedrabuena/Desktop/dataminingR/Assignment_5/document1.txt") # nolint
doc2 <- readLines("/Users/npiedrabuena/Desktop/dataminingR/Assignment_5/document2.txt") # nolint


preprocessDocument <- function(doc){  # nolint
  doc <- tolower(doc)  # nolint
  doc <- removePunctuation(doc)
  doc <- stripWhitespace(doc)
  doc <- strsplit(doc, split = " ")
  print(doc)
  return(doc)
}
doc1 <- preprocessDocument(doc1)
doc2 <- preprocessDocument(doc2)
tdm <- TermDocumentMatrix(Corpus(VectorSource(c(doc1, doc2))))
print(tdm)

dtm <- as.matrix(tdm)
print(dtm)
cos_sim <- cosine(as.textmatrix(dtm))


cos_sim_rounded <- signif(cos_sim, digits = 2)
print(cos_sim_rounded)
print(cos_sim)

top10Words <- function(dtm, docIndex){
  stop_words <- stopwords("en")  
  terms <- rownames(dtm)  
  valid_terms_indices <- which(!terms %in% stop_words)  
  dtm_filtered <- dtm[valid_terms_indices, , drop = FALSE]  
  # Calculate term frequencies for the specified document
  termFreqs <- rowSums(dtm_filtered[, docIndex, drop = FALSE]) # nolint
  # Sort frequencies in decreasing order
  sortedFreqs <- sort(termFreqs, decreasing = TRUE) # nolint
  # Select top 10 terms and their frequencies
  topTermsFreqs <- head(sortedFreqs, 10) # nolint
  # Create a data frame with the top terms and their frequencies
  cat("Word")
  topTermsDF <- data.frame(Frequency = topTermsFreqs) # nolint
  return(topTermsDF)
}

#Find top 10 words for both documents 1 & 2
cat("Top 10 words in Document 1:\n") # nolint
print(top10Words(dtm, 1))

cat("\nTop 10 words in Document 2:\n") # nolint
print(top10Words(dtm, 2))
