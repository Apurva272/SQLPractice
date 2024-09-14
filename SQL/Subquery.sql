#Write a query to return the list of actors whose age is greater than 70 years but less than 80 years
SELECT name,birth_year, Year(now())-birth_year as age
from actors
HAVING age BETWEEN 70 AND 85;
#using subquery
SELECT * from (SELECT name,birth_year, Year(now())-birth_year as age from actors) AS subquery
WHERE age>70 AND age<=80;
#select actors who have performed in movies 101,110,121
SELECT group_concat(a.name separator ', ') as actor,m.title ,m.movie_id
FROM movies m
JOIN movie_actor ma
ON m.movie_id = ma.movie_id
JOIN actors a
on ma.actor_id = a.actor_id
WHERE m.movie_id IN (110,101,121)
GROUP BY m.movie_id;
#using subquery
SELECT * from actors WHERE actor_id IN (select actor_id from movie_actor where movie_id IN (102,110,121));
#using ANY
SELECT * from actors WHERE actor_id = ANY (select actor_id from movie_actor where movie_id IN (102,110,121));
#select all movies whose rating is greater than all of the marvel movies rating
SELECT title, studio,imdb_rating
FROM movies
WHERE imdb_rating>( SELECT max(imdb_rating) AS max FROM movies WHERE studio like "%Marvel%");
#using all keyword
SELECT title, studio,imdb_rating
FROM movies
WHERE imdb_rating >ALL ( SELECT imdb_rating FROM movies WHERE studio like "%Marvel%");
#select all movies whose rating is greater than any marvel movie
#method 1: use min
SELECT title, studio,imdb_rating
FROM movies
WHERE imdb_rating>( SELECT min(imdb_rating) AS max FROM movies WHERE studio like "%Marvel%");
#method 2: use any
SELECT title, studio,imdb_rating
FROM movies
WHERE imdb_rating >ANY( SELECT imdb_rating FROM movies WHERE studio like "%Marvel%") AND studio!="Marvel Studios";

#select the actor NAME and total number of movies they have acted in
SELECT name,count(movie_id) as count
FROM actors a
LEFT JOIN movie_actor ma
ON a.actor_id = ma.actor_id
GROUP BY a.actor_id
ORDER BY count DESC;
#achieving the same result by using subquery
#use explain analyze to find out which query is better
Select name, actor_id,
(Select count(*) from movie_actor where actor_id = actors.actor_id) as numOfMovies #acts as left join because it points to avctor id in the avctor stable
from actors
order by numOfMovies desc;
