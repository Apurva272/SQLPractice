#In customers table, there are two columns: first_name and last_name. Now you want to print those records where first_name + last_name is duplicate along with their count. Here duplicate means all outputs whose count is greater than 1. Which query can give you this result?
SELECT first_name, last_name, count(*) as cnt from customers GROUP BY first_name, last_name HAVING cnt>1;
#Following query is used to join pricing and discounts table where both pricing and discount amount is calculated using a combination of customer_code and product_code
SELECT * from pricing JOIN discounts USING (customer_code, product_code);
#You have two tables, pricing and discounts. Common link between these tables is product_code which can have null value in both the tables. A null product_code record in pricing table is considered a match with discounts table record with NULL product_code value. Which query can perform a correct inner join on all the records including NULL records?
SELECT * from pricing p JOIN discounts d ON IFNULL(p.product_code, 1) = IFNULL(d.product_code,1);
#product_code is a common link between pricing and discounts tables. Write a query that prints prouct_code along with its final price after discounts. Here are the names of the columns along with their purpose: discount_pct -> percentage discount (value is between 0 to 1), gross_price -> gross or original price of a product.
SELECT p.product_code, (1 - d.discount_pct)*p.gross_price as final_price from pricing p JOIN discounts d USING (product_code);
