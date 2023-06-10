sql_3 <- function(Posts, Users){
  
  Questions <- sqldf(
    'SELECT OwnerUserId, SUM(ViewCount) as TotalViews
     FROM Posts 
     WHERE PostTypeId = 1
     GROUP BY OwnerUserId')
  
  sqldf("
          SELECT Id, DisplayName, TotalViews
          FROM Questions
          JOIN Users
          ON Users.Id = Questions.OwnerUserId
          ORDER BY TotalViews DESC
          LIMIT 10")
}