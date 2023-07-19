-- Que 1-- Retrieve the unique list of genres present in the dataset
select distinct(genre) from genre;

-- The result of this query will provide a list of distinct genres present in the dataset. Each genre will
-- appear only once in the result set, eliminating any duplicate genre entries. This allows you to identify
-- the unique genres represented in the dataset, which can be useful for understanding the diversity of genres
-- in the dataset or for further analysis and categorization of movies based on their genres.

-- Que 2-- Identify the genre with the highest number of movies produced overall.
select genre,count(*) as movie_count
from genre group by genre order by
movie_count desc limit 1;

-- The result of this query indicates that the genre with the highest number of movies produced overall is
-- "Drama," with a count of 4285 movies. This information allows you to identify the most prevalent genre in
-- the dataset, providing insights into the overall distribution and popularity of different genres in the
-- movie industry.

-- Que 3--Determine the count of movies that belong to only one genre.
SELECT COUNT(*) AS single_genre_movie_count
FROM (
  SELECT movie_id
  FROM genre
  GROUP BY movie_id
  HAVING COUNT(*) = 1
) AS single_genre_movies;

-- This information allows you to determine the number of movies in the dataset that are associated with 
-- a single genre. It provides insights into the prevalence of single-genre movies and can be useful for 
-- analyzing the diversity of genres within the dataset.

-- Que_4-Average duration of movies in each genre:
SELECT GENRE,
ROUND(AVG(DURATION)) AS 'AVERAGE_DURATION'
FROM MOVIE
INNER JOIN GENRE ON MOVIE_ID=ID
GROUP BY GENRE;

-- this query will provide the average duration of movies in each genre. The "GENRE" column 
-- will list the genres, and the "AVERAGE_DURATION" column will display the corresponding average duration 
-- for each genre. This information allows you to analyze the typical duration of movies in different genres,
-- providing insights into genre-specific trends and preferences in terms of movie length.


-- Qus 5--	Find the rank of the 'thriller' genre among all genres in terms of the number of movies produced.
with CTE as (SELECT genre, COUNT(*) AS movie_count,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS genre_rank
FROM genre
GROUP BY genre
ORDER BY genre_rank)
select genre, 
genre_rank from CTE where genre = 'Thriller';

-- The result of this query will provide the rank of the 'thriller' genre among all genres in terms of the 
-- number of movies produced. The genre rank will be displayed as "3" for the 'thriller' genre.
