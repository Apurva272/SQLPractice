#prepare a menu by joining names and prices of the two tables
Select * , concat(variant_name," ",name) as fullname,(items.price+variant_price) as totalprice
from food_db.items
cross join food_db.variants;
#using movies database, find out movies and their profits
select title,studio,budget,revenue,unit,currency, revenue-budget as profit,ROUND(((revenue-budget)/budget)*100,2) as profitpercent
from movies m
LEFT join financials f
on m.movie_id = f.movie_id
WHERE industry = "Bollywood"
ORDER BY profitpercent;

#There is a discrepancy in the profit because units are not same. we need to normalize profit into one unit, say millions for uniformity
#to do this we will use CASE and END
select title,studio,budget,revenue,unit,currency,
CASE
WHEN unit="thousands" THEN ROUND((revenue-budget)/1000,2)
WHEN unit="billions" THEN ROUND((revenue-budget)*1000,2)
else ROUND(revenue-budget,2)
END as profitinmillions
from movies m
LEFT join financials f
on m.movie_id = f.movie_id
WHERE industry = "Bollywood"
ORDER BY profitinmillions;
#Write a query to find titles of movies with their actors
#for this we need to join more than two tables
#SET @@sql_mode = REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''); #to remove ONLY_FULL_GROUP_BY which is not allowing name from actors file to be grouped by movie id
SELECT title,name
FROM movies m
JOIN movie_actor ma
ON m.movie_id = ma.movie_id
JOIN actors a
ON ma.actor_id = a.actor_id
GROUP by m.movie_id;

#the above query returns only one actor's name, and omits the second. we need comma separated values. to use that we use group concat
#SET @@sql_mode = REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', '');
SELECT m.title, group_concat(a.name SEPARATOR ' | ') as actors
FROM movies m
JOIN movie_actor ma
ON m.movie_id = ma.movie_id
JOIN actors a
ON ma.actor_id = a.actor_id
GROUP BY m.movie_id; 
#now write a query to give actors name and comma separated movies name against each actor
SELECT name as actor, group_concat(title) as movies, count(title) as count
FROM actors a
JOIN movie_actor ma
ON a.actor_id = ma.actor_id
JOIN movies m
ON ma.movie_id = m.movie_id
GROUP BY name;
#Generate a report of all Hindi movies sorted by their revenue amount in millions.
#Print movie name, revenue, currency, and unit
SELECT title,name as language,currency,unit,
CASE
WHEN unit="Thousands" THEN revenue/1000
WHEN unit="Billions" THEN revenue*1000
ELSE revenue
END as revenue_mil
FROM movies as m
JOIN languages as l
ON m.language_id = l.language_id
JOIN financials as f
ON m.movie_id = f.movie_id
WHERE l.name = "Hindi"
ORDER BY revenue_mil DESC;