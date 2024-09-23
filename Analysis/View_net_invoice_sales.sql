SELECT *,
(gross_price_total - gross_price_total*pre_invoice_discount_pct) as net_invoice_sale
from sales_preinv_discount