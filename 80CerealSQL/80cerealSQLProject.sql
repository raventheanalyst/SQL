USE kaggle; 
SELECT * FROM kaggle.cereal;
-- SQL Safe Mode because we are about to update and delete part of our table. 
SET SQL_SAFE_UPDATES = 0;
-- Delete first column in our table because it is unnecesary and will affect calculations later on
DELETE FROM cereal WHERE name = 'String';
-- Check to see if first column was deleted
SELECT * FROM kaggle.cereal;
-- All datatypes in table show as TEXT. MOdify columns with appropriate datatypes
ALTER TABLE cereal 
MODIFY name VARCHAR(100),
MODIFY mfr VARCHAR(10),
MODIFY type VARCHAR(10), 
MODIFY calories INT,
MODIFY protein INT,
MODIFY fat INT,
MODIFY sodium INT,
MODIFY fiber FLOAT,
MODIFY carbo FLOAT, 
MODIFY sugars INT,
MODIFY potass INT,
MODIFY vitamins INT,
MODIFY shelf INT,
MODIFY weight FLOAT,
MODIFY cups FLOAT,
MODIFY rating FLOAT; 
-- Check table
DESCRIBE cereal; 
SELECT * FROM kaggle.cereal;

-- Exploratory Data Analysis --
-- How many cereals do we have? 
SELECT COUNT(*) count
FROM kaggle.cereal;
-- Check for duplicates
SELECT name, COUNT(*)
FROM kaggle.cereal
GROUP BY name
HAVING COUNT(*) > 1; 
-- Check for Null Values 
SELECT *
FROM kaggle.cereal
WHERE NULL IN (name, mfr, type, calories, protein, fat, 
sodium, fiber, carbo, sugars, potass, vitamins, shelf,
 weight, cups, rating); 
 -- Cereal with the lowest calories 
 SELECT name, MIN(calories) as min_calories
 FROM kaggle.cereal
 GROUP BY name
 ORDER BY min_calories ASC
 LIMIT 1; 
 -- Cereal with the highest calories 
 SELECT name, MAX(calories) as max_calories
 FROM kaggle.cereal
 GROUP BY name
 ORDER BY max_calories DESC
 LIMIT 1; 
 -- Manufacturer with most cereal in the dataset
 SELECT mfr, COUNT(name) as count_cereal
 FROM kaggle.cereal
 GROUP BY mfr 
 ORDER BY count_cereal; 
 
 -- Analysis 
 -- 1. What is the average count of each nutrient and element per manufacturer? 
 SELECT mfr, ROUND(AVG(calories),2) as avg_calories, ROUND(AVG(protein),2) as avg_protein, ROUND(AVG(fat),2) as avg_fat, 
 ROUND(AVG(sodium),2) as avg_sodium, ROUND(AVG(fiber),2) as avg_fiber, ROUND(AVG(carbo),2) as avg_carbo, 
 ROUND(AVG(sugars),2) as avg_sugars, ROUND(AVG(potass),2) as avg_potass, ROUND(AVG(vitamins),2) as avg_vitamins
 FROM kaggle.cereal
 GROUP BY mfr; 
 
 -- 2. What is the number of calories per ounce for each product? 
 SELECT name, ROUND(calories / weight, 2) as calories_per_ounce
 FROM kaggle.cereal;
 
 -- 3. What is the average rating per manufacturer? Is it somehow connected to average nutrient content?
SELECT mfr, ROUND(AVG(rating), 2)
FROM kaggle.cereal
GROUP BY mfr
ORDER BY AVG(rating); 

-- or for a more indepth view 
SELECT mfr, rating, 'Calories' as metric, ROUND(AVG(Calories), 2) as avg_value
FROM cereal 
GROUP BY mfr, rating
UNION
SELECT mfr, rating, 'Protein' as metric, ROUND(AVG(Protein), 2) 
FROM cereal 
GROUP BY mfr, rating
UNION
SELECT mfr, rating,  'Fat' as metric, ROUND(AVG(Fat), 2) 
FROM cereal 
GROUP BY mfr, rating
UNION 
SELECT mfr, rating,  'Sodium' as metric, ROUND(AVG(Sodium), 2) 
FROM cereal 
GROUP BY mfr, rating
UNION
SELECT mfr, rating,  'Fiber' as metric, ROUND(AVG(Fiber), 2) 
FROM cereal 
GROUP BY mfr, rating
UNION
SELECT mfr, rating,  'Carbo' as metric, ROUND(AVG(Carbo), 2) 
FROM cereal 
GROUP BY mfr, rating
UNION 
SELECT mfr, rating,  'Sugars' as metric, ROUND(AVG(Sugars), 2) 
FROM cereal 
GROUP BY mfr, rating
UNION 
SELECT mfr, rating,  'Potass' as metric, ROUND(AVG(Potass), 2) 
FROM cereal 
GROUP BY mfr, rating
UNION 
SELECT mfr, rating, 'Vitamins' as metric, ROUND(AVG(Vitamins), 2) 
FROM cereal 
GROUP BY mfr, rating; 

-- 4. Which manufacturer possess the best shelf location? (1, 2, 3 counting from floor)
SELECT mfr, COUNT(shelf) as shelf_count
FROM cereal
GROUP BY mfr
ORDER BY shelf_count DESC
LIMIT 1; 

SELECT mfr,
	SUM(CASE WHEN Shelf = 1 THEN 1 ELSE 0 END) as shelf_1_count,
    SUM(CASE WHEN Shelf = 2 THEN 1 ELSE 0 END) as shelf_2_count, 
    SUM(CASE WHEN Shelf = 3 THEN 1 ELSE 0 END) as shelf_3_count
    FROM cereal 
GROUP BY mfr
ORDER BY shelf_1_count DESC, shelf_2_count DESC, shelf_3_count DESC
LIMIT 1; -- highest of all of them. 
-- if we consider 2 the best location who has the most 2's 
SELECT mfr,
    SUM(CASE WHEN Shelf = 2 THEN 1 ELSE 0 END) as shelf_2_count 
    FROM cereal 
GROUP BY mfr
ORDER BY shelf_2_count DESC
LIMIT 1; -- highest of all of them. 

-- 5. What is the nutritional value for each cereal according to protein, fat, and carbohydrate data? 
SELECT name, protein, fat, carbo
FROM cereal
ORDER by name; 

-- 6. What are the top 5 cereal based on Ratings; What are the bottom 5 cereals based on Ratings?
SELECT name, MAX(rating) as top_rated_cereal
FROM cereal 
GROUP BY name
ORDER BY top_rated_cereal DESC
LIMIT 5;

SELECT name, MIN(rating) as min_rated_cereal
FROM cereal 
GROUP BY name
ORDER BY min_rated_cereal
LIMIT 5;

-- 7a. Nutrient Correlation - Do cereals with high fiber have low fat content?
SELECT name, fiber, fat
FROM cereal 
ORDER BY fiber DESC;

-- 7b. Nutrient Correlation - Do cereals with low fat have a higher rating?
SELECT name, fat, rating
FROM cereal 
ORDER BY rating DESC;

-- 8. Nutritional ranges - Find cereals that fall within 200 and 300mg of Potassium. 
SELECT name, potass
FROM cereal 
WHERE potass BETWEEN 200 and 300
ORDER BY potass; 

-- 8a. Nutritional ranges - Find Cereal that fall within 10-20g of sugar?
SELECT name, sugars
FROM cereal 
WHERE sugars BETWEEN 10 and 20 
ORDER BY sugars; 

-- 9. What are the cereals with high potassium and protein
SELECT name, potass, protein
FROM cereal 
ORDER BY potass DESC, protein DESC; 

-- 10. Nutritional Comparrison with daily recommended value
SELECT name, 
	ROUND((protein / 45),2) * 100 as protein_percent,
    ROUND((fat / 67), 2) * 100 as fat_percent,
    ROUND((sodium / 2.3), 2) * 100 as sodium_percent, 
    ROUND((fiber / 25), 2) * 100 as fiber_percent,
    ROUND((carbo / 225), 2) * 100 as carbo_percent,
    ROUND((sugars / 24), 2)* 100 as sugars_percent,
    ROUND((potass / 2.5), 2) * 100 as potass_percent
FROM cereal;

    