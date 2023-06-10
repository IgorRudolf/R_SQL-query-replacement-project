table_4 <- function(Posts, Users){
  
  another_data<-as.data.table(Posts)
  #Traktujemy nasze dane jako data.table
  
  another_data<-another_data[PostTypeId==2, c("Id","OwnerUserId")]
  #wybieramy te wiersze gdzie PostTypeId==2 oraz kolumne OwnerUserId
  
  another_data<-another_data[,.(AnswersNumber=length(Id)),by=.(OwnerUserId)]
  #Grupujemy po OwnerUserId,poza pogrupowana kolumna OwnerUserId rozwazamy jeszcze jedna dodatkowo kolumne AnswersNumber,
  #powstaje ona tak, ze dla poszczegolnych grup liczymy ich ilosc po Id
  #dla poszczegolnej grupy bedziemy mieli konkretna wartosc AnswersNumber, bedaca iloscia wierszy odpowiadajace danej grupie
  
  Answers<-another_data
  #utozsamiamy Answers z naszymi danymi
  
  Answers<-Answers[!is.na(Answers$OwnerUserId),]
  #wybieramy takie wiersze gdzie OwnerUserId nie jest NA
  
  different_data<-as.data.table(Posts)
  #traktujemy dane jako data.table
  
  different_data<-different_data[PostTypeId==1,c("Id","OwnerUserId")]
  #wybieramy te wiersze gdzie PostTypeId==1 oraz kolumne OwnerUserId
  
  different_data<-different_data[,.(QuestionsNumber=length(Id)),by=.(OwnerUserId)]
  #Grupujemy po OwnerUserId,poza pogrupowana kolumna OwnerUserId rozwazamy jeszcze jedna dodatkowo kolumne AnswersNumber,
  #powstaje ona tak, ze dla poszczegolnych grup liczymy ich ilosc po Id
  #dla poszczegolnej grupy bedziemy mieli konkretna wartosc AnswersNumber, bedaca iloscia wierszy odpowiadajace danej grupie
  
  Questions<-different_data
  #utozsamiamy Questions z naszymi danymi
  
  Questions<-Questions[!is.na(Questions$OwnerUserId),]
  #wybieramy takie wiersze gdzie OwnerUserId nie jest NA
  
  connected_data<-merge(Questions, Answers, by= "OwnerUserId")
  #Scalamy rozwazane Questions oraz Answers uzywajac do tego kolumny OwnerUserId
  #Wybieramy tylko te wiersze gdzie Questions.OwnerUserId= Answers.OwnerUserId
  
  PostsCounts<-connected_data<-connected_data[connected_data$AnswersNumber>connected_data$QuestionsNumber, ][order(-AnswersNumber),][1:5]
  #bierzemy tylko te wiersze gdzie AnswersNumber > QuestionsNumber, porzadkujemy po AnswersNumber w kolejnosci nierosnacej bierzemy pierwsze 5 wierszy
  #utozsamiamy nasz wynik z PostsCounts
  
  considering_data<-as.data.table(merge(x = PostsCounts, y = Users[,c("Id","DisplayName","Location", "Reputation","UpVotes", "DownVotes")], by.x = "OwnerUserId", by.y="Id"))
  #Scalamy rozwazane PostsCounts oraz Users(z nich odpowiednie kolumny) uzywajac do tego kolumn OwnerUserId oraz Id
  #Wybieramy tylko te wiersze gdzie PostsCounts.OwnerUserId= Users.Id, wynik traktujemy jako data.table
  
  considering_data<-considering_data[,.(DisplayName, QuestionsNumber, AnswersNumber, Location, Reputation, UpVotes, DownVotes)]
  #wybieramy kolumny DisplayName, QuestionsNumber, AnswersNumber, Location, Reputation, UpVotes, DownVotes
  
  considering_data<-considering_data[order(-AnswersNumber)]
  #porzadkujemy wiersze po kolumnie AnswersNumber w kolejnosci nierosnacej
  
  considering_data<-as.data.frame(considering_data)
  #traktujemy nasze dane jako data.frame
  
  considering_data
}