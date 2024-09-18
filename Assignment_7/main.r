#options(repos = c(CRAN = "http://cran.rstudio.com"))
#install.packages("dplyr")
#install.packages("ggplot2")
library(dplyr)
library(ggplot2)
ramen_rate <- read.csv("/Users/npiedrabuena/Desktop/dataminingR/Assignment_7/RamenRating.csv")


ramen_hist <- ramen_rate %>% ggplot(aes(x = as.numeric(Stars))) + geom_histogram(binwidth = 0.25, fill = "blue", color = "black") + labs(title = "Histogram of Ramen Ratings", x = "Ratings", y = "Frequency")
print(ramen_hist)


ramen_box <- ramen_rate %>% group_by(Country) %>% filter(n() > 1) %>% ggplot(aes(x = Country, y = as.numeric(Stars), fill = Country)) + geom_boxplot() + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + labs(title = "Boxplot of Ratings by Country", x = "Country", y = "Ratings")
print(ramen_box)


ramen_top <- ramen_rate %>% count(Brand) %>% top_n(5) %>% ggplot(aes(x = reorder(Brand, n), y = n, fill = Brand)) + geom_bar(stat = "identity") + coord_flip() + labs(title = "Top 5 Ramen Brands by Variety Count in the dataset", x = "Brand", y = "Variety Count")
print(ramen_top)

library(wordcloud)

Creates a word cloud for ramen varieties
varieties <- tolower(ramen_rate$Variety) 
wordcloud_ramen <-wordcloud(words = varieties, max.words = 100, random.order = FALSE, colors = brewer.pal(8, "Dark2"))
print(wordcloud_ramen)


Average_Rating <- ramen_rate %>% group_by(Country) %>% summarise(AverageRating = mean(as.numeric(Stars), na.rm = TRUE)) %>% ggplot(aes(x = reorder(Country, AverageRating), y = AverageRating)) + geom_bar(stat = "identity") + coord_flip() + labs(title = "Average Ramen Rating by Country", x = "Country", y = "Average Rating")
print(Average_Rating)


