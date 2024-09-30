#top market with net sales in millions
SELECT market, ROUND(SUM(net_sales)/1000000,2) as net_sales
 FROM gdb0041.net_sales
 WHERE fiscal_year = 2021
 GROUP BY market
 ORDER BY net_sales desc
 LIMIT 5;
#top n customers
SELECT customer, ROUND(SUM(net_sales)/1000000,2) as net_sales
 FROM gdb0041.net_sales
 WHERE fiscal_year = 2021
 GROUP BY customer
 ORDER BY net_sales desc
 LIMIT 5;
 #exercise: Write a stored procedure to get the top n products by net sales for a given year. Use product name without a variant.
 SELECT product, ROUND(SUM(net_sales)/1000000,2) as net_sales
 FROM gdb0041.net_sales
 WHERE fiscal_year = 2021
 GROUP BY product
 ORDER BY net_sales desc
 LIMIT 5;