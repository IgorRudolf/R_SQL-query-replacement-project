sql_2 <- function(Posts){
  sqldf("SELECT STRFTIME('%Y', CreationDate) AS Year, STRFTIME('%m', CreationDate) AS Month,
  COUNT(*) AS PostsNumber, MAX(Score) AS MaxScore
  FROM Posts
  WHERE PostTypeId IN (1, 2)
  GROUP BY Year, Month
  HAVING PostsNumber > 1000")

}