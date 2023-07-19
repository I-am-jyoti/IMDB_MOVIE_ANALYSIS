-- IMDb Movies Analysis using SQl
-- Que 1 -- What are the different tables in the database and how are they connected to each other
-- in the database?
-- ANS-- DIFFERENT TABLE IN DATABASE
-- TABLE 1 - ROLL MAPPING
-- This table defins each movie with a unique identification number and the category of the movie_id which a
-- movie falls.
-- Table 2 - MOVIE:-
-- This table contains information of each movie with unique ID,TITLE,YEAR,DATE OF PUBLICATION, DURATION OF THE MOVIE 
-- COUNTRY OF ORIGIN e.t.c
-- Table 3 --DITRECTOR MAPPING:-
-- Contains a bridge mapping  or MOVIE ID and NAME ID.
-- Table 4- RATINGS
-- This table contains performance related information of each movie like AVERAGE RATING,TOTAL VOTES and
-- MEDIAN RATING movie allocated to individual MOVIE ID.
-- Table 5- GENRE
-- Links a genre to a unique movie ID. This table associates each movie with its respective genre.
-- Table 6- NAMES
-- This table contains information of names like name, height date of birth and so on,mapped to each unique 
-- name ID
-- CONNECT TO EACH OTHER :-
-- ROLL_MAPPING  is connected to MOVIE table on 1:1 mapping on MOVIE_ID in ROLE_MAPPING table to ID column in
-- NAME table.
-- ROLL_MAPPING  is connected to NAMES table on 1:1 mapping on  NAMES_ID in ROLE_MAPPING table to ID column in
-- NAME table.
-- NAME  is connected to DIRECTIOR_MAPPING table on 1:1 mapping on ID in NAMES table to NAME_ID column in 
-- DIRECTOR_MAPPING table.
-- DIRECTOR_MAPPING is connected to MOVIE table on 1:1 mapping on MOVIE_ID in DIRECTIOR_MAPPING table to ID
-- column in MOVIE table.
-- MOVIE is connected to GENRE  table on 1:1 mapping on ID in MOVIE table to MOVIE_ID column in GENRE table.
-- MOVIE is connected to RATING  table on 1:1 mapping on ID in MOVIE table to MOVIE_ID column in RATING table.

-- Que.2-- Find the total number of rows in each table of the schema.
SELECT table_name,table_rows  			
FROM INFORMATION_SCHEMA.TABLES		
WHERE TABLE_SCHEMA = 'imdb';

-- The result of this query will be a list of table names from the "imdb" schema along with the corresponding
-- rowcounts for each table. This information allows you to see the number of rows present in each table
-- within the specified schema, which can be useful for understanding the data volume and distribution. It
-- provides an overview of the size and scale of each table within the "imdb" schema.			
									
-- Que 3-- Identify which columns in the movie table have null values.                                       
SELECT
  COUNT(*) AS total_rows,
  SUM(IF(id IS NULL, 1, 0)) AS null_id_count,
  SUM(IF(title IS NULL, 1, 0)) AS null_title_count,
  SUM(IF(year IS NULL, 1, 0)) AS null_year_count,
  SUM(IF(date_published IS NULL, 1, 0)) AS null_date_published_count,
  SUM(IF(duration IS NULL, 1, 0)) AS null_duration_count,
  SUM(IF(country IS NULL, 1, 0)) AS null_country_count,
  SUM(IF(worlwide_gross_income IS NULL, 1, 0)) AS null_worldwide_gross_income,
  SUM(IF(languages IS NULL, 1, 0)) AS null_languages_count,
  SUM(IF(production_company IS NULL, 1, 0)) AS null_production_company_count
FROM movie;
-- The result of this query will provide a summary of the number of null values for each column in the "movie" 
-- table. It helps identify which columns contain null values, which can be useful for data validation and 
-- quality control.
