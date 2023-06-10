table_5 <- function(Posts, Comments, Users){
  
  another_considering_data<-as.data.table(Comments)
  #Traktujemy nasze dane jako data.table
  
  CmtTotScr<-another_considering_data<-another_considering_data[,.(CommentsTotalScore=sum(Score)),by=.(PostId)]
  #Grupujemy po PostId,poza pogrupowana kolumna lokacji rozwazamy jeszcze jedna dodatkowo kolumne CommentsTotalScore,
  #powstaje ona tak, ze dla poszczegolnych grup liczymy ich sume po Score
  #dla poszczegolnej grupy bedziemy mieli konkretna wartosc CommentsTotalScore, bedaca suma Score, ktore maja ta sama grupe
  
  combined_data<-merge(CmtTotScr, Posts, by.x= "PostId",by.y = "Id")
  #Scalamy rozwazane CmtTotScr oraz Posts uzywajac do tego kolumn PostId oraz Id
  #Wybieramy tylko te wiersze gdzie CmtTotScr.PostId= Posts.Id
  
  PostsBestComments<-combined_data<-combined_data[combined_data$PostTypeId==1,]
  #wybieramy tylko te wierszy, w ktorych PostTypeId==1 a nastepnie nasz rozwazany data.table utozsamiamy z PostsBestComments
  
  PostsBestComments<-PostsBestComments[,.(OwnerUserId,Title,CommentCount,ViewCount,CommentsTotalScore)]
  #wybieramy kolumny OwnerUserId, Title, CommentCount, ViewCount, CommentsTotalScore
  
  looking_data<-merge(PostsBestComments,Users,by.x="OwnerUserId",by.y="Id")[order(-CommentsTotalScore)][1:10]
  #Scalamy rozwazane PostsBestComments oraz Users uzywajac do tego kolumn OwnerUserId oraz Id
  #Wybieramy tylko te wiersze gdzie PostsBestComments.OwnerUserId= Users.Id
  #nastepnie porzadkujemy po CommentsTotalScore w kolejnosci nierosnacej, pod koniec wybieramy pierwsze 10 wierszy
  
  looking_data<-looking_data[,.(Title,CommentCount,ViewCount,CommentsTotalScore,DisplayName,Reputation,Location)]
  #wybieramy kolumny Title, CommentCount, ViewCount, CommentsTotalScore, DisplayName, Reputation, Location
  
  looking_data<-as.data.frame(looking_data)
  #Pod koniec traktujemy nasze dane jako data.frame
  
  looking_data
}
