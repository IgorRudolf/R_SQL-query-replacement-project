dplyr_3 <- function(Posts, Users){
  
  some_data<-select(Posts, OwnerUserId, ViewCount)
  #wybieramy z Postsow kolumny OwnerUserId oraz ViewCount
  
  some_data<-filter(some_data, Posts$PostTypeId==1)
  #uwzgledniamy tylko te wiersze, ktore maja PostTypeId==1
  
  some_data <- some_data %>% group_by(OwnerUserId) %>% summarize(TotalViews=sum(ViewCount))
  #grupujemy nasze dane przez OwnerUserId nastepnie przy uzyciu Pipe wsadzamy nasze dane do summarize
  #podsumuwujemy nasze dane przy uzyciu kolumny TotalViews, ktora dla zg
  #grupowanych danych wykonuje sume po ViewCount
  
  some_data<-as.data.frame(some_data)
  #traktujemy otrzymany wynik jako data.frame
  
  Questions<-some_data
  #utozsamiamy nasz data.frame z Questions
  
  super_data<- inner_join(Users, Questions, by= c("Id"="OwnerUserId"))
  #joinujemy Users z Questions przy uzyciu inner_join to znaczy, ze bedziemy rozwazali tylko takie wiersze gdzie
  #Users.Id=Questions.OwnerUserId
  
  super_data<-select(super_data, Id, DisplayName,TotalViews)
  #wybieramy kolumny Id, DisplayName oraz TotalViews
  
  super_data<- super_data %>% arrange(desc(TotalViews))
  #porzadkujemy po TotalViews w kolejnosci nierosnacej
  
  super_data<-slice(super_data,1:10)
  #wybieramy tylko pierwsze 10 wierszy
  
  super_data 
}