install.packages("RMySQL",  repos = "https://cran.rstudio.com/")

{  # nolint
    library(RMySQL) # nolint
    table1 <- read.table("/Users/npiedrabuena/Desktop/dataminingR/Assignment_4/first1table.txt", header = TRUE, fill = TRUE) # nolint
    table2 <- read.table("/Users/npiedrabuena/Desktop/dataminingR/Assignment_4/second2table.txt", header = TRUE, sep = ",") # nolint
    table2$weight[is.na(table2$weight)] <- mean(table2$weight, na.rm = TRUE)
    table1$height[is.na(table1$height)] <- mean(table1$height, na.rm = TRUE)
    merge_table <- merge(table2, table1, by = "id")
    mydb <- dbConnect(MySQL(), user = 'root', password = 'Alhawking1918@', dbname = 'Student_Info', host = 'localhost', port = 3306) # nolint
    dbSendQuery(mydb, "CREATE DATABASE IF NOT EXISTS studentData;")
    dbSendQuery(mydb, "USE studentData;")
    dbSendQuery(mydb, "CREATE TABLE IF NOT EXISTS studentInfo (
        id INT,
        weight DOUBLE,
        height DOUBLE,
        PRIMARY KEY (id)
    );")
    dbWriteTable(mydb, "studentInfo", merge_table, append = TRUE, row.names = FALSE) # nolint
    result <- dbSendQuery(mydb, "SELECT * FROM studentInfo;")
    data <- fetch(result, n = -1)
    print(data)
    dbDisconnect(mydb)
    #head(merge_table)
}
