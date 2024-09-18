options(repos = c(CRAN = "http://cran.rstudio.com"))
install.packages("tidyverse")
install.packages("ggplot2")
library("ggplot2")
library("tidyverse")

library("readxl")
mortality_data <- read_excel('/Users/natashapiedrabuena/Desktop/dataminingR/march16/child_mortality_rates.xlsx', sheet = 1) #nolint
#mortality_long <- pivot_longer(mortality_data, cols = c("01-04 Years", "05-09 Years", "10-14 Years", "15-19 Years"), names_to = "AgeGroup", values_to = "DeathRate")mortality_long
#mortality_long <- mortality_long %>% mutate(AgeGroup = factor(AgeGroup))mortality_long


ggplot(mortality_long, aes(x = Year, y = DeathRate, color  = AgeGroup)) + geom_line()

ggplot(mortality_long, aes(x = AgeGroup, y = DeathRate, fill = AgeGroup)) + geom_boxplot()


agegroup1 <- mortality_long %>% filter(AgeGroup == "01-04 Years") %>% as_tibble()


upper_fence <-quantile(agegroup1$DeathRate, 0.75) + (1.5 * IQR(agegroup1$DeathRate))

lower_fence <-quantile(agegroup1$DeathRate, 0.25) - (1.5 * IQR(agegroup1$DeathRate))