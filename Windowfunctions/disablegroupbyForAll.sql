SET @@sql_mode = REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', '');
SELECT category, sum(amount) as tot, (amount*100/sum(amount)) as percent_exp
FROM expenses
GROUP BY  category; 

