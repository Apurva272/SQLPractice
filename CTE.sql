#movies that produced 500% profit and their rating was less than average rating for all movies
WITH low_imdb AS (SELECT *
FROM movies
WHERE imdb_rating < (select avg(imdb_rating) from movies))
SELECT  title,imdb_rating, (revenue-budget)*100/budget AS profitper
FROM low_imdb l
JOIN financials f
ON l.movie_id = f.movie_id
WHERE (revenue-budget)*100/budget >=500;

#second method of doing by subquery. Make sure that movie_id is present in both the queries
SELECT x.title,x.imdb_rating,y.profit_percent
FROM (SELECT title,imdb_rating,movie_id from movies WHERE imdb_rating < (select avg(imdb_rating) from movies)) AS x
JOIN
(SELECT *,(revenue-budget)*100/budget as profit_percent
FROM financials
) AS y
ON x.movie_id = y.movie_id
WHERE profit_percent>=500;
#method 3
WITH x as  (SELECT * from movies WHERE imdb_rating < (select avg(imdb_rating) from movies)),
y as (SELECT *,(revenue-budget)*100/budget as profit_percent
FROM financials)
SELECT x.title, x.imdb_rating,y.profit_percent
FROM x
JOIN y
ON x.movie_id = y.movie_id
WHERE y.profit_percent>=500;
#Select all Hollywood movies released after the year 2000 that made more than 500 million $ profit or more profit. Note that all Hollywood movies have millions as a unit hence you don't need to do the unit conversion. 
#Also, you can write this query without CTE as well but you should try to write this using CTE only
WITH highprofit as (SELECT * FROM financials WHERE revenue-budget>=500)
SELECT title, release_year,revenue-budget as profit
FROM movies m
JOIN highprofit h
ON m.movie_id = h.movie_id
WHERE release_year>2000;

