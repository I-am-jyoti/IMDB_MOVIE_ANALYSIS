-- Que 1--Identify the columns in the names table that have null values.
SELECT COUNT(*) - COUNT(ID)               AS id_nulls,
       COUNT(*) - COUNT(NAME)             AS name_nulls,
       COUNT(*) - COUNT(HEIGHT)           AS height_nulls,
       COUNT(*) - COUNT(DATE_OF_BIRTH)    AS date_of_birth_nulls,
       COUNT(*) - COUNT(KNOWN_FOR_MOVIES) AS known_for_movies_nulls
FROM   NAMES; 
-- The results of this query indicate the number of null values for each column in the names table:

-- There are 0 null values in the ID column.
-- There are 0 null values in the NAME column.
-- There are 17,335 null values in the HEIGHT column.
-- There are 13,431 null values in the DATE_OF_BIRTH column.
-- There are 15,226 null values in the KNOWN_FOR_MOVIES column.
-- This information allows you to identify the specific columns in the names table that contain null values.
-- It shows that the ID and NAME columns do not have any null values, while the HEIGHT, DATE_OF_BIRTH, and 
-- KNOWN_FOR_MOVIES columns have varying numbers of null values. Understanding the presence of null values helps
-- in assessing the completeness and quality of the data in each column, allowing for appropriate data handling 
-- and analysis.

-- Que 2---Determine the top three directors in the top three genres with movies having an average rating > 8.
WITH TOP_3_GENRE
AS
  ( SELECT     GENRE
	FROM       RATINGS R
   INNER JOIN MOVIE M ON R.MOVIE_ID=M.ID
   INNER JOIN GENRE USING (MOVIE_ID)
   WHERE AVG_RATING > 8
   GROUP BY   GENRE
   ORDER BY   COUNT(GENRE) DESC
   LIMIT      3 )
  SELECT     NAME AS director_name,
             COUNT(NAME) AS movie_count
  FROM       RATINGS R
  INNER JOIN MOVIE M ON R.MOVIE_ID=M.ID
  INNER JOIN GENRE USING (MOVIE_ID)
  INNER JOIN DIRECTOR_MAPPING D
  USING      (MOVIE_ID)
  INNER JOIN NAMES N ON D.NAME_ID=N.ID
  WHERE GENRE IN(
  SELECT *
  FROM   TOP_3_GENRE)
  AND AVG_RATING>8
  GROUP BY   NAME
  ORDER BY   COUNT(NAME) DESC
  LIMIT      3 ;
 -- This information allows you to identify the most successful directors in terms of movie counts and
 -- high ratings within the top genres. It provides insights into the directors who have excelled in creating
 -- movies with a strong audience appeal and positive ratings in specific genres.



-- Que-3 Find the top two actors whose movies have a median rating >= 8.
SELECT NAME AS 'ACTOR_NAME'
FROM NAMES
INNER JOIN ROLE_MAPPING ON ID=NAME_ID
INNER JOIN RATINGS USING (MOVIE_ID)
WHERE MEDIAN_RATING >=8 AND CATEGORY= 'ACTOR'
GROUP BY NAME
ORDER BY COUNT(NAME) DESC
LIMIT 2;
-- This query helps identify the actors who have consistently appeared in movies with high median ratings.
-- It highlights the top performers in terms of movie ratings, showcasing their success in delivering movies
-- that have garnered positive reviews and high ratings.

-- Que 4-Identify the top three production houses based on the number of votes received by their movies.
SELECT PRODUCTION_COMPANY, SUM(TOTAL_VOTES) AS 'VOTE_COUNT'
FROM MOVIE
INNER JOIN RATINGS ON ID=MOVIE_ID
GROUP BY PRODUCTION_COMPANY
ORDER BY VOTE_COUNT DESC
LIMIT 3;
-- his information allows you to identify the most popular production houses based on the number of votes
-- their movies have received. It indicates the level of audience engagement and appreciation for movies
-- produced by these production houses.

-- Que-5-Rank actors based on their average ratings in Indian movies released in India.
WITH ACTORS AS(SELECT   NAME      AS actor_name ,
                        SUM(TOTAL_VOTES)    AS total_votes,
                        COUNT(NAME)  AS movie_count,
                        ROUND(SUM(AVG_RATING * TOTAL_VOTES) / SUM(TOTAL_VOTES)) AS actor_avg_rating
             FROM       NAMES N
             INNER JOIN ROLE_MAPPING RO
             ON         N.ID = RO.NAME_ID
             INNER JOIN MOVIE M
             ON         RO.MOVIE_ID = M.ID
             INNER JOIN RATINGS RA
             ON         M.ID = RA.MOVIE_ID
             WHERE      COUNTRY like 'india'
             AND        CATEGORY = 'actor'
             GROUP BY   NAME
             HAVING     MOVIE_COUNT >= 5)
  SELECT   *,
           DENSE_RANK() OVER ( ORDER BY ACTOR_AVG_RATING DESC, TOTAL_VOTES DESC) AS actor_rank
  FROM     ACTORS;
-- This information allows you to identify and compare the actors based on their average ratings in Indian movies.
-- It helps recognize the actors who have consistently delivered movies with high average ratings and have gained
-- popularity and audience appreciation in the Indian film industry.

-- Que-6 Identify the top five actresses in Hindi movies released in India based on their average ratings.
WITH ACTRESS AS(SELECT   NAME      AS actress_name ,
                        SUM(TOTAL_VOTES)    AS total_votes,
                        COUNT(NAME)  AS movie_count,
                        ROUND(SUM(AVG_RATING * TOTAL_VOTES) / SUM(TOTAL_VOTES)) AS actress_avg_rating
             FROM       NAMES N
             INNER JOIN ROLE_MAPPING RO
             ON         N.ID = RO.NAME_ID
             INNER JOIN MOVIE M
             ON         RO.MOVIE_ID = M.ID
             INNER JOIN RATINGS RA
             ON         M.ID = RA.MOVIE_ID
             WHERE      LANGUAGES LIKE 'hindi'
             AND        COUNTRY like 'india'
             AND        CATEGORY = 'actress'
             GROUP BY   NAME
             HAVING     MOVIE_COUNT >= 3)
  SELECT   *,
           DENSE_RANK() OVER ( ORDER BY ACTRESS_AVG_RATING DESC, TOTAL_VOTES DESC) AS actress_rank
  FROM     ACTRESS;		
  
 -- The result of this query provides a ranking of the top five actresses in Hindi movies released in India 
-- based on their average ratings. Each row represents an actress, including their name, total votes, movie 
--  count, average rating, and rank. The ranking is determined by considering both average rating and total 
--  votes, showcasing the actresses who have achieved higher ratings and garnered more votes in their movies.

-- This information allows you to identify and compare the top actresses in Hindi movies based on their average 
-- ratings. It highlights the actresses who have consistently delivered movies with high average ratings and have
-- gained popularity and audience appreciation in the Hindi film industry.


