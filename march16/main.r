options(repos = c(CRAN = "http://cran.rstudio.com"))
install.packages("tidyverse")
install.packages("ggplot2")
library("ggplot2")
library("tidyverse")

library("readxl")
mortality_data <- read_excel('/Users/npiedrabuena/Desktop/dataminingR/march16/child_mortality_rates.xlsx', sheet = 1) #nolint
print(mortality_data) #nolint
head(mortality_data)#nolint
tail(mortality_data, 3)#nolint


print(summary(mortality_data))#nolint
print(select(mortality_data, Year, "01-04 Years"))#nolint
print(select(mortality_data, Year))#nolint
print(select(mortality_data, -Year))#nolint
summary(select(mortality_data, "01-04 Years"))#nolint
mortality_long <- pivot_longer(mortality_data, cols = c("01-04 Years", "05-09 Years", "10-14 Years", "15-19 Years"),names_to = "AgeGroup", values_to = "DeathRate") # nolint
print(mortality_long) # nolint
mortality_long <- mutate(mortality_long, DeathRate = DeathRate * 100000) # nolint
print(mortality_long) # nolint
mortality_long <- mutate(mortality_long, Decade = (Year %/% 10) * 10) 
print(mortality_long)
mortality_long <- rename(mortality_long, DeathsPer100K = DeathRate)
print(mortality_long)
saveRDS(mortality_long, '/Users/npiedrabuena/Desktop/dataminingR/march16/mortality_long.rds') # nolint
mortality_long %>% group_by(Decade) %>% summarize(MeanDeaths = mean(DeathsPer100K), Count = n()) # nolint
value <- ggplot(mortality_long, aes(x = Year, y = DeathsPer100K, color = AgeGroup)) + geom_line() # nolint
print(value)