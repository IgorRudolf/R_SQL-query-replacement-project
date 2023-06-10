dplyr_1 <- function(Users){
  
  our_data<-select(Users, Location, UpVotes)
  #Wybieramy z Users kolumny Location oraz UpVotes
  
  
  our_data<-filter(our_data,  Location !="")
  #Nastepnie przy uzyciu filtera upewniamy sie, ze bedziemy uwzgledniac
  #tylko takie wiersze, w ktorych lokacja jest niepusta
  
  grouped_data<- our_data %>% group_by(Location) %>% summarise(TotalUpVotes= sum(UpVotes))
  #Nastepnie nasz rozwany zbior danych grupujemy po lokacji nastepnie przy uzyciu pipe
  #wsadzamy nasze dane do summarise i dokonujemy podsumowania, ktore nas interesuje
  #dostajemy nowy data.frame
  
  o<-as.data.frame(grouped_data)
  #Otrzymany wynik nastepnie traktujemy jako data.frame
  
  o<- o %>% arrange(desc(TotalUpVotes))
  #porzadkujemy po TotalUpVotes w kolejnosci nierosnacej
  
  o<-slice(o,1:10)
  #przy uzyciu slice wyodrebniamy tylko szukane wiersze
  
  o
}