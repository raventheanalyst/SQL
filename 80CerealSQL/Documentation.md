<!DOCTYPE html>
<html>
<head>
</head>
<body>
<h3>Objective</h3>
<p>Using SQL to gain insights and analyze a dataset of 80 different cereal types from 7 manufacturers, which contains data about the content nutrient groups (like fats or proteins) and elements (like potassium). </p>
<p></p>
</body>
</html>
<!DOCTYPE html>
<html>
<head>
<body>
<h3>Details </h3>
<p>Dataset - https://www.kaggle.com/datasets/crawford/80-cereals</p>
<p>Tools Used - Kaggle, MySQL</p>
<p></p>
<p></p>
</body>
</html>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<h3>Data Dictionary </h3>
<p>Fields in dataset:</p>
<p>•  Name: name of cereal</p>
<p>• mfr: manufacturer of cereal. (A = American Home Food Products, G = General Mills, K = Kellogg, N = Nabisco, P = Post, Q = Quaker Oats, R = Ralston Purina)</p>
<p>• Type = cold or hot</p>
<p>• Calories = calories per serving</p>
<p>• Protein = protein grams per serving</p>
<p>• Fat = grams per fat</p>
<p>• Sodium = milligrams of sodium</p>
<p>• Fiber = grams of dietary fiber</p>
<p>• Carbo = grams of complex carbohhydrates</p>
<p>• Sugars = grams of sugar</p>
<p>• Potass = milligrams of potassium</p>
<p>• Vitamins = vitmains and minerals - 0, 25, or 100, indicating the typical percentage of FDA recommended </p>
<p>•  Shelf = display shelf (1, 2, or 3, counting from the floor)</p>
<p>• Weight = weight in ounces of one serving</p>
<p>• Cups = number of cups in one serving</p>
<p>• Rating = a rating of the cereals (possibly from Consumer reports)</p>
<p> </p>
</body>
</html>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<h3>Summary of Findings </h3>
<p>•  Background on dataset:The dataset contains 77 unique cereals, with no duplicates entries and no missing values. The Cereal with the lowest calories per serving is All-Bran With Extra Fiber at 50 calories per serving. The Cereal with the highest calories per serving is Mueslix Crispy Blend at 160 calories per serving. Kellogg is the dominating manufacturer, having the most cereal in the dataset. </p>
<p>• Nabsisco has the highest overall average rating among all manufacturers</p>
<p>•  General Mills stands out with the most number of cereals with a low rating. </p>
<p>•  So let’s talk about Shelf Location. According to insights from Frank Brogie over at Repsly.com, consumer behavior research indicates that the middle shelf, at eye level, is considered the prime placement for products in stores. Shoppers tend to favor products on this shelf compared to those positioned higher or lower. Drawing from my this and my own analysis, I’ve determined the middle shelf location (2) to be the optimal shelf placement. Upon evaluating the data, it is evident that Kellogg and General Mills stand out with the highest representation of cereals in this ideal middle section. On the contrary, American Home Food Products and Post exhibit the lowest presence of cereals in this preferred shelf location. </p>
<p>•  Cheerios has the highest protein content among cereals, providing 6g per serving. Meanwhile, 100% Natural Bran takes the lead in fat content with 5g per serving. In terms of carbohydrate content, Rice Chex ranks highest with 23g per serving. </p>
<p>• Top 5 cereals based on high ratings are </p>
<p>1. All-Bran with Extra Fiber 93.7</p>
<p>2. Shredded Wheat ‘n’ Bran 74.4 </p>
<p>3. Shredded Wheat Spoon Size 72.8</p>
<p>4. 100% Bran 68.4 </p>
<p>5. Shredded Wheat 68.2</p>
<p>•  Top 5 Cereals with the lowest rating are</p>
<p>1. Cap ‘n’ Crunch 18.0 </p>
<p>2. Cinnamon Toast Crunch 19.8 </p>
<p>3. Honey Graham Ohs 21.8</p>
<p>4. Count Chocula 22.3</p>
<p>5.  Cocoa Puffs 22.7 </p>
<p>•  Nutrient Correlation - While a direct correlation is not evident, it appears that cereals with higher protein content per serving might be associated with higher grams of fat. </p>
<p>•  Among all the cereals in the dataset, Golden Crisps and Smacks have the highest sugar content per serving at 15g. 
<p></p>
<p></p>
</body>
</html>
<!DOCTYPE html>
<html>
<head>
<body>
<h3>Limitations </h3>
<p>- Dataset only had 77 different cereals and not 80</p>
<p>- Not sure where the data from the Ratings field came from</p>
<p>- Finding out which shelf location is the best was challenging. Different sources somewhat say different things. </p>
<p>- Ran into problems getting MIN and MAX calories. Using the ORDER BY MIN(calories) DESC, the results were still out of order. A quick fix would be MIN(calories) + 0 DESC but that would only be a temporary fix. The actual problem is that all columns in the table are set to TEXT and not their appropriate data type. We try to modify the datatype but run into an error. The first row seems to be a data type that has been written in. Although it helps us with which columns should have what data types, it’s unnecessary. We need to delete it. Since we are about to update or delete records, we need to make sure our Safe Updates are set to 0 so we can in fact delete that unnecessary row. To do this I used SQL_SAFE_UPDATES = 0; Now we can go ahead and delete that first row. After this we will be able to assign appropriate data types to each column with no error.</p>
<p></p>
</body>
</html>
<!DOCTYPE html>
<html>
<head>
<body>
<h3>Acknowledgements</h3>
<p>This dataset has been gathered and cleaned by Petra Isenberg, Pierre Dragicevic, and Yvonne Jansen. The OG source can be found here https://perso.telecom-paristech.fr/eagan/class/igr204/datasets.</p>
</body>
</html>


  
