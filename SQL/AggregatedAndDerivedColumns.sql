#print all the years where more than 2 movies were returned. Note that using WHERE count>2 or WHERE count(release_year)>2 is giving an error because SQL operates as:
#FROM --> WHERE --> GROUP BY --> HAVING --> ORDER BY
#Having is used with GROUP BY. Having should have columns that are mentioned in the SELECT statement. Where can have any columns mentione anywhere in the table
SELECT release_year,count(release_year) as movies_count
FROM movies
GROUP BY release_year
HAVING movies_count>2
ORDER BY movies_count DESC;
#from actors table find the age
SELECT *, YEAR(CURDATE())-birth_year as Age FROM actors; #here age is a derived column
#from financials table find the profit
SELECT *, (revenue-budget) AS profit FROM financials;
#For uniformity we need all profits in a single currency. lets do the same in INR
SELECT *,
IF (currency='USD',revenue*77,revenue) AS revenue_inr
FROM financials;

#find out how many currencies and units are there so that we can approach data cleaning
select distinct currency from financials;
select distinct unit from financials;
#all currency is in INR. now lets make  all the units to millions
SELECT *,
CASE
WHEN unit="Thousands" THEN  revenue/1000
WHEN unit="Billions" THEN  revenue*1000
ELSE revenue
END as revn_miln
FROM financials;
