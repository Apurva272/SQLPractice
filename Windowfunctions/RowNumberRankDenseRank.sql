#from expenses table show top 2 expenses in each category
WITH cte1 as (SELECT *, row_number() over (partition by category order by amount desc) as rn,rank() over(partition by category order by amount desc)as rnk,
dense_rank() over(partition by category order by amount desc) as drnk
FROM expenses
ORDER BY category)
select * from cte1 ;
#from student marks, rank the students
SELECT *, row_number() over (order by marks desc) as rn,rank() over( order by marks desc)as rnk,
dense_rank() over(order by marks desc) as drnk
FROM student_marks
ORDER BY drnk