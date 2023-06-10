table_2 <- function(Posts){
  
  our_new_data<- as.data.table(Posts)
  #Traktujemy nasze dane jako data.table
  
  our_new_data<-our_new_data[PostTypeId %in% c(1,2),c("CreationDate","Score")]
  #Wybieramy tylko te wiersze, w ktorych PostTypeId jest rowny 1 lub 2, oraz kolumny CreationDate i Score
  
  our_new_data<-our_new_data[ , `:=` (Year = strftime(our_new_data$CreationDate, format = "%Y"), Month = strftime(our_new_data$CreationDate, format = "%m"))]
  #rozwazanej zmiennej przypisujemy referencje do data.table powstalego z
  #poprzednio rozwazanego data.table, do ktorego dolaczono dwie nowe kolumny
  #Year oraz Month utworzone przy uzyciu metody strftime na kolumnie CreationDate
  
  our_new_data<-our_new_data[,.(PostsNumber=length(CreationDate), MaxScore= max(Score)),by=.(Year,Month)]
  #powyzszy zapis oznacza, ze bedziemy rozwazali dwie nowe kolumny PostsNumber oraz MaxScore
  #zdefiniowane odpowiednio wyzej, poza tymi dwoma kolumnami rozwazamy jeszcze
  #kolumny Year oraz Month po, ktorych grupujemy, dostep do tych danych mamy
  #dzieki odwolaniu do rozwazanego data.table
  
  our_new_data<-our_new_data[our_new_data$PostsNumber>1000,]
  #Uwzgledniamy tylko te wiersze, w ktorych PostsNumber>1000
  
  our_new_data<-as.data.frame(our_new_data)
  #traktujemy jako data.frame
  
  rownames(our_new_data)<-NULL
  #Pozbywamy sie nazewnictwa wierszy
  
  our_new_data
  
}