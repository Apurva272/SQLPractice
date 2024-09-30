# get top n products in each division based on quantity sold
with cte1 as (select p.division,p.product,sum(s.sold_quantity) as total_qty
from fact_sales_monthly s
join dim_product p
ON s.product_code = p.product_code
where fiscal_year = 2021
GROUP BY product),
cte2 as (select *, dense_rank() over (partition by division order by total_qty desc) as drnk
from cte1)
select * from cte2 where drnk<=3
#now create a storecprocedure to define n