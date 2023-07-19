-- Que 1-- Determine the total number of movies released each year and analyse the month-wise trend.
SELECT
  YEAR(date_published) AS release_year,
  COUNT(*) AS total_movies,
  MONTH(date_published) AS release_month
FROM movie
WHERE date_published IS NOT NULL
GROUP BY release_year, release_month
ORDER BY release_year, release_month;

-- The result of this query will provide a summary of the total number of movies released each year, along
-- with the month-wise trend. The data will be presented in chronological order, allowing you to observe any
-- patterns or trends in movie releases over time. You can analyze the distribution of movies across different
-- years and months to identify any seasonality or trends in the movie industry.

-- Que-2-Calculate the number of movies produced in the USA or India in the year 2019.
SELECT year , COUNT(TITLE) AS movie_count
FROM movie
WHERE (country  like '%USA%' OR country like '%India%') AND year = 2019;

-- The summary of this query is that it determines the number of movies produced in either the USA or
-- India in the specific year 2019. The result indicates that a total of 1059 movies were produced in either 
-- of these countries during that year.




