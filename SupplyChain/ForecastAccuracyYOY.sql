#The supply chain business manager wants to see which customers’ forecast accuracy has dropped from 2020 to 2021. 
#Provide a complete report with these columns: customer_code, customer_name, market, forecast_accuracy_2020, forecast_accuracy_2021
with cte1 as (SELECT customer_code,sum(sold_quantity) as total_sold_quantity,sum(forecast_quantity) as total_forecast_quantity,sum(forecast_quantity-sold_quantity) as net_error, sum(abs(forecast_quantity-sold_quantity)) as abs_error,
sum((forecast_quantity-sold_quantity))*100/sum(forecast_quantity) as net_error_percent,
sum( (abs(forecast_quantity-sold_quantity)))*100/sum(forecast_quantity) as abs_error_percent
 FROM gdb0041.forecast_actual
 WHERE fiscal_year = 2021
 GROUP BY customer_code
 order by abs_error_percent desc),
 cte2 as (SELECT customer_code,sum(sold_quantity) as total_sold_quantity,sum(forecast_quantity) as total_forecast_quantity,sum(forecast_quantity-sold_quantity) as net_error, sum(abs(forecast_quantity-sold_quantity)) as abs_error,
sum((forecast_quantity-sold_quantity))*100/sum(forecast_quantity) as net_error_percent,
sum( (abs(forecast_quantity-sold_quantity)))*100/sum(forecast_quantity) as abs_error_percent
 FROM gdb0041.forecast_actual
 WHERE fiscal_year = 2020
 GROUP BY customer_code
 order by abs_error_percent desc)

 select  f. customer_code,c.customer,c.market, if (f.abs_error_percent>100, 0, 100-f.abs_error_percent) as forecast_accuracy_2021, 
 if (f2.abs_error_percent>100, 0, 100-f2.abs_error_percent) as forecast_accuracy_2020
 from cte1 f join dim_customer c
 on f.customer_code = c.customer_code
 join cte2 f2
 on f.customer_code = f2.customer_code
ORDER BY forecast_accuracy_2020 desc