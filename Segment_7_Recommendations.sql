-- Based on the analysis, provide recommendations for the types of content Bolly movies should focus on producing.

-- From our analysis we could see  that, movie productions have gone down from 2017 to 2019 while March appears to be the month having most number of releases.
-- Out of all movies produced in the years between (2017 to 2019), 4285 were in the Drama genre is the highest
-- Bollywood should focus on top genres like Drama, Comedy, Thrillers , Action & Horror for upcoming productions.
-- For global partnership, bollywood must consider Marvel Studios, Twentieth Century Fox, Warner Bros. or Star Cinema as they have highest rating hit of movies.
-- James Mangold, Joe Russo or Anthony Russo can be hired as the director of next bollywood project as they have James Mangold can be hired as the director for Bollywood's next project as he has the most number of movies with excellent IMDB ratings
-- Based on the median rating.,We can consider either Mohanlal or Mammotty for the lead actor.
--  Vijay Sethupathi, Fahadh Faasil or Yogi Babu can be considered male actors in indian films & Taapsee Pannu can be considered as the lead actress..


-- QUE 1 * Determine the average duration of movies released by Bolly Movies compared to the industry average.
SELECT
    AVG(CASE WHEN COUNTRY = 'India' and Languages = 'Hindi' THEN duration END) AS bolly_movies_average_duration,
    AVG(duration) AS industry_average_duration
FROM
    MOVIE;
    
-- The result of this query provides the average duration of movies released by Bolly Movies and the average
-- duration of movies in the overall industry. The comparison allows you to understand the average movie
-- duration specifically for Bolly Movies in comparison to the industry as a whole.

-- This information helps you assess the average movie duration for Bolly Movies and determine if it
-- differs from the overall industry average. It provides insights into the typical length of movies produced
-- by Bolly Movies and their deviation from the industry standard.






-- QUE2 * Analyse the correlation between the number of votes and the average rating for movies produced by Bolly Movies.
SELECT
    sum(TOTAL_VOTES) AS NO_OF_VOTE,
    AVG(avg_rating) AS AVG_RATING
FROM ratings
inner join movie on id=movie_id
WHERE COUNTRY= 'INDIA' and languages= 'Hindi'
;
-- The result of this query provides two average duration values: one for movies released by Bolly Movies and 
-- the other for movies in the overall industry. This allows for a comparison between the average movie 
-- duration of Bolly Movies and the average movie duration across the industry.

-- This information enables you to analyze the average duration of movies produced by Bolly Movies and
-- understand how it differs from the industry average. It provides insights into the typical length of
--  movies associated with Bolly Movies and helps assess whether they deviate significantly from the general
-- trend in the industry.






-- QUE 3 * Find the production house that has consistently produced movies with high ratings over the past three years.
SELECT
    production_company,
    AVG(avg_rating) AS average_rating
FROM movie
JOIN ratings ON movie_id = id
GROUP BY
    production_company
HAVING
    COUNT(DISTINCT year) = 3
ORDER BY
    average_rating DESC;

-- The result of this query provides the production house that has consistently produced movies with high 
-- ratings over the past three years. Each row represents a production company, including the average rating 
-- of the movies they have produced.

-- This information allows you to identify the production house that has maintained a track record of consistently
-- delivering high-rated movies over a three-year period. It highlights their ability to consistently produce
--   movies that have received positive ratings from audiences or critics.



-- QUE 4* Identify the top three directors who have successfully delivered commercially successful movies with high ratings.
SELECT 
    name_id as director_name,
    AVG(avg_rating) AS average_rating
FROM role_mapping
JOIN movie  ON movie_id = id
JOIN ratings using (movie_id)
GROUP BY director_name
HAVING COUNT(*) >= 5
ORDER BY average_rating DESC
LIMIT 3;
-- The result of this query provides the names of the top three directors who have successfully delivered
-- commercially successful movies with high ratings. Each row represents a director, including their name
-- and 
-- the average rating of the movies they have directed.

-- This information allows you to identify the directors who have consistently delivered movies with high
-- ratings, indicating their success in both critical acclaim and commercial success. It helps recognize the
-- directors who have achieved a balance between positive ratings and commercial viability, making them stand
--  out in the film industry.





