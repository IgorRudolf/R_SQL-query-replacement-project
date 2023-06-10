table_1 <- function(Users){
  our_new_data<- as.data.table(Users)
  #Traktujemy nasze dane jako data.table
  
  our_new_data<-our_new_data[Location!="",c("Location","UpVotes")]
  #Wybieramy tylko te wierszy, w ktorych lokacja jest niepusta, nastepnie wybieramy kolumny Location oraz UVotes
  
  our_new_data<-our_new_data[,.(TotalUpVotes=sum(UpVotes)),by=.(Location)][order(-TotalUpVotes)][1:10] 
  #Grupujemy po Lokacji,poza pogrupowana kolumna lokacji rozwazamy jeszcze jedna dodatkowo TotalUpVotes,
  #powstaje ona tak, ze dla poszczegolnych grup liczymy ich sume po UpVotesach
  #dla poszczegolnej grupy bedziemy mieli konkretna wartosc TotalUpVotes, bedaca suma UpVotesow, ktore maja ta sama grupe
  #porzadkujemy po TotalUpVotes w kolejności nierosnącej
  #Nastepnie wybieramy tylko szukane przez nasz 10 wierszy
  
  our_result<-as.data.frame(our_new_data)
  #Pod koniec traktujemy nasze dane jako data.frame
  
  our_result
}