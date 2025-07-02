SELECT * 
FROM pizza;

#1. WHAT IS THE TOTAL REVENUE?
SELECT SUM(total_price) AS Total_Revenue
FROM pizza;

#2. AVERAGE ORDER VALUE 
SELECT SUM(total_price) / COUNT(DISTINCT order_id) Avg_Order_Value
FROM pizza;

#3. TOTAL PIZZAS SOLD
SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza;

#4. TOTAL ORDERS PLACED
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza;

#5. AVERAGE PIZZAS PER ORDER
SELECT CAST(SUM(quantity) / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS Avg_Pizzas_Order
FROM pizza;

## CHANGING DATA TYPE
ALTER TABLE pizza
ADD COLUMN order_date_temp DATE;

UPDATE pizza
SET order_date_temp = STR_TO_DATE(order_date, "%c/%e/%Y");

SELECT order_date, order_date_temp
FROM pizza 
LIMIT 10;

ALTER TABLE pizza
DROP COLUMN order_date;

ALTER TABLE pizza
CHANGE order_date_temp order_date DATE;

#6. DAILY TREND FOR TOTAL ORDERS
SELECT DAYNAME(order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza
GROUP BY DAYNAME(order_date);

#7. MONTHLY TREND FOR TOTAL ORDERS
SELECT MONTHNAME(order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza
GROUP BY MONTHNAME(order_date)
ORDER BY Total_Orders DESC;

#8. PERCENTAGE OF SALES BY PIZZA CATEGORY
SELECT pizza_category, CAST(SUM(total_price) * 100 / 
	(SELECT SUM(total_price) 
    FROM pizza 
    WHERE MONTH(order_date) = 7) AS DECIMAL(10,2)) AS Perc_Total_Sales
FROM pizza
WHERE MONTH(order_date) = 7
GROUP BY pizza_category;

#9. PERCENTAGE OF SALES BY PIZZA SIZE
SELECT pizza_size, CAST(SUM(total_price) * 100 /
	(SELECT SUM(total_price)
    FROM pizza
    WHERE QUARTER(order_date) = 1) AS DECIMAL(10,2)) AS Perc_Total_Sales
FROM pizza
WHERE QUARTER(order_date) = 1
GROUP BY pizza_size
ORDER BY Perc_Total_Sales DESC;

#10. TOP AND BOTTOM 5 BEST SELLERS BY REVENUE, TOTAL QUANTITY AND TOTAL ORDERS
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;

SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5;

SELECT pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza
GROUP BY pizza_name
ORDER BY Total_Quantity DESC
LIMIT 5;

SELECT pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza
GROUP BY pizza_name
ORDER BY Total_Quantity ASC
LIMIT 5;

SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;

SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;
