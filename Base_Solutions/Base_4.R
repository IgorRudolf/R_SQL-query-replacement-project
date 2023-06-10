base_4 <- function(Posts, Users){
  
  considering_posts<-Posts[Posts$PostTypeId==2,]
  #wybieramy z Posts wszystkie takie wiersze, ze PostTypeId==2
  
  our_data<-considering_posts[, c("OwnerUserId")]
  #wybieramy kolumne OwnerUserId
  
  our_data<-as.data.frame(our_data)
  #traktujemy wybrana kolumne jako data.frame
  
  names(our_data)<-"OwnerUserId"
  #nadajemy naszej kolumnie nazwe OwnerUserId
  
  our_data<-aggregate(our_data$OwnerUserId, our_data[c("OwnerUserId")],FUN=length)
  #Patrzymy ile jest wystepowan danych OwnerUserId dla danej grupy grupujac po kolumnie OwnerUserId
  
  names(our_data)[2]<-"AnswersNumber"
  #drugiej kolumnie nadajemy nazwe AnswersNumber
  
  Answers<-our_data
  #utozsamiamy Answers z rozwazanym data.frame
  
  Answers<-Answers[!is.na(Answers$AnswersNumber),]
  #pozbywamy sie tych wierszy gdzie AnswersNumber jest NA
  
  another_considering_posts<-Posts[Posts$PostTypeId==1,]
  #rozwazamy tylko te wiersze gdzie PostTypeId==1
  
  another_data<-another_considering_posts[,c("OwnerUserId")]
  #wybieramy kolumne OwnerUserId
  
  another_data<-as.data.frame(another_data)
  #traktujemy nasz wynik jako data.frame
  
  names(another_data)<-"OwnerUserId"
  #nadajemy naszej kolumnie nazwe OwnerUserId
  
  another_data<-aggregate(another_data$OwnerUserId, another_data[c("OwnerUserId")], FUN=length)
  #Patrzymy ile jest wystepowan danych OwnerUserId dla danej grupy grupujac po kolumnie OwnerUserId
  
  names(another_data)[2]<-"QuestionsNumber"
  #zmieniamy nazwe drugiej kolumny na QuestionsNumber
  
  Questions<-another_data
  #utozsamiamy Questions z rozwazanym data.frame
  
  Questions<-Questions[!is.na(Questions$QuestionsNumber),]
  #pozbywamy sie tych wierszy gdzie QuestionsNumber jest NA
  
  our_new_data<-merge(Questions, Answers, by= "OwnerUserId")
  #Scalamy rozwazane Questions oraz Answers uzywajac do tego kolumny OwnerUserId
  #Wybieramy tylko te wiersze gdzie Questions.OwnerUserId= Answers.OwnerUserId
  
  our_new_data<-our_new_data[our_new_data$AnswersNumber> our_new_data$QuestionsNumber,]
  #rozwazamy tylko te wiersze gdzie AnswersNumber > QuestionsNumber
  
  our_new_data<- our_new_data[order(our_new_data$AnswersNumber,decreasing = TRUE),]
  #porzadkujemy nasze dane po kolumnie AnswersNumber w porzadku nierosnacym
  
  our_new_data<-head(our_new_data,5)
  #wybieramy tylko pierwsze 5 wierszy
  
  rownames(our_new_data)<-NULL
  #pozbywamy sie nazewnictwa wierszy
  
  PostsCounts<-our_new_data
  #utozsamiamy rozwazany data.frame z PostsCounts
  
  considering_data<-merge(x = PostsCounts, y = Users[,c("Id","DisplayName","Location", "Reputation","UpVotes", "DownVotes")], by.x = "OwnerUserId", by.y="Id")
  #Scalamy rozwazane PostsCounts oraz Users(z nich odpowiednie kolumny) uzywajac do tego kolumn OwnerUserId oraz Id
  #Wybieramy tylko te wiersze gdzie PostsCounts.OwnerUserId= Users.Id
  
  considering_data<-considering_data[,c("DisplayName", "QuestionsNumber", "AnswersNumber", "Location","Reputation","UpVotes","DownVotes")]
  #wybieramy kolumny DisplayName, QuestionsNumber, AnswersNumber, Location, Reputation, UpVotes, DownVotes
  
  considering_data<-considering_data[order(considering_data$AnswersNumber,decreasing = TRUE),]
  #porzadkujemy wiersze po kolumnie AnswersNumber w kolejnosci nierosnacej
  
  rownames(considering_data)<-NULL
  #pozbywamy sie nazewnictwa wierszy
  
  considering_data
}