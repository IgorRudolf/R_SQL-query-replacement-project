base_1 <- function(Users){
  our_data<-Users[Users$Location!="",][c("UpVotes", "Location")]
  #Wybieram z Users, wszystkie wiersze, ktorych lokacja nie jest pusta, i kolumny UpVotes i Location z Users
  
  m<-aggregate(our_data$UpVotes, our_data['Location'], sum)
  #Robimy operacje sumy po UpVotes, grupujemy po kolumnie Location
  
  names(m)[2]<-"TotalUpVotes"
  #Po dokonaniu agregacji zmieniamy nazwe drugiej kolumny na TotalUpVotes
  
  m<-head(m[order(m$TotalUpVotes, decreasing = TRUE),],10)
  #Z naszego data.table nastepnie porzadkujemy po TotalUpVotes w kolejnosci nierosnacej
  #po dokonaniu porzadkowania wybieramy piersze 10 wierszy
  
  rownames(m)<-NULL
  #Pod koniec pozbywamy sie nazewnictwa wieszy
  
  m
}