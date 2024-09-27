WITH CTE1 AS (SELECT customer, ROUND(SUM(net_sales)/1000000,2) as net_sales
 FROM gdb0041.net_sales
 WHERE fiscal_year = 2021
 GROUP BY customer
 ORDER BY net_sales desc
 )
 select *,net_sales*100/sum(net_sales) OVER() as pct
 from cte1
 
