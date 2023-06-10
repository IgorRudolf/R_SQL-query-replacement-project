dplyr_4 <- function(Posts, Users){
  
  first_considering<- select(Posts,OwnerUserId, Id)
  #wybieramy z Posts kolumne OwnerUserId oraz Id
  
  filter(first_considering,Posts$PostTypeId==2)->first_considering
  #wybieramy tylko te wiersze gdzie PostTypeId==2
  
  first_considering <- first_considering %>% group_by(OwnerUserId) %>% summarize(AnswersNumber=length(Id))
  #grupujemy nasze dane przez OwnerUserId nastepnie przy uzyciu Pipe wsadzamy nasze dane do summarize
  #podsumuwujemy nasze dane przy uzyciu kolumny Id, ktora dla zgrupowanych danych
  #dla kazdej grupy liczy ile jest wierszy odpowiadajacej danej kolumnie
  
  first_considering<-as.data.frame(first_considering)
  #traktujemy wynik naszej operacji jako data.frame
  
  Answers<-first_considering
  #utozsamiamy Answers z naszymi danymi
  
  Answers<-filter(Answers, !is.na(Answers$OwnerUserId))
  #rozwazamy tylko te wiersze, gdzie OwnerUserId nie jest NA
  
  second_considering<-select(Posts,OwnerUserId,Id)
  #wybieramy z Posts kolumne OwnerUserId oraz Id
  
  filter(second_considering, Posts$PostTypeId==1)->second_considering
  #wybieramy tylko te wiersze gdzie PostTypeId==1
  
  second_considering<- second_considering %>% group_by(OwnerUserId) %>% summarize(QuestionsNumber=length(Id))
  #grupujemy nasze dane przez OwnerUserId nastepnie przy uzyciu Pipe wsadzamy nasze dane do summarize
  #podsumuwujemy nasze dane przy uzyciu kolumny Id, ktora dla zgrupowanych danych
  #dla kazdej grupy liczy ile jest wierszy odpowiadajacej danej kolumnie
  
  second_considering<-as.data.frame(second_considering)
  #traktujemy wynik poprzedniej operacji jako data.frame
  
  Questions<-second_considering
  #utozsamiamy Questions z wynikiem poprzedniej operacji
  
  Questions<-filter(Questions,!is.na(Questions$OwnerUserId))
  #z Questions wybieramy tylko te wiersze, w ktorych OwnerUserId nie jest NA
  
  
  connected_data<- inner_join(Questions, Answers, by= "OwnerUserId")
  #joinujemy Questions z Answers przy uzyciu inner_join to znaczy, ze bedziemy rozwazali tylko takie wiersze gdzie
  #Questions.OwnerUserId=Answers.OwnerUserId
  
  
  filter(connected_data, connected_data$AnswersNumber> connected_data$QuestionsNumber)->connected_data
  #wybieramy tylko te wiersze gdzie AnswersNumber > QuestionsNumber
  
  connected_data<- connected_data %>% arrange(desc(AnswersNumber))
  #porzadkujemy po AnswersNumber w kolejnosci nierosnacej
  
  PostsCounts<-connected_data
  #utozsamiamy PostsCounts z naszymi danymi
  
  PostsCounts<-slice(PostsCounts,1:5)
  #wybieramy tylko pierwsze 5 wierszy
  
  looking_data<- inner_join(PostsCounts, Users, by=c("OwnerUserId"="Id"))
  #joinujemy PostsCounts z Users przy uzyciu inner_join to znaczy, ze bedziemy rozwazali tylko takie wiersze gdzie
  #PostsCounts.OwnerUserId=Users.Id
  
  looking_data<-select(looking_data,DisplayName, QuestionsNumber, AnswersNumber, Location, Reputation,UpVotes, DownVotes)
  #wybieramy kolumny DisplayName, QuestionsNumber, AnswersNumber, Location, Reputation, UpVotes, DownVotes
  
  looking_data 
}