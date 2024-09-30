#report for top markets,products, customers by net sales for a given FY so that product owner can have a holistic view of the
#financial performance and can take any appropriate actions to address any potential issues
#-> top 3 markets based on net sales
#-> top 3 products on net sales
# -> top 3 customer on net sales
#gross price - pre invoice deduction = net invoice sales
# net invoice sales - post invoice deductions = net sales
WITH cte1 as (SELECT s.product_code,pd.product,pd.variant, c.customer, s.customer_code,s.sold_quantity,gp.gross_price, round(s.sold_quantity*gp.gross_price,2) as gross_price_total, s.fiscal_year,pre.pre_invoice_discount_pct
 from fact_sales_monthly s
 join dim_product pd
 on s.product_code = pd.product_code
 join dim_customer c
 on s.customer_code = c.customer_code
 join fact_gross_price gp
 on s.product_code = gp.product_code and s.fiscal_year = gp.fiscal_year
 join fact_pre_invoice_deductions pre
 on s.customer_code = pre.customer_code)
 SELECT * , (gross_price_total - gross_price_total*pre_invoice_discount_pct) as net_invoice_sales
 FROM cte1;
 
 