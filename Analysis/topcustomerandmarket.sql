#referencing to the view created as sales_preinv_discount
 SELECT s.date,s.fiscal_year,s.customer_code,s.customer,s.product_code,s.product,s.variant,s.sold_quantity, s.sold_quantity,s.gross_price_total,( 1-pre_invoice_discount_pct)*gross_price_total as net_invoice_sales,(po.discounts_pct+po.other_deductions_pct) AS other_discounts
 FROM sales_preinv_discount s
 JOIN fact_post_invoice_deductions po
 On s.date = po.date AND s.product_code = po.product_code AND s.customer_code = po.customer_code;
 #refercing to post_invoice_disc
 SELECT * ,(1-other_discounts)*net_invoice_sales as net_sales
 from post_invoice_disc
limit 10000;
#the current table has all the details to give top products and marktes
 
 