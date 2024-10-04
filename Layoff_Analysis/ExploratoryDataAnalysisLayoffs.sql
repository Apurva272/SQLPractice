#exploratory data analysis
select * from layoff_staging2;
SELECT MAX(Total_laid_off)
from layoff_staging2;
#max percent laid off
SELECT MAX(percentage_laid_off)
from layoff_staging2;
#the max laid off is 1, which means 100% of the workforce was laif off, finding the companies
SELECT company,percentage_laid_off, total_laid_off
from layoff_staging2
where percentage_laid_off = 1;
#grouping by company
SELECT company, sum(total_laid_off)
FROM layoff_staging2
GROUP BY company
ORDER BY 2 DESC;

#date range
select min(`date`), max(`date`)
FROM layoff_staging2;
#industry wise analysis
SELECT industry, sum(total_laid_off),round(sum(percentage_laid_off),2)
FROM layoff_staging2
GROUP BY industry
ORDER BY 2 DESC;
#country wise analysis
SELECT country, sum(total_laid_off)
FROM layoff_staging2
GROUP BY country
ORDER BY 2 DESC;
#year wise analysis
SELECT YEAR(`date`), sum(total_laid_off)
FROM layoff_staging2
GROUP BY YEAR(`DATE`)
ORDER BY 2 DESC; #2022 is highest, but dataset not complete for 2023
#STAGE of the company laying off
SELECT stage, sum(total_laid_off)
FROM layoff_staging2
GROUP BY stage
ORDER BY 2 DESC; #post ipo is highest

#Rolling total of layoffs
SELECT SUBSTRING(`date`,1,7) as `month`, sum(total_laid_off)
FROM layoff_staging2
WHERE  SUBSTRING(`date`,1,7) IS NOT NULL
GROUP by `month`
ORDER BY 1 asc;
#for rolling total, use cte
WITH rolling_total as (
SELECT SUBSTRING(`date`,1,7) as `month`, sum(total_laid_off) as total_off
FROM layoff_staging2
WHERE  SUBSTRING(`date`,1,7) IS NOT NULL
GROUP by `month`
ORDER BY 1 asc
)
SELECT `month`,total_off,SUM(total_off) over(ORDER BY `month`) as rolling_total
FROM rolling_total;
#rolling total of each company: how much they are laying off per year
SELECT company,YEAR(`date`), sum(total_laid_off)
FROM layoff_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;
#biggest layoffs year wise
WITH company_year (company,years,total_laid_off) as (
SELECT company,YEAR(`date`) as years, sum(total_laid_off) as total_laid_off
FROM layoff_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC)
SELECT *, dense_rank() over(partition by years order by total_laid_off desc) as layoff_rank from company_year where years IS NOT NULL ORDER BY layoff_rank;
#for more modification, adding another cte
WITH company_year (company,years,total_laid_off) as (
SELECT company,YEAR(`date`) as years, sum(total_laid_off) as total_laid_off
FROM layoff_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC), ranking as (
SELECT *, dense_rank() over(partition by years order by total_laid_off desc) as layoff_rank from company_year where years IS NOT NULL ORDER BY layoff_rank)
SELECT * from ranking where layoff_rank<=5 order by years;