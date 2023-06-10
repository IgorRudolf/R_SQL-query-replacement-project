base_5 <- function(Posts, Comments, Users){
  
  first_data<-Comments[, c("PostId","Score")]
  #Wybieramy z Comments kolumny PostId oraz Score
  
  first_data<-aggregate(first_data$Score, first_data[c("PostId")], FUN=function(x){c(CommentsTotalScore= sum(x))})
  #Robimy operacje sumy po Score, grupujemy po kolumnie PostId
  
  names(first_data)[2]<-"CommentsTotalScore"
  #Zmieniamy nazwe drugiej kolumny na CommentsTotalScore
  
  CmtTotScr<-first_data
  #Utozsamiamy nasze data.frame z CmtTotScr
  
  connected_data<-merge(CmtTotScr, Posts[,c("Id","OwnerUserId","Title","CommentCount","ViewCount","PostTypeId")], by.x = "PostId",by.y="Id")
  #scalamy CmtTotScr oraz Posts(z niego wybieramy pewne kolumny) uzywajac do tego kolumn PostId oraz Id
  #wybieramy tylko te wiersze gdzie Posts.Id = CmtTotScr.PostId
  
  connected_data<-connected_data[connected_data$PostTypeId==1,c("OwnerUserId", "Title","CommentCount","ViewCount","CommentsTotalScore")]
  #wybieramy tylko te wiersze gdzie PostTypeId==1 oraz kolumny OwnerUserId, Title, CommentCount, ViewCount i CommentsTotalScore
  
  PostsBestComments<-connected_data
  #Utozsamiamy nasz data.frame z PostsBestComments
  
  total_data<- merge(Users,PostsBestComments, by.x= "Id", by.y="OwnerUserId")
  #scalamy Users z PostsBestComments uzywajac do tego kolumn Id oraz OwnerUserId
  #wybieramy tylko te wiersze gdzie Users.Id== PostsBestComments.OwnerUserId
  
  total_data<-total_data[,c("Title","CommentCount","ViewCount","CommentsTotalScore","DisplayName","Reputation","Location")]
  #wybieramy nastepnie kolumny Title, CommentCount, ViewCount, CommentsTotalScore, DisplayName, Reputation, Location
  
  total_data<-head(total_data[order(total_data$CommentsTotalScore,decreasing = TRUE),],10)
  #porzadkujemy nasz data.frame po CommentsTotalScore w kolejnosci nierosnacej, wybieramy nastepnie pierwsze 10 wierszy
  
  rownames(total_data)<-NULL
  #Pod koniec pozbywamy sie nazewnictwa wieszy
  
  total_data 
}