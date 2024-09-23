CREATE DEFINER=`root`@`localhost` PROCEDURE `get_market_batch`(
IN in_market VARCHAR(45),
IN in_fiscal_year year,
OUT out_badge VARCHAR(45) )
BEGIN
DECLARE qty int default 0;
#set default market as india
if in_market = "" then set in_market="India"; end if;
#retrieve market and fiscal year
select sum(f.sold_quantity) into qty
from fact_sales_monthly f
join dim_customer c
on f.customer_code = c.customer_code
where get_fiscal_year(f.date) = in_fiscal_year and c.market = in_market
group by c.market;
#retrieve market band
if qty>5000000 then
set out_badge = "gold";
else 
set out_badge = "silver";
end if;
END