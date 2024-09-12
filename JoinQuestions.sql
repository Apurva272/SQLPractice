#Show all the movies with their language names
SELECT title,name
FROM movies m
JOIN languages l
ON m.language_id = l.language_id;
# Show all Telugu movie names (assuming you don't know the language id for telugu
SELECT title,name
from languages as l
join movies as m
ON l.language_id = m.language_id
where name = "Telugu";
#Show the language and number of movies released in that language
SELECT name, count(name) as number
FROM languages as l
JOIN movies as m
ON l.language_id = m.language_id
GROUP BY name;
