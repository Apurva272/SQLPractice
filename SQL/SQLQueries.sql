SELECT title from  movies WHERE title LIKE "%america%";
SELECT title,imdb_rating from movies WHERE imdb_rating BETWEEN 6 AND 9;
#use of IN where we have to use OR: example show list of movies where production house is Marvel studios or Warner bros
SELECT title, studio from movies WHERE studio IN ("Marvel Studios", "Warner Bros. Pictures");
#note: if you use Wildcard symbol % in IN operator, it will throw an error: therefore use full names.
SELECT title,imdb_rating from movies WHERE imdb_rating IN (6,7,8,9);
#extract movies where imdb rating is null
SELECT title,imdb_rating from movies WHERE imdb_rating IS NULL;
SELECT title,imdb_rating from movies WHERE imdb_rating is not NULL;
select count(*) from movies WHERE imdb_rating is NOT NULL;
Select count(*) from movies;
#order by arranges the rows in ascending order by default. 
SELECT title,imdb_rating from movies WHERE industry ="Bollywood" ORDER BY imdb_rating; #arranges in ascending
SELECT title,imdb_rating from movies WHERE industry ="Bollywood" ORDER BY imdb_rating DESC; #arranges in descending
#Top 5 bollywood movies with highest IMDB rating
SELECT title,imdb_rating from movies WHERE industry ="Bollywood" ORDER BY imdb_rating DESC LIMIT 5;
#you know the biggest hit of hollywood movie but want to analyse the other top performing movies, like the top 5 rated movies in hollywood from the second top rated
#then we use the offset operator: from rank 2 to 6
SELECT title,imdb_rating from movies WHERE industry ="Hollywood" ORDER BY imdb_rating DESC LIMIT 5 OFFSET 1;
#what is the 10th highest ranked hollywood movie?
SELECT title,imdb_rating from movies WHERE industry="Hollywood" ORDER BY imdb_rating DESC LIMIT 1 OFFSET 9



