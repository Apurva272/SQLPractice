#Select all the movies with minimum and maximum release_year. Note that there
#can be more than one movie in min and a max year hence output rows can be more than 2
SELECT  title,release_year #max year
FROM movies
WHERE release_year= any (select max(release_year) from movies );
#min 
SELECT  title,release_year #max year
FROM movies
WHERE release_year= any (select min(release_year) from movies );
#Select all the rows from the movies table whose imdb_rating is higher than the average rating
SELECT title,imdb_rating
FROM movies
WHERE imdb_rating > any(select avg(imdb_rating) from movies);
#way 2 for Select all the rows from the movies table whose imdb_rating is higher than the average rating
SELECT title,imdb_rating
FROM movies
WHERE imdb_rating > all (Select avg(imdb_rating) from movies) 
ORDER BY imdb_rating;
#select all the movies with minimum and maximum release_year. Note that there
#can be more than one movie in min and a max year hence output rows can be more than 2
SELECT title,release_year
FROM movies
WHERE release_year IN ((select min(release_year) from movies),(select max(release_year) from movies));