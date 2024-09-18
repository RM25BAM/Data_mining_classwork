#options(repos = c(CRAN = "http://cran.rstudio.com"))
#install.packages("tidyverse")
#install.packages("ggplot2")
library("ggplot2")
library("tidyverse")
library("datasets")
#print(head(iris))
#print(head(ChickWeight))




irises <- as_tibble(iris)
#print(irises)
chicken <- as_tibble(ChickWeight)
#print(chicken)

chicken <- rename(chicken, Weight = weight)
#print(chicken)


#print(filter(chicken, Diet == 2))
#print(filter(irises, Sepal.Length > 5))

graph <- ggplot(data = chicken, mapping = aes(x = Time, y = Weight, color = Chick))
#print(graph)

lineplot <- ggplot(chicken, aes(x = Time, y = Weight, color = Chick)) + geom_line()
#print(lineplot)

scatterplot <- ggplot(irises, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + geom_point(size = 3)
#print(scatterplot)

barplot <- ggplot(irises, aes(x = Species, fill = Species)) + geom_bar()
#print(barplot)

#barplot for selected rows

barplot_filtered <- ggplot(filter(irises, Sepal.Length > 5.5), aes(x = Species, fill = Species)) + geom_bar()
#print(barplot_filtered)


boxplot <- ggplot(irises, aes(x = Species, y = Sepal.Width, color = Species)) + geom_boxplot()
#print(boxplot)

histogram <- ggplot(irises, aes(x = Sepal.Length, fill = Species)) + geom_histogram(bins = 20)
#print(histogram)

KDE <- ggplot(irises, aes(x = Sepal.Length, color = Species)) + geom_density(size = 1)
#print(KDE)

KCDF <- ggplot(irises, aes(x = Sepal.Length, color = Species)) + stat_ecdf(size = 1)
#print(KCDF)

ECDF_col_all_val <- ggplot(irises, aes(x = Sepal.Length)) + stat_ecdf(size = 1)
#print(ECDF_col_all_val)


line_scatter <- ggplot(data = chicken, aes(x = Time, y = Weight, color = Chick)) + geom_line() + geom_point()
#print(line_scatter)

grid_plots <- ggplot(chicken, aes(x = Time, y = Weight, color = Chick)) + geom_line() + facet_wrap(facets = vars(Diet), nrow = 2, ncol = 2)
print(grid_plots)