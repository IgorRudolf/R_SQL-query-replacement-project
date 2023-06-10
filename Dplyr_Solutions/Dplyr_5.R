dplyr_5 <- function(Posts, Comments, Users){
  
  first_considering<-select(Comments,PostId,Score)
  #wybieramy z Comments kolumny PostId oraz Score
  
  first_considering <- first_considering %>% group_by(PostId) %>% summarize(CommentsTotalScore=sum(Score))
  #Nastepnie nasz rozwany zbior danych grupujemy po PostId nastepnie przy uzyciu pipe
  #wsadzamy nasze dane do summarise i dokonujemy podsumowania CommentsTotalScore ktore nas interesuje
  #dostajemy nowy data.frame
  
  CmtTotScr<-first_considering<-as.data.frame(first_considering)
  #traktujemy wynik jako data.frame a nastepnie utozsamiamy go z CmtTotScr
  
  connected_considering<- inner_join(CmtTotScr, Posts, by=c("PostId"="Id"))
  #joinujemy CmtTotScr z Posts przy uzyciu inner_join to znaczy, ze bedziemy rozwazali tylko takie wiersze gdzie
  #CmtTotScr.PostId=Posts.Id
  
  PostsBestComments<-filter(connected_considering,connected_considering$PostTypeId==1)
  #bierzemy pod uwage tylko te wiersze, gdzie PostTypeId==1
  
  ultimate_considering<-inner_join(PostsBestComments, Users, by=c("OwnerUserId"="Id"))
  #joinujemy PostsBestComments z Users przy uzyciu inner_join to znaczy, ze bedziemy rozwazali tylko takie wiersze gdzie
  #PostsBestComments.OwnerUserId=Users.Id
  
  ultimate_considering<-ultimate_considering %>% arrange(desc(CommentsTotalScore))
  #przy uzyciu pipe wrzucamy do arrange i porzadkujemy nierosnaco po CommentsTotalScore
  
  ultimate_considering<-select(ultimate_considering,Title, CommentCount, ViewCount, CommentsTotalScore, DisplayName, Reputation, Location)
  #z rozwazanego data.frame wybieramy odpowiednie kolumny 
  
  ultimate_considering<-slice(ultimate_considering,1:10)
  #wybieramy pierwsze 10 wierszy
  
  ultimate_considering
}