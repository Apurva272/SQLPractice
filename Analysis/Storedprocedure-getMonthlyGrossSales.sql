CREATE DEFINER=`root`@`localhost` PROCEDURE `get_monthly_gross_sales_for_customer`(
c_name varchar(90))
BEGIN
SELECT  d.customer, get_fiscal_year(s.date) as fiscal_year, SUM(s.sold_quantity*gp.gross_price) as gross_price_total
from fact_sales_monthly s
join fact_gross_price gp
ON s.product_code=gp.product_code and year(s.date) = gp.fiscal_year
join dim_customer d
ON s.customer_code = d.customer_code
WHERE d.customer LIKE CONCAT('%', c_name, '%')
GROUP BY get_fiscal_year(s.date);
END