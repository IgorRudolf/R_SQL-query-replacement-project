dplyr_2 <- function(Posts){
  our_data<- select(Posts, CreationDate, Score)
  #Wybieramy z Posts dwie kolumny CreationDate oraz Score
  
  our_data<-filter(our_data, Posts$PostTypeId %in% c(1,2))
  #Bierzemy tylko te wiersze, w ktorych PostTypeId jest rowny 1 lub jest rowny 2
  
  our_data
  
  our_data <- our_data %>% mutate(Year = strftime(our_data$CreationDate, format = "%Y"), Month = strftime(our_data$CreationDate, format = "%m"))
  #Tworzymy dwie nowe kolumny na naszym zbiorze danych, Year oraz Month,
  #Year oraz Month sa tworzone przy uzyciu metody strftime
  
  our_data <- our_data %>% group_by(Year, Month) %>% summarize(PostsNumber=length(Score),MaxScore=max(Score))
  #grupujemy nasze dane po kolumnach Year oraz Month
  #nastepnie przy uzyciu summarise tworzymy nowy data frame
  #taki, ze ma on odpowiednio zdefiniowane kolumny PostsNumber oraz MaxScore
  #ostatecznie obecnie rozwazanemu zbiorowi danych przypisujemy
  #nowy data frame, bedacy zgrupowany po Year oraz Month oraz posiadajacy kolumny z summarize
  
  our_data<-as.data.frame(our_data)
  #traktujemy nasz dane jako data.frame
  
  our_data<- filter(our_data, our_data$PostsNumber>1000)
  #Uwzgledniamy tylko te wiersze, w ktorych PostsNumber>1000
  
  rownames(our_data) <- NULL
  #Pozbywamy sie nazewnictwa wierszy
  
  our_data
}