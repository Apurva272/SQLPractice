#find forecast accuracy of each customer for FY 2021
SET @@sql_mode = REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', '');
with forecast_err_table as (SELECT customer_code,sum(sold_quantity) as total_sold_quantity,sum(forecast_quantity) as total_forecast_quantity,sum(forecast_quantity-sold_quantity) as net_error, sum(abs(forecast_quantity-sold_quantity)) as abs_error,
sum((forecast_quantity-sold_quantity))*100/sum(forecast_quantity) as net_error_percent,
sum( (abs(forecast_quantity-sold_quantity)))*100/sum(forecast_quantity) as abs_error_percent
 FROM gdb0041.forecast_actual
 WHERE fiscal_year = 2021
 GROUP BY customer_code
 order by abs_error_percent desc)
 select c.customer,c.market,f.*, if (abs_error_percent>100, 0, 100-abs_error_percent) as forecast_accuracy
 from forecast_err_table f join dim_customer c
 on f.customer_code = c.customer_code
 order by forecast_accuracy desc