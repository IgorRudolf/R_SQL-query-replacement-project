table_3 <- function(Posts, Users){
  
  our_data<-as.data.table(Posts)
  #Traktujemy nasze dane jako data.table
  
  our_data<-our_data[PostTypeId==1, c("OwnerUserId","ViewCount")]
  #wybieramy te wiersze gdzie PostTypeId==1 oraz kolumny OwnerUserId i ViewCount
  
  our_data<-our_data[,.(TotalViews=sum(ViewCount)),by=.(OwnerUserId)]
  #Grupujemy po OwnerUserId,poza pogrupowana kolumna lokacji rozwazamy jeszcze jedna dodatkowo kolumne TotalViews,
  #powstaje ona tak, ze dla poszczegolnych grup liczymy ich sume po ViewCount
  #dla poszczegolnej grupy bedziemy mieli konkretna wartosc TotalViews, bedaca suma ViewCount, ktore maja ta sama grupe
  
  Questions<-our_data
  #utozsamiamy nasz data.table z Questions
  
  our_new_data<-as.data.table(merge(Users, Questions, by.x= c("Id"),by.y = c("OwnerUserId")))
  #Scalamy rozwazane Questions oraz Users uzywajac do tego kolumn OwnerUserId oraz Id
  #Wybieramy tylko te wiersze gdzie Users.Id= Questions.OwnerUserId
  
  our_new_data<-our_new_data[,.(Id,DisplayName,TotalViews)]
  #wybieramy kolumny Id, DisplayName oraz TotalViews
  
  our_new_data<-our_new_data[order(-TotalViews),][1:10]
  #porzadkujemy nasze dane po TotalViews w kolejnosci nierosnacej, wybieramy pierwsze 10 wynikow
  
  our_new_data<-as.data.frame(our_new_data)
  #Pod koniec traktujemy nasze dane jako data.frame
  
  our_new_data
}