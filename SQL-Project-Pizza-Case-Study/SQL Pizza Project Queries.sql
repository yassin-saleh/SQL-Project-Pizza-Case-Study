SELECT * FROM [PIZZA].[dbo].[order_details]
SELECT * FROM [dbo].[orders]
SELECT * FROM [dbo].[pizza_types]
SELECT * FROM [dbo].[pizzas];


/*
Basic:
Retrieve the total number of orders placed.
Calculate the total revenue generated from pizza sales.
Identify the highest-priced pizza.
Identify the most common pizza size ordered.
List the top 5 most ordered pizza types along with their quantities.


Intermediate:
Join the necessary tables to find the total quantity of each pizza category ordered.
Determine the distribution of orders by hour of the day.
Join relevant tables to find the category-wise distribution of pizzas.
Group the orders by date and calculate the average number of pizzas ordered per day.
Determine the top 3 most ordered pizza types based on revenue.

Advanced:
Calculate the percentage contribution of each pizza type to total revenue.
Analyze the cumulative revenue generated over time.
Determine the top 3 most ordered pizza types based on revenue for each pizza category.

*/


-- Retrieve the total number of orders placed.

SELECT COUNT(*) AS Total_Orders
FROM [dbo].[orders];

-- Calculate the total revenue generated from pizza sales.

SELECT ROUND(SUM(price * quantity),0) AS Total_Revnue
FROM [PIZZA].[dbo].[order_details] AS O
INNER JOIN [dbo].[pizzas] AS P
ON O.pizza_id = P.pizza_id;

--Identify the highest-priced pizza.
-- using TOP/Limit functions

SELECT TOP(1) name,
Cast(P.price as decimal(10,2)) as 'Price'
FROM [dbo].[pizza_types] AS PT
INNER JOIN [dbo].[pizzas] AS P
ON P.pizza_type_id = PT.pizza_type_id
ORDER BY price DESC


-- Identify the most common pizza size ordered.

SELECT size,
COUNT(DISTINCT OD.order_id) as 'No of Orders',
COUNT(*) AS Num_Of_Orders
FROM [PIZZA].[dbo].[order_details] AS OD
INNER JOIN [dbo].[orders] AS O
ON OD.order_id = O.order_id
INNER JOIN [dbo].[pizzas] AS P
ON OD.pizza_id = P.pizza_id
GROUP BY size  
ORDER BY Num_Of_Orders DESC;


-- List the top 5 most ordered pizza types along with their quantities.


SELECT TOP(5) name AS Pizza_Name,
SUM(quantity) AS Qty
FROM [PIZZA].[dbo].[order_details] AS OD
INNER JOIN [dbo].[pizzas] AS P
ON OD.pizza_id = P.pizza_id
INNER JOIN [dbo].[pizza_types] AS PT
ON P.pizza_type_id = PT.pizza_type_id
GROUP BY name
ORDER BY Qty DESC;


-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT category,
SUM(quantity) AS 'Total Quantity Ordered'
FROM [PIZZA].[dbo].[order_details] AS OD 
INNER JOIN [dbo].[pizzas] AS P
ON OD.pizza_id = P.pizza_id
INNER JOIN [dbo].[pizza_types] AS PT
ON P.pizza_type_id = PT.pizza_type_id
GROUP BY category
ORDER BY SUM(quantity) DESC;


-- Determine the distribution of orders by hour of the day.

SELECT DATEPART(HOUR, time ) AS Hour,
COUNT(*)
FROM [dbo].[orders] AS O
GROUP BY DATEPART(HOUR, time )
ORDER BY  COUNT(*)DESC;


-- find the category-wise distribution of pizzas


SELECT category, 
count(distinct pizza_type_id) as [No of pizzas]
FROM pizza_types
GROUP BY  category
ORDER BY  [No of pizzas]


-- Calculate the average number of pizzas ordered per day.


WITH CTE AS (
SELECT date,
SUM(quantity) AS QTY
FROM [dbo].[orders] AS O
INNER JOIN [PIZZA].[dbo].[order_details] AS OD
ON O.order_id = OD.order_id
GROUP BY date 
)
SELECT 
AVG(QTY) as [Avg Number of pizzas ordered per day]
FROM CTE



-- Determine the top 3 most ordered pizza types based on revenue.


SELECT TOP(3)
name,
ROUND(SUM(price * quantity),0) AS Total_Revnue
FROM [PIZZA].[dbo].[order_details] AS O
INNER JOIN [dbo].[pizzas] AS P
ON O.pizza_id = P.pizza_id
INNER JOIN [dbo].[pizza_types] AS PT
ON PT.pizza_type_id = P.pizza_type_id
GROUP BY name
ORDER BY Total_Revnue DESC;


-- Calculate the percentage contribution of each pizza type to total revenues


SELECT category,
ROUND(SUM(price * quantity),0) AS Total_Revnue,
ROUND(100 * SUM(price * quantity)/SUM( SUM(price * quantity))OVER(),2) AS PERC
FROM [PIZZA].[dbo].[order_details] AS OD
INNER JOIN [dbo].[pizzas] AS P
INNER JOIN [dbo].[pizza_types] AS PT
ON P.pizza_type_id = PT.pizza_type_id
ON OD.pizza_id = P.pizza_id
GROUP BY category;



-- Analyze the cumulative revenue generated over time.


WITH CTE AS (
SELECT date,
ROUND(SUM(price * quantity),0) AS Total_Revnue
FROM [PIZZA].[dbo].[order_details] AS OD
INNER JOIN [dbo].[pizzas] AS P
ON OD.pizza_id = P.pizza_id
INNER JOIN [dbo].[orders] AS O
ON OD.order_id = O.order_id
GROUP BY date
)
SELECT date,
Total_Revnue,
SUM(Total_Revnue) OVER(ORDER BY date ASC) AS Cumulative_Sum
FROM CTE


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.


WITH CTE AS (
SELECT
category,
name,
ROUND(SUM(price * quantity),0) AS Total_Revnue,
ROW_NUMBER()OVER(PARTITION BY category ORDER BY ROUND(SUM(price * quantity),2) DESC) AS RN 
FROM [PIZZA].[dbo].[order_details] AS OD
INNER JOIN [dbo].[pizzas] AS P
ON OD.pizza_id = P.pizza_id
INNER JOIN [dbo].[pizza_types] AS PT
ON P.pizza_type_id = PT.pizza_type_id
GROUP BY category,
name
)
SELECT category,
name,
Total_Revnue
FROM CTE 
WHERE RN <=3







