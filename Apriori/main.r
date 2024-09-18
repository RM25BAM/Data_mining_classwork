options(repos = c(CRAN = "http://cran.rstudio.com"))
install.packages("arules")
install.packages("arulesViz")
library("arulesViz")
library("arules")
data("Groceries")


#txn = read.transactions (file="/Users/npiedrabuena/Desktop/dataminingR/Apriori/data.csv", format="basket", sep=",", cols=1)
#inspect(txn)


#basket_rules <- apriori(txn, parameter = list(sup = 0.5, conf = 0.7, target="rules"))
#inspect(basket_rules)
#basket_rules <- apriori(txn, parameter = list(sup = 0.5, conf = 0.5, target="rules", minlen = 2))
#inspect(basket_rules)
#frequent_itemsets <- apriori(txn, parameter = list(sup = 0.5, target="frequent itemsets"))

#inspect(frequent_itemsets)

#frequent_itemsets <- apriori(Groceries, parameter = list(sup = 0.01, target="frequent itemsets", minlen = 2))
#inspect(frequent_itemsets[1:10])

basket_rules<- apriori(Groceries, parameter = list(sup = 0.01, conf = 0.2, target="rules", minlen = 2))
rules<-sort(basket_rules, by="confidence", decreasing=TRUE)
inspect(rules[1:10])
plot(rules[1:10], method = "graph",  engine = "htmlwidget")
arules::itemFrequencyPlot(Groceries, topN=20, type='absolute')
two of them 0.75 and one of them 0.60 