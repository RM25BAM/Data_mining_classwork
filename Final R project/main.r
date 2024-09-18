# Load necessary libraries
install.packages("dplyr")
install.packages("ggplot2")
install.packages("caret")
install.packages("randomForest")
install.packages("pROC")
install.packages("corrplot")
install.packages("lubridate")
install.packages("gridExtra")






library(dplyr)
library(ggplot2)
library(caret)
library(randomForest)
library(pROC)
library(lubridate)
library(gridExtra)

# Data Loading
churn_data <- read.csv("churn.txt")

# Data Cleaning
churn_data <- churn_data %>%
  mutate(
    InternationalPlan = as.factor(InternationalPlan),
    VoiceMailPlan = as.factor(VoiceMailPlan),
    Churn = as.factor(Churn),
    State = as.factor(State)
  )

# 1. Impact of International Plans on Churn
ggplot(churn_data, aes(x = InternationalPlan, fill = Churn)) +
  geom_bar(position = "fill") +
  labs(title = "Churn Rate by International Plan")

# 2. Influence of Daytime Usage on Churn
ggplot(churn_data, aes(x = TotalDayMinutes, fill = Churn)) +
  geom_histogram(binwidth = 30) +
  labs(title = "Churn Distribution by Total Day Minutes")

# 3. Voice Mail Plan as a Retention Tool
ggplot(churn_data, aes(x = VoiceMailPlan, fill = Churn)) +
  geom_bar(position = "fill") +
  labs(title = "Churn Rate by Voice Mail Plan")

# 4. Customer Service Interactions Predict Churn
ggplot(churn_data, aes(x = NumberofCallsToCustomerService, fill = Churn)) +
  geom_histogram(binwidth = 1, position = "dodge") +
  labs(title = "Churn by Number of Calls to Customer Service")

# 5. Churn by State
ggplot(churn_data, aes(x = State, fill = Churn)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Churn Rate by State")

# 6. Effect of Evening Usage
ggplot(churn_data, aes(x = TotalEveMinutes, fill = Churn)) +
  geom_histogram(binwidth = 30) +
  labs(title = "Churn Distribution by Total Evening Minutes")

# 7. Correlation Between Charges and Churn
total_charges <- churn_data %>%
  mutate(TotalCharges = TotalDayCharge + TotalEveCharge + TotalNightCharge)
ggplot(total_charges, aes(x = TotalCharges, fill = Churn)) +
  geom_histogram(binwidth = 10) +
  labs(title = "Churn Distribution by Total Charges")

# 8. Predictive Power of International Calls
ggplot(churn_data, aes(x = TotalInternationalCalls, fill = Churn)) +
  geom_histogram(binwidth = 1) +
  labs(title = "Churn Distribution by Total International Calls")

# 9. Account Length and Loyalty
ggplot(churn_data, aes(x = AccountLength, fill = Churn)) +
  geom_histogram(binwidth = 50) +
  labs(title = "Churn Distribution by Account Length")

# 10. Night-Time Service Usage
ggplot(churn_data, aes(x = TotalNightMinutes, fill = Churn)) +
  geom_histogram(binwidth = 30) +
  labs(title = "Churn Distribution by Total Night Minutes")

# Additional Analysis
# Correlation heatmap for numerical variables
numerical_data <- churn_data %>% 
  select(contains("Minutes"), contains("Calls"), contains("Charge"), contains("Length"))
corr_matrix <- cor(numerical_data)
corrplot(corr_matrix, method = "color")