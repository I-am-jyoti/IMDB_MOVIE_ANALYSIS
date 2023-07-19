-- Que1- Classify thriller movies based on average ratings into different categories.
SELECT TITLE AS 'MOVIE_NAME', AVG_RATING,
CASE 
WHEN AVG_RATING>8 THEN 'SUPERHIT MOVIES'
WHEN AVG_RATING BETWEEN 7 AND 8 THEN 'HIT MOVIES'
WHEN AVG_RATING BETWEEN 5 AND 7 THEN 'ONE TIME WATCH MOVIES' 
WHEN AVG_RATING<5 THEN 'FLOP MOVIES'
END AS AVG_RATING
FROM GENRE
INNER JOIN RATINGS USING (MOVIE_ID)
INNER JOIN MOVIE ON MOVIE_ID=ID              
WHERE GENRE='THRILLER';

-- This query provides a summary of thriller movies classified into different categories based on their 
-- average ratings. Each row represents a movie, including the movie name, average rating, and its
-- corresponding category based on the defined rating ranges.

-- By categorizing the thriller movies, this query allows for easier identification and understanding of the
-- quality and popularity of movies within the genre. It helps differentiate between movies that have received
-- exceptional ratings, achieved moderate success, provided a one-time viewing experience, or had lower 
-- ratings indicating less favorable reception.

-- Que 2- analyse the genre-wise running total and moving average of the average movie duration.
WITH avg_duration AS (
  SELECT g.genre, AVG(m.duration) AS avg_duration
  FROM genre g
  JOIN movie m ON g.movie_id = m.id
  GROUP BY g.genre
), 
running_total AS (
  SELECT genre, avg_duration, 
         SUM(avg_duration) OVER (PARTITION BY genre ORDER BY genre) AS genre_running_total
  FROM avg_duration
),
moving_average AS (
  SELECT genre, avg_duration,
         AVG(avg_duration) OVER (PARTITION BY genre ORDER BY genre ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS genre_moving_average
  FROM avg_duration
)
SELECT rt.genre, rt.avg_duration, rt.genre_running_total, ma.genre_moving_average
FROM running_total rt
JOIN moving_average ma ON rt.genre = ma.genre;

-- The result of this query provides the genre-wise analysis of the average movie duration. It includes the genre,
-- average duration, running total of average durations for each genre, and the moving average of average durations
-- for each genre.

-- This information allows you to analyze the trends in average movie durations for different genres. You can 
-- observe the running total of average durations for each genre, providing insights into the cumulative 
-- duration of movies over the genres. Additionally, the moving average helps identify the average duration
-- trend by considering the average durations of the current row and the two preceding rows within each genre.


-- Que-3-Identify the five highest-grossing movies of each year that belong to the top three genres.
WITH top_genres AS (
  SELECT genre
  FROM genre
  GROUP BY genre
  ORDER BY count(genre) DESC
  LIMIT 3
),
ranked_movies AS (
  SELECT m.title, m.year, g.genre,
  CAST(REPLACE(IFNULL(WORLWIDE_GROSS_INCOME,0),'$ ','') AS DECIMAL(10)) AS worldwide_gross_income_$,
ROW_NUMBER() OVER (PARTITION BY YEAR ORDER BY CAST(REPLACE(IFNULL(WORLWIDE_GROSS_INCOME,0),'$ ','') AS DECIMAL(10)) DESC) AS movie_rank
  FROM movie m
  JOIN genre g ON m.id = g.movie_id
  where genre in(
  select *
  from top_genres)
)
  SELECT *
  FROM   ranked_movies
  WHERE  MOVIE_RANK<=5;
  
-- The result of this query provides a list of the five highest-grossing movies for each year within the top 
-- three genres. Each row represents a movie, including the movie title, year, genre, worldwide gross income, 
-- and movie rank.

-- This information allows you to identify the highest-grossing movies in each year and within the top genres. 
-- It helps understand the financial success of movies across different genres and provides insights into the
-- most commercially successful movies released each year within those genres.








-- Que-4-Determine the top two production houses that have produced the highest number of hits among 
-- multilingual movies.
SELECT     production_company,
           COUNT(PRODUCTION_COMPANY)                                  AS movie_count ,
           DENSE_RANK() OVER(ORDER BY COUNT(PRODUCTION_COMPANY) DESC) AS prod_comp_rank
FROM       MOVIE M
INNER JOIN RATINGS RA
ON         M.ID=RA.MOVIE_ID
WHERE      MEDIAN_RATING>=8
AND        LANGUAGES REGEXP ','
GROUP BY   PRODUCTION_COMPANY
LIMIT      2;

-- The result of this query provides the top two production houses that have produced the highest number of 
-- hits among multilingual movies. Each row represents a production company, including the count of movies
--  produced by that company and the production company rank based on the number of hits.

-- This information allows you to identify the production houses that have consistently delivered successful 
-- movies across multiple languages. It highlights their ability to produce a significant number of hits and 
-- indicates their influence in the multilingual movie industry.






-- Que-5-Identify the top three actresses based on the number of Super Hit movies (average rating > 8) in the drama genre.
SELECT NAME AS 'ACTRESS_NAME'
FROM NAMES
INNER JOIN ROLE_MAPPING ON ID=NAME_ID
INNER JOIN RATINGS USING (MOVIE_ID)
INNER JOIN GENRE USING (MOVIE_ID)
WHERE AVG_RATING>8 AND GENRE LIKE 'DRAMA' AND CATEGORY='ACTRESS'
GROUP BY NAME
ORDER BY COUNT(NAME) DESC
LIMIT 3;

-- The result of this query provides the top three actresses who have appeared in the highest number of Super
--  Hit movies within the drama genre. Each row represents an actress's name.

-- This information allows you to identify the actresses who have consistently performed in Super Hit movies 
-- in the drama genre. It highlights their success in delivering exceptional performances and receiving high
-- average ratings for their work.



-- Que-6 Retrieve details for the top nine directors based on the number of movies, including average 
-- inter-movie duration, ratings, and more.

WITH NEXT_DATE_PUBLISH AS (SELECT     NAME_ID AS DIRECTOR_ID,
						NAME    AS DIRECTOR_NAME,
                        AVG_RATING,
                        TOTAL_VOTES,
                        DURATION
             FROM       DIRECTOR_MAPPING D
             INNER JOIN NAMES N
             ON         D.NAME_ID=N.ID
             INNER JOIN MOVIE M
             ON         D.MOVIE_ID=M.ID
             INNER JOIN RATINGS RA
             USING     (MOVIE_ID) )
SELECT   director_id,
           director_name,
           COUNT(DIRECTOR_NAME)                                       AS number_of_movies,
           ROUND(AVG(AVG_RATING))                                   AS avg_rating,
           SUM(TOTAL_VOTES)                                           AS total_votes,
           MIN(AVG_RATING)                                            AS min_rating,
           MAX(AVG_RATING)                                            AS max_rating,
           SUM(DURATION)                                              AS total_duration
  FROM     NEXT_DATE_PUBLISH
  GROUP BY DIRECTOR_ID
  ORDER BY NUMBER_OF_MOVIES DESC
  LIMIT    9;
  
-- The result of this query provides the details for the top nine directors based on the number of movies
-- they have directed. Each row represents a director, including their ID, name, number of movies directed, 
-- average rating, total votes received, minimum and maximum average rating, and the total duration of their movies.

-- This information allows you to identify the top directors based on the number of movies they have directed
-- and provides insights into their average ratings, popularity (measured by total votes), and the total duration 
-- of their movies. It helps analyze the success and impact of these directors in the film industry.