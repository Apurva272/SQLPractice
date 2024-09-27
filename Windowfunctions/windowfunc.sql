SELECT *, amount*100/SUM(amount) over() as percent_exp
FROM expenses;
select sum(amount) from expenses ;#65,800
#lets find percent expenditure with respect to category's total.
SELECT *, amount*100/SUM(amount) over(partition by category) as percent_exp
FROM expenses
ORDER BY category;
#find out percent expenditure by each category
SELECT category, amount*100/SUM(amount) over() as percent_exp
FROM expenses
GROUP BY category;
#find cumulative expenditure by each category date-wise
SELECT*, SUM(amount) over(partition by category order by date) as total_expense_till_date
FROM expenses;