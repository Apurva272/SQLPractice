
#data cleaning
-- 1.remove duplicates if any
-- 2.standardize the date
-- 3.null values/blank values
-- 4. remove columns
#STEP 1: CREATE A layoffs_staging table as staging table. It will be a duplicate of layoffs table
#CREATE TABLE layoffs_staging LIKE layoffs;
#SELECT * from layoff_staging;
#INSERT layoff_staging
#SELECT *
#FROM layoffs;

SELECT * FROM world_layoffs.layoff_staging;
WITH duplicate_cte AS (SELECT *, row_number() over( partition by company, location,industry,total_laid_off, percentage_laid_off, date,stage,country,funds_raised_millions)
 AS row_num
FROM layoff_staging)
SELECT *
FROM duplicate_cte
WHERE row_num>1;
#remove duplicates by delete
WITH duplicate_cte AS (SELECT *, row_number() over( partition by company, location,industry,total_laid_off, percentage_laid_off, date,stage,country,funds_raised_millions)
 AS row_num
FROM layoff_staging)
DELETE 
FROM duplicate_cte
WHERE row_num>1;

#deleting from cte is not possible : no update queries work on cte, so creating another staging table

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
#insert values
INSERT INTO layoff_staging2
SELECT *, row_number() over( partition by company, location,industry,total_laid_off, percentage_laid_off, date,stage,country,funds_raised_millions)
 AS row_num
FROM layoff_staging;
SELECT * from layoff_staging2
WHERE row_num>1;
DELETE from layoff_staging2
WHERE row_num>1;
SELECT * from layoff_staging2;
 -- 2. Standardizing data: finding issues in dataset and cleaning it
 #1. from company name, remove extra spaces
 SELECT DISTINCT company FROM layoff_staging2;
 SELECT company, trim(company) FROM layoff_staging2;
 UPDATE layoff_staging2 SET company = TRIM(company);
 SELECT distinct industry FROM layoff_staging2 ORDER BY 1; #order by in alphabetic order increasing
 #what are the issues with industry
#null values and blank values
#Crypto, CryptoCurrency and Crypto currency are the same
SELECT * FROM layoff_staging2
WHERE industry like "%crypto%";
UPDATE layoff_staging2
SET industry = 'Crypto'
WHERE industry LIKE '%crypto%';

SELECT distinct country
FROM layoff_staging2
ORDER BY 1;
#no issue in location
#in country, two entries for United States: United States and United States.
UPDATE layoff_staging2
SET industry = 'United States'
WHERE industry LIKE '%United States%';
SELECT distinct country, trim(trailing '.' FROM country)
FROM layoff_staging2
ORDER BY 1;

UPDATE layoff_staging2
SET country = trim(trailing '.' FROM country)
WHERE country like '%United States%';
#change date column from text type to date type
SELECT `date`, 
str_to_date(`date`,'%m/%d/%Y')
FROM layoff_staging2;
UPDATE layoff_staging2
SET `date` = str_to_date(`date`,'%m/%d/%Y');
#change data type of dates 
ALTER TABLE layoff_staging2
MODIFY COLUMN `date` DATE;
-- Removing null values
SELECT * from layoff_staging2 WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;
#total_laid_off and percent_laid_off column contains null values 
#industry columns also has nulls and blanks
SELECT * from layoff_staging2 WHERE industry IS NULL OR industry = '';
#airbnb, bally's interactive ,  Caravana, Juul, so will find industry mapping from other records
SELECT * from layoff_staging2 WHERE Company like '%Airbnb%'; #airbnb has another row where industry = travel
#do an inner join to populate industry for records where company name is same
UPDATE layoff_staging2
SET industry = NULL
where industry = '';
SELECT t1.industry,t2.industry
FROM layoff_staging2 t1
JOIN layoff_staging2 t2
ON t1.company = t2.company 
AND t1.location = t2.location
WHERE (t1.industry is NULL)
and t2.industry IS NOT NULL;
#update
UPDATE layoff_staging2 t1
JOIN layoff_staging2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry is NULL)
and t2.industry IS NOT NULL;
#balley is the only one now which industry is blank
SELECT * from layoff_staging2 WHERE Company like '%Bally%';
#lookinng at companies where total_laid_off = percentage_laid_off = NULL
SELECT * from layoff_staging2 WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL; 
#No information of layoffs from this, therefre deleting
DELETE FROM layoff_staging2 WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL; 
SELECT * FROM layoff_staging2;
#remove row_num column, no longer valid
ALTER TABLE layoff_staging2
DROP Column row_num;
SELECT * from layoff_staging2;