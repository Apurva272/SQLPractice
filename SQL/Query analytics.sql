SELECT MAX(imdb_rating) FROM movies WHERE industry="Bollywood"; #note that when I tried SELECT title, MAX(imdb_rating)... I got an error which means right now I cannot find the movie title with highest rating
SELECT MIN(imdb_rating) FROM movies WHERE industry="Bollywood";
SELECT AVG(imdb_rating) FROM movies WHERE studio LIKE "Marvel%";
#Round off the average to two decimal points
SELECT ROUND(AVG(imdb_rating),2) FROM movies WHERE studio LIKE "Marvel%";
#CUSTOMIZE the column header: rename it from function name
SELECT ROUND(AVG(imdb_rating),2) AS avg_rating,
MAX(imdb_rating) AS max_rating,
MIN(imdb_rating) AS min_rating
 FROM movies 
 WHERE studio LIKE "Marvel%";
 # GROUP BY: If I want to have a analytical function along with other columns, like I want to see title of max rated movie, use Group By
 SELECT industry,COUNT(*)
 FROM movies
 GROUP BY industry;
 #Lets now view title of movies with highest rating in bollywood
 SELECT title ,MAX(imdb_rating) as max
 FROM movies
 GROUP BY title
  LIMIT 1;
#find out the average rating of bollywood and hollywood 
SELECT industry,
COUNT(industry) as count,
ROUND(avg(imdb_rating),2) as avg
FROM movies
GROUP BY industry;
#find average rating of each studio,notice how universal pictures is present twice ; it is a data error
SELECT studio,
COUNT(studio) as count,
ROUND(avg(imdb_rating),2) as avg
FROM movies
WHERE studio is NOT NULL
GROUP BY studio
ORDER BY avg DESC;


