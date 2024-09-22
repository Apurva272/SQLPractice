#The product owner needs monthly aggregate gross report for Croma India so that she can track how much sales this particular
#customer is generating for Atliq and manage our relationships accordingly
#the report should hav the following fields:
#month
#gross sales to Croma India this month --> ONLY FULL GROUP BY
SELECT  get_month(date) as fiscal_month, SUM(sold_quantity*gross_price) as gross_price_total
from fact_sales_monthly s
join dim_product p
ON s.product_code = p.product_code
join fact_gross_price gp
ON s.product_code=gp.product_code AND get_fiscal_year(s.date) = gp.fiscal_year #this is imp because gross price changes with year
WHERE customer_code = 90002002 AND
get_fiscal_year(date)=2021 
GROUP BY fiscal_month;
#Generate a yearly report for Croma India where there are two columns
#1. Fiscal Year
#2. Total Gross Sales amount In that year from Croma
SELECT  get_fiscal_year(s.date) as fiscal_year, SUM(s.sold_quantity*gp.gross_price) as gross_price_total
from fact_sales_monthly s
join fact_gross_price gp
ON s.product_code=gp.product_code and year(s.date) = gp.fiscal_year
WHERE customer_code = 90002002
GROUP BY get_fiscal_year(s.date);