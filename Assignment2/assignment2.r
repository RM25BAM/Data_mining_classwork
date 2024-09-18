package.install("ggplot2")
{ # nolint
    
    data(Titanic) # nolint
  
    t<-as.data.frame(Titanic)
    df <- subset(t, Survived=="No")
  
  male_adult <- sum(df[df$Age=="Adult" & df$Sex=="Male","Freq"])
  print(male_adult)
  female_adult <- sum(df[df$Age=="Adult" & df$Sex=="Female","Freq"])
  print(female_adult)
  male_child <- sum(df[df$Age=="Child" & df$Sex=="Male","Freq"])
  print(male_child)
  female_child <- sum(df[df$Age=="Child" & df$Sex=="Female","Freq"])
  print(female_child)
  
  
  lbls <- c("Male Adult","Female Adult","Male Child","Female Child")
  slices <- c(male_adult,female_adult,male_child,female_child)
  pct <- round(slices/sum(slices)*100)
  lbls2 <- paste(lbls, " ", pct, "%", sep ="")
  
  pie(slices, labels = lbls2,col = rainbow(length(lbls2)), main = "Pie Chart For Not Survved Based on Gender and Age") # nolint
}
