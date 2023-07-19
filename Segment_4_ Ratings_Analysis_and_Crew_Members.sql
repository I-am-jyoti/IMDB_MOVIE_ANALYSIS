-- 1 que--Retrieve the minimum and maximum values in each column of the ratings table (except movie_id).
SELECT
  MIN(movie_id) AS min_movie_id,
  MAX(movie_id) AS max_user_id,
  MIN(avg_rating) AS min_avg_rating,
  MAX(avg_rating) AS max_avg_rating,
  MIN(median_rating) AS min_median_rating,
  MAX(median_rating) AS max_median_rating,
  MIN(total_votes) AS min_total_votes,
  MAX(total_votes) AS max_total_votes
  FROM
  ratings;
 -- This information allows you to understand the range of values present in each column of the ratings table,
 -- providing insights into the distribution and variability of the data. It helps in understanding the minimum
 -- and maximum ratings, median ratings, and total votes recorded for movies in the dataset.
  
-- 2 Que---	Identify the top 10 movies based on average rating.
select title as movies,avg_rating as rating
 from movie inner join ratings on id= movie_id
order by rating desc limit 10;

-- The result of this query is a list of the top 10 movies based on average rating. The "movies" column displays
-- the movie titles, and the "rating" column shows their corresponding average ratings. Each movie is listed with
-- its respective average rating, allowing you to identify the highest-rated movies in the dataset.



-- 3- Summarise the ratings table based on movie counts by median ratings.
SELECT MEDIAN_RATING, COUNT(MOVIE_ID) AS 'MOVIE_COUNT'
FROM RATINGS
GROUP BY MEDIAN_RATING
ORDER BY MEDIAN_RATING ASC;
-- median_rating     movie_count
-- The result of this query will provide a summary of movie counts based on median ratings. The "median_rating"
-- column will display the different median rating values, and the "movie_count" column will show the 
-- corresponding count of movies for each median rating.

-- 4-Que-Identify the production house that has produced the most number of hit movies (average rating > 8).
 SELECT PRODUCTION_COMPANY
FROM MOVIE
INNER JOIN RATINGS ON MOVIE_ID=ID
WHERE AVG_RATING>8
ORDER BY AVG_RATING DESC
LIMIT 1;
-- The result of this query is the production house name "A square productions" that has produced the most 
-- number of hit movies with an average rating greater than 8.

-- This information allows you to identify the production house that has been most successful in producing 
-- highly-rated movies, with an average rating exceeding 8. It highlights the production house with the highest
-- average rating among the hit movies, indicating their success in delivering quality films.


-- 5-Que-- Determine the number of movies released in each genre during 
-- 			March 2017 in the USA with more than 1,000 votes.
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
  
  -- The result of this query provides a ranking of actors in India based on their average rating and total 
  -- votes. Each row represents an actor, including their name, total votes, movie count, average rating, and
  -- rank. The ranking is determined by the combination of average rating and total votes, with higher ratings
  -- and votes leading to a higher rank.

-- This information allows you to identify the top-performing actors in India based on their average rating and
-- popularity. It can be useful for evaluating the success and impact of actors in the Indian film industry.
  
-- Qus_6--Retrieve movies of each genre starting with the word 'The' and having an average rating > 8.
SELECT TITLE,avg_rating
FROM GENRE
INNER JOIN MOVIE ON MOVIE_ID =ID
INNER JOIN RATINGS USING (MOVIE_ID)
WHERE AVG_RATING>8 AND (TITLE) LIKE 'The%'
ORDER BY AVG_RATING DESC;              

-- The result of this query provides a list of movies that meet the specified criteria. The "TITLE" colum 
-- the movie titles, and the "avg_rating" column shows their corresponding average ratings. The movies are listed
-- in descending order of average rating.

-- This information allows you to identify movies of each genre that start with the word 'The' and have received 
-- high average ratings. It provides insights into well-rated movies with specific naming patterns, allowing you 
-- to explore movies that have garnered positive reviews and ratings.



 



  