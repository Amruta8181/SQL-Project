SELECT * FROM mytable;

#1.	List all products with a discounted price below ₹500.

Select product_id, discounted_price
From mytable
Where discounted_price <=500;

#2.	Find products with a discount percentage of 50% or more.
Select product_id, product_name,discount_percentage
From mytable
Where discount_percentage >= 0.50;
 
#3. Retrieve all products where the name contains the word "Cable."
Select product_name,product_id
From mytable
Where product_name LIKE '%Cable%';

#4 Display the difference between the average of the actual price and the discounted price for each product
Select product_id,
avg(actual_price) as avg_actual_price,
avg(discounted_price) as avg_discounted_price,
avg(actual_price) - avg(discounted_price) As price_difference
From mytable
group by product_id,product_name;

#5.	Query reviews that mention "fast charging" in their content.
Select product_name,product_id,review_content
From mytable
where review_content like '%fast charging%';

#6.	Identify products with a discount percentage between 20% and 40%.
Select product_name,product_id,discount_percentage
From mytable
where discount_percentage between 0.20 and 0.40;

#7.	Find products that have an actual price above ₹1,000 and are rated 4 stars or above.
Select product_name,product_id,actual_price,rating
From mytable
where actual_price >= '1000' and rating >= '4';

#8.	Find products where the discounted price ends with a 9
Select product_name,product_id,discounted_price
From mytable
where discounted_price like '%9';

#9.	Display review contents that contains words like worst, waste, poor, or not_good.
Select product_name,product_id,review_content
From mytable
Where review_content like '%worst%' 
or review_content like'%poor%' 
or review_content like '%not worth%'
or review_content like '%waste%'
or review_content like '%not good%';

#10.	List all products where the category includes "Accessories".
Select product_id,product_name,category
From mytable
where category like '%Accessories%';





 






