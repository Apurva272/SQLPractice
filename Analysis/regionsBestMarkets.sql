#Retrieve the top 2 markets in every region by their gross sales amount in FY=2021.
# i.e. result should look something like this,
#market region gross_sales_million  rank
WITH cte1 as (SELECT c.market,
       c.region,
      round(sum( p.gross_price * s.sold_quantity)/1000000,2) AS total_gross_sales_mln
FROM fact_sales_monthly s
JOIN fact_gross_price p
  ON s.product_code = p.product_code AND s.fiscal_year = p.fiscal_year
JOIN dim_customer c
ON s.customer_code = c.customer_code
WHERE s.fiscal_year = 2021
GROUP BY market
ORDER BY total_gross_sales_mln desc
),
cte2 as (SELECT *,  dense_rank() over (partition by region order by total_gross_sales_mln desc) as drnk
FROM CTE1)
SELECT * FROM CTE2
WHERE drnk<=2
ORDER BY region

