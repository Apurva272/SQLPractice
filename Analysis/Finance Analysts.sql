#Atliq hardware case study.
#Croma is a customer of Atliq hardware which is expanding
#Product owner of Atliq hardware wants to generate a report of individual product sales (aggregated on a monthly basis at the product level) 
# for Croma India customers for fy2021 so that the product owner can track individual product sales and run further product analytics
#on it on excel.
#The rpeport should have the following fields
# Month -\/
#product name and variant \/
# sold quantity\/
#gross price per item \/
#gross price total\/
#variants
#--solution--
#first we want to refer to the correct  table: fact table: fact_sales_monthly
#find the correct product code from dimension table customer
SELECT * FROM gdb0041.dim_customer
Where customer like '%croma%' and market = "India";
#The customer code is 90002002, using that in fact_sales_monthly, finding how many products
SELECT * from fact_sales_monthly
WHERE customer_code = 90002002;
#it gives the sold quantity for all produts date wise, we want it month wise for FY21
#FIRST Filtering by calendar year 2021
SELECT * from fact_sales_monthly
WHERE customer_code = 90002002 AND
YEAR(DATE) = 2021 ORDER BY DATE;
#fiscal year at atliq starts in sep of previous year. FY21: Sep 2020- august 2021. therefore , we must add records from sep onwards in the year
SELECT * from fact_sales_monthly
WHERE customer_code = 90002002 AND
YEAR(DATE_ADD(date, INTERVAL 4 MONTH)) = 2021 ORDER BY DATE ; #also defined as get_fiscal_year function
#if you want to check for a particular quarter, (refer quarterandfy file), and getquarterfunction that is created
#if we want to do analysis by quarter using the quarter_fiscal function
SELECT *, getquarter(date) as fiscal_quarter from fact_sales_monthly
WHERE customer_code = 90002002 AND
get_fiscal_year(date)=2021;
#now, problem statement 1: month wise details for fy21
SELECT *, getquarter(date) as fiscal_quarter , get_month(date) as fiscal_month
from fact_sales_monthly
WHERE customer_code = 90002002 AND
get_fiscal_year(date)=2021;
#now to find product name and variant join with dim_product 
SELECT  s.*, getquarter(date) as fiscal_quarter , get_month(date) as fiscal_month,product,variant,gross_price
from fact_sales_monthly s
join dim_product p
ON s.product_code = p.product_code
join fact_gross_price gp
ON s.product_code=gp.product_code AND get_fiscal_year(s.date) = gp.fiscal_year #this is imp because gross price changes with year
WHERE customer_code = 90002002 AND
get_fiscal_year(date)=2021 ;
#find gross price total for all products
SELECT  s.*, getquarter(date) as fiscal_quarter , get_month(date) as fiscal_month,product,variant,gross_price, sold_quantity*gross_price as gross_price_total
from fact_sales_monthly s
join dim_product p
ON s.product_code = p.product_code
join fact_gross_price gp
ON s.product_code=gp.product_code AND get_fiscal_year(s.date) = gp.fiscal_year #this is imp because gross price changes with year
WHERE customer_code = 90002002 AND
get_fiscal_year(date)=2021 ;