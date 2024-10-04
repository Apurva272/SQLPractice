# find which companies did max layoffs in a particular year
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_procedure`(
in_top_rank INT,
in_year YEAR)
BEGIN
WITH company_year (company,years,total_laid_off) as (
SELECT company,YEAR(`date`) as years, sum(total_laid_off) as total_laid_off
FROM layoff_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC), ranking as (
SELECT *, dense_rank() over(partition by years order by total_laid_off desc) as layoff_rank from company_year where years = in_year ORDER BY layoff_rank)
SELECT * from ranking where layoff_rank<=in_rank order by years;
END