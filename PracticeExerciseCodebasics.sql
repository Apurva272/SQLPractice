#Print all movie titles and release year for all Marvel Studios movies.
SELECT title,release_year FROM movies
WHERE studio = "Marvel Studios";
#2. Print all movies that have Avenger in their name.
SELECT title FROM movies
WHERE title LIKE '%Avenger%';
#3. Print the year when the movie "The Godfather" was released.
SELECT title,release_year FROM movies
WHERE title LIKE "%Godfather%";
#4. Print all distinct movie studios in the Bollywood industry.
SELECT distinct studio FROM movies
WHERE industry="Bollywood";
#5. Print all movies in the order of their release year (latest first)
SELECT title,release_year FROM movies
ORDER BY release_year DESC;
#All movies released in the year 2022
SELECT title,release_year FROM movies
WHERE release_year=2022;
# Now all the movies released after 2020
SELECT title,release_year FROM movies
WHERE release_year>2020;
#All movies after the year 2020 that have more than 8 rating
SELECT title,release_year,imdb_rating FROM movies
WHERE release_year>2020 AND imdb_rating>8;

# Select all movies that are not from Marvel Studios
SELECT title, studio from movies
WHERE studio!= 'Marvel Studios';
#Select all THOR movies by their release year
SELECT title,release_year from movies
WHERE title LIKE '%Thor%'
ORDER BY release_year DESC;
# Select all movies that are by Marvel studios and Hombale Films
SELECT title,studio from movies
WHERE studio IN ("Marvel Studios", "Hombale films");
#How many movies were released between 2015 and 2022
SELECT title,release_year from movies
WHERE release_year BETWEEN 2015 AND 2022
ORDER BY release_year;
# Print the max and min movie release year
SELECT max(release_year) as latest, min(release_year) as oldest
FROM movies;
#another approach for max
SELECT release_year FROM movies
ORDER BY release_year DESC 
LIMIT 1;
#Print a year and how many movies were released in that year starting with the latest year
SELECT release_year, count(release_year) as count
FROM movies
GROUP BY release_year
ORDER BY release_year DESC;
# Print profit % for all the movies
SELECT *, revenue-budget as profit, (((revenue-budget)*100)/budget) as profitpercent
FROM financials
ORDER BY profitpercent DESC;