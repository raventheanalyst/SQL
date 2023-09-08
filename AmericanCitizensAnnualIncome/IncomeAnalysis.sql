USE kaggle; 
-- Cleaning the Data
SELECT * FROM income; 
-- *Change columns with '.' in their name to '_'
ALTER TABLE income
RENAME COLUMN `education.num` TO education_num; 
ALTER TABLE income
RENAME COLUMN `marital.status` TO marital_status;
ALTER TABLE income
RENAME COLUMN `capital.gain` TO capital_gain;
ALTER TABLE income
RENAME COLUMN `capital.loss` TO capital_loss;
ALTER TABLE income
RENAME COLUMN `hours.per.week` TO hours_per_week;
ALTER TABLE income
RENAME COLUMN `native.country` TO native_country;
-- Exploring the Data
-- *How many records to we have? 
SELECT COUNT(*) as num_of_rows FROM income; -- 25000
-- *Are there any duplicate records?
SELECT DISTINCT COUNT(*) FROM income; -- 25000. Same number as total records which indicates there are no duplicates
-- *Are there any null values? 
SELECT * FROM income
WHERE age IS NULL OR workclass IS NULL OR fnlwgt IS NULL OR education IS NULL OR education_num IS NULL OR occupation
 IS NULL OR relationship IS NULL OR race IS NULL OR  sex IS NULL OR capital_gain IS NULL OR capital_loss IS NULL OR 
 hours_per_week IS NULL OR native_country IS NULL OR income IS NULL; 
 -- *What is the average age for this dataset?
 SELECT ROUND(AVG(age),2) as average_age FROM income; 
 -- *How many people in dataset are male vs female?
 SELECT COUNT(sex) as male FROM income
 WHERE sex = 'Male'; 
 SELECT COUNT(sex) as female FROM income
 WHERE sex = 'Female'; 
 
-- Data Analysis Questions 
-- 1. What percentage of the dataset consists of people making over and under 50k?
SELECT 
	CONCAT(ROUND((COUNT(CASE WHEN income = '>50K' THEN 1 END) / COUNT(*)) * 100, 2), '%') AS '% Over 50k',
    CONCAT(ROUND((COUNT(CASE WHEN income = '<=50k' THEN 1 END) / COUNT(*)) * 100, 2), '%') AS '% Under 50k'
FROM income; 

-- 2. What is the distribution of income levels (above 50k and under 50k) by gender? 
SELECT 
	sex, 
    CONCAT(ROUND((COUNT(CASE WHEN income = '>50K' THEN 1 END) / COUNT(*)) * 100, 2), '%') AS '% Over 50k',
	CONCAT(ROUND((COUNT(CASE WHEN income = '<=50k' THEN 1 END) / COUNT(*)) * 100, 2), '%') AS '% Under 50k'
FROM income 
WHERE sex = 'Male' OR sex = 'Female'
GROUP BY sex;

-- 3. How deos income vary across differnet education levels?
SELECT * from income;
SELECT
	education,
	SUM(CASE WHEN income = '>50K' THEN 1 END) AS total_above_50k,
    SUM(CASE WHEN income = '<=50K' THEN 1 END) AS total_under_50k
FROM income
GROUP BY education
ORDER BY education;
-- 3a. Which education level has the most income earners earnign over 50k? 
SELECT education, COUNT(income) as over_50k
FROM income
WHERE income = '>50K'
GROUP BY education
ORDER BY over_50k DESC
LIMIT 1; 
-- 3b. Which education level has the most income earners earning under 50k? 
SELECT education, COUNT(income) as under_50k
FROM income 
WHERE income = '<=50K'
GROUP BY education
ORDER BY under_50k DESC
LIMIT 1; 

-- 4. Are there any significant differences between income and marital status?
SELECT marital_status, 
	SUM(CASE WHEN income = '>50K' THEN 1 END) AS total_above_50k,
    SUM(CASE WHEN income = '<=50K' THEN 1 END) AS total_under_50
FROM income
GROUP BY marital_status; 

-- 5. Is there a correlation between race and income levels?
SELECT 
	race, 
	SUM(CASE WHEN income = '>50K' THEN 1 END) AS total_above_50k,
    SUM(CASE WHEN income = '<=50K' THEN 1 END) AS total_under_50,
    ROUND((SUM( CASE WHEN income = '>50K' THEN 1 END)/SUM(CASE WHEN income = '<=50k' THEN 1 END)) * 100, 2
    ) AS percent_difference 
FROM income
GROUP BY race; 

-- 6. What is the average income for individuals with different native countries?
SELECT native_country,
COUNT(CASE WHEN income = '>50K' THEN 1 END) AS total_above_50k,
COUNT(CASE WHEN income = '<=50K' THEN 1 END) AS total_under_50
FROM income
WHERE native_country <> 'United-States'
GROUP BY native_country
ORDER BY total_under_50 DESC; 

-- 7. Are there any notable trends in income based on the occupations industry? 
SELECT
occupation,
COUNT(CASE WHEN income = '>50K' THEN 1 END) AS total_above_50k,
COUNT(CASE WHEN income = '<=50K' THEN 1 END) AS total_under_50
FROM income
GROUP BY occupation; 

-- 8. What % of individuals with a specific education level make above 50k, and what percentage makes under 50k? 
SELECT
education, 
CONCAT(ROUND((COUNT(CASE WHEN income = '>50K' THEN 1 END) / COUNT(*)) * 100, 2), '%') AS '% Over 50k',
CONCAT(ROUND((COUNT(CASE WHEN income = '<=50k' THEN 1 END) / COUNT(*)) * 100, 2), '%') AS '% Under 50k'
FROM income
GROUP BY education;





