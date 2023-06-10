base_2 <- function(Posts){
  
  condition<-Posts$PostTypeId %in% c(1,2)
  #rozwazamy wektor true/false spelniajacy powyzszy warunek, ze PostTypeId= 1 lub PostTypeId=2
  
  considering_data_frame<-Posts[condition, c("CreationDate","Score")]
  #rozwazamy tylko te wiersze, ktore spelniaja nasz warunek condition,
  #dodatkowo wybieramy z Posts kolumny CreationDate oraz Score
  
  considering_data_frame["Year"]<- strftime(considering_data_frame$CreationDate, format = "%Y")
  considering_data_frame["Month"]<- strftime(considering_data_frame$CreationDate, format = "%m")
  #Tworzymy dwie nowe kolumny Year oraz Month, przypisujemy do nich odpowiednia date
  #Wyodrebniamy ja z kolumny CreationDate, uzywamy metody strftime
  
  considering_data_frame<-aggregate(considering_data_frame$Score,considering_data_frame[c("Year","Month")] , FUN=function(x){c(MaxScore= max(x), PostsNumber= length(x))})
  #Grupujemy po Year oraz Month, wykonujemy przy uzyciu kolumny Score funkcje, taka, ze, 
  #bedziemy mieli kolumne x, z ktorej bedziemy mogli wyciagnac informacje o MaxScorze oraz PostsNumber 
  
  first<-considering_data_frame[,"x"][,1]
  second<-considering_data_frame[,"x"][,2]
  #Tworzymy dwie pomocnicze zmienne, mamy kolumne x i z niej wyodrebniamy pomocnicze dane
  #Wykorzystamy je ponizej nadpisujac jedna kolumne i tworzac nowa
  
  considering_data_frame[3]<-first
  #Nadpisujemy trzecia kolumne i przypisujemy jej first zdefiniowane powyzej
  
  considering_data_frame["PostsNumber"]<-second
  #Tworzymy nowa kolumne PostsNumber i przypisujemy jej second zdefiniowane powyzej
  
  names(considering_data_frame)[3]<- "MaxScore"
  #Zmieniamy nazwe naszej trzeciej kolumny na MaxScore
  
  considering_data_frame<-considering_data_frame[considering_data_frame$PostsNumber>1000,]
  #Wybieramy z naszych danych te wiersze, w ktorych PostsNumber>1000
  
  considering_data_frame<-considering_data_frame[order(considering_data_frame$Year),]
  #Porzadkujemy nasze dane przez kolumne Year
  
  considering_data_frame<-considering_data_frame[,c(1,2,4,3)]
  #Wybieramy odpowiednie kolumny, musimy 3 z 4 przestawic miejscami, stad ta operacja powyzej
  
  rownames(considering_data_frame)=NULL
  #Pozbywamy sie nazewnictwa wierszy
  
  considering_data_frame
}