#Join details of movies with their financial collections using Joins.
#in this case we will use Inner join
SELECT m.movie_id,title,budget,revenue,currency,unit #select all columns from both the tables
FROM movies m
JOIN financials f
ON m.movie_id = f.movie_id;
SELECT distinct COUNT(*) FROM movies;
SELECT distinct COUNT(*) FROM financials;
#Inner join only returns the common fields of both tables., Right now Sholay and inception are not present.
#If I want to include the movies Sholay and Inception from left table (from table), + whatever is common, we will use left join
SELECT m.movie_id,title,budget,revenue,currency,unit
FROM movies m
LEFT JOIN financials f
ON m.movie_id = f.movie_id;
#Similar for right join
SELECT  f.movie_id,title,budget,revenue,currency,unit
FROM movies m
RIGHT JOIN financials f
ON m.movie_id = f.movie_id;
#Outer join: select all records from both the tables. Note: columns should be same as well as Count does not work here
SELECT  m.movie_id,title,budget,revenue,currency,unit
FROM movies m
LEFT JOIN financials f
ON m.movie_id = f.movie_id
UNION
SELECT  f.movie_id,title,budget,revenue,currency,unit
FROM movies m
RIGHT JOIN financials f
ON m.movie_id = f.movie_id;
#using keyword: used when both tables have same column names as common, then ON is not used
SELECT  movie_id,title,budget,revenue,currency,unit
FROM movies m
RIGHT JOIN financials f
USING (movie_id)