CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `sales_preinv_discount` AS
    SELECT 
        `s`.`product_code` AS `product_code`,
        `pd`.`product` AS `product`,
        `pd`.`variant` AS `variant`,
        `c`.`customer` AS `customer`,
        `s`.`customer_code` AS `customer_code`,
        `s`.`sold_quantity` AS `sold_quantity`,
        `gp`.`gross_price` AS `gross_price`,
        ROUND((`s`.`sold_quantity` * `gp`.`gross_price`),
                2) AS `gross_price_total`,
        `s`.`fiscal_year` AS `fiscal_year`,
        `pre`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`
    FROM
        ((((`fact_sales_monthly` `s`
        JOIN `dim_product` `pd` ON ((`s`.`product_code` = `pd`.`product_code`)))
        JOIN `dim_customer` `c` ON ((`s`.`customer_code` = `c`.`customer_code`)))
        JOIN `fact_gross_price` `gp` ON (((`s`.`product_code` = `gp`.`product_code`)
            AND (`s`.`fiscal_year` = `gp`.`fiscal_year`))))
        JOIN `fact_pre_invoice_deductions` `pre` ON ((`s`.`customer_code` = `pre`.`customer_code`)))