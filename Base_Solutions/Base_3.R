
base_3 <- function(Posts, Users){
  
  considering_data<-Posts[Posts$PostTypeId==1, c("OwnerUserId", "ViewCount")]
  # Z Posts wybieramy tylko te wiersze, w ktorych PostTypeId==1 oraz z Postsow wybieramy kolumny OwnerUserId oraz ViewCount
  
  considering_data<-aggregate(considering_data$ViewCount, considering_data[c("OwnerUserId")], FUN= sum)
  #Robimy operacje sumy na ViewCount, nastepnie grupujemy po OwnerUserId
  
  names(considering_data)[2]<-"TotalViews"
  #Zmieniamy teraz nazwe naszej drugiej kolumny na TotalViews
  
  Questions<-considering_data
  #Utozsamiamy Questions z rozwazanym przez nas zbiorem danych
  
  new_data<-merge(Users, Questions, by.x= c("Id"),by.y = c("OwnerUserId"))
  #Scalamy rozwazane Questions oraz Users uzywajac do tego kolumn OwnerUserId oraz Id
  #Wybieramy tylko te wiersze gdzie Users.Id= Questions.OwnerUserId
  
  new_data<-new_data[,c("Id","DisplayName","TotalViews")]
  #Wybieramy tylko te kolumny, ktore nas interesuja czyli Id, DisplayName oraz TotalViews
  
  new_data<-new_data[order(new_data$TotalViews,decreasing = TRUE),]
  #porzadkujemy nasz wynik po TotalViews w kolejnosci nierosnacej
  
  new_data<-head(new_data,10)
  #wybieramy tylko pierwsze 10 wierszy
  
  rownames(new_data)<-NULL
  #Pozbywamy sie nazewnictwa wierszy
  
  new_data
}