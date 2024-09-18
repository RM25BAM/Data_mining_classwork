options(repos = c(CRAN = "http://cran.rstudio.com"))
installed.packages('DBI')
installed.packages('RSQLite')
library(DBI)
library(RSQLite)

install.packages("magrittr") # package installations are only needed the first time you use it
install.packages("dplyr")    # alternative installation of the %>%


url <-"https://projects.fivethirtyeight.com/general-model/president_general_polls_2016.csv"
dest_file <-"polls.csv" 

download.file( url, dest_file)
polls <-read_csv(dest_file)


library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)    # alternatively, this also loads %>%
length(polls$type)
unique(polls$type)
length(unique(polls$type))
polls$type %>% unique() %>% length()
polls %>% apply(MARGIN = 2, FUN = unique) %>% str(strict.width = "cut")
polls$state %>% table()
polls %>% filter(state != "U.S.")
polls %>% filter(state == "California" & grade == "A")
polls %>% filter(state %in% c("Texas", "Oregon", "Maine"))
polls %>% select(1)
polls %>% select(1:5)
polls %>% select(1, 2, 4)
polls %>% select(-1, -2, -4)
polls %>% select(-c(1, 2, 4))
polls %>% select(cycle)
polls %>% select(cycle:forecastdate)
polls %>% select(cycle, branch, matchup)
polls %>% select(-cycle, -branch, -matchup)
polls %>% select(-c(cycle, branch, matchup))
polls <- polls %>% select(-1 ,-2, -4, -5, -23, -24, -25)
polls <- polls %>% select(-cycle, -branch, -matchup, -forecastdate, -url,-poll_id,-question_id)



library(DBI)
library(RSQLite)
db_file <- "C:\\Users\\npiedrabuena01\\Desktop\\fires.sqlite_file\\data\\fires1.sqlite"
con <- dbConnect(SQLite(), db_file)
dbListTables(con) # List all tables
dbListFields(con, "Fires") # List all columns in Fires table
fires_sql <- " SELECT fire_name, fire_size, state, fire_year, DATETIME(discovery_date) AS discovery_date, DATETIME(cont_date) AS contain_date FROM Fires"
response <-dbSendQuery(con, fires_sql) 
fires <-as_tibble(dbFetch(response))

fires %>% arrange(STATE, FIRE_YEAR, desc(FIRE_SIZE))
f1 <- fires %>% group_by(STATE) %>%
  arrange(FIRE_YEAR, desc(FIRE_SIZE), .by_group = TRUE)
summarize(f1, mean = mean(FIRE_SIZE))


fires <- fires %>% filter(!duplicated(fires))
fires <- fires %>% unique()

nrow(fires)
sum(!complete.cases(fires))
sum(is.na(fires$FIRE_NAME))
fires_dropna <- fires %>% filter(complete.cases(fires))
fires_dropna <- fires %>% filter(complete.cases(FIRE_NAME))

fires_replna <- fires %>% mutate(FIRE_NAME = ifelse(is.na(FIRE_NAME) & SIZE < 200, "Unnamed Small Fire", FIRE_NAME))