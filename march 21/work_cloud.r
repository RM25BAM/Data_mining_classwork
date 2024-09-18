#options(repos = c(CRAN = "http://cran.rstudio.com"))
#install.packages("wordcloud")
library(wordcloud)
#install.packages("RColorBrewer")
library(RColorBrewer)
#install.packages("wordcloud2")
library(wordcloud2)
#install.packages("tm")
library(tm) 
read <- readLines("/Users/npiedrabuena/Desktop/dataminingR/march 21/doc3.txt",warn = FALSE)
docs <- Corpus(VectorSource(text))
textfile <- Corpus(docs)

# Strip unnecessary whitespace
textfile <- tm_map(textfile, stripWhitespace)
# Convert to lowercase
textfile <- tm_map(textfile, tolower)
# Remove conjunctions etc.
textfile <- tm_map(textfile, removeWords, stopwords("english"))
# Remove suffixes to the common 'stem'
textfile <- tm_map(textfile, stemDocument)
# Remove commas etc.
textfile <- tm_map(textfile, removePunctuation)

#(optional) arguments of 'tm' are converting the document to something other than text, to avoid, run this line
textfile <- tm_map(textfile, PlainTextDocument)
wordcloud(textfile , scale=c(5,0.5), max.words=100, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "Dark2"))
print(wordcloud)