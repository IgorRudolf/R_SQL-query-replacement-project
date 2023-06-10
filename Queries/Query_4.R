sql_4 <- function(Posts, Users){
  sqldf("SELECT DisplayName, QuestionsNumber, AnswersNumber, Location, Reputation, UpVotes, DownVotes
  FROM (
  SELECT *
  FROM (
  SELECT COUNT(*) as AnswersNumber, OwnerUserId
  FROM Posts
  WHERE PostTypeId = 2
  GROUP BY OwnerUserId
  ) AS Answers
  JOIN
        (
  SELECT COUNT(*) as QuestionsNumber, OwnerUserId
  FROM Posts
  WHERE PostTypeId = 1
  GROUP BY OwnerUserId
  ) AS Questions
  ON Answers.OwnerUserId = Questions.OwnerUserId
  WHERE AnswersNumber > QuestionsNumber
  ORDER BY AnswersNumber DESC
  LIMIT 5 ) AS PostsCounts
         JOIN Users
  ON PostsCounts.OwnerUserId = Users.Id")
}