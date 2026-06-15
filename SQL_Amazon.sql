SELECT SUM(Amount) as Income,AVG(Amount) as Average_Income, Month FROM `sql-analysis-498411.amazon_data.Amazon_SQL` 
Where Amount!= 0 and Qty>0
Group by Month
Order by Income DESC;

SELECT SUM(Amount) as Income,AVG(Amount) as Average_Income, Category FROM `sql-analysis-498411.amazon_data.Amazon_SQL` 
Where Amount!= 0 and Qty>0
Group by Category
Order by Income DESC; 
SELECT AVG(Amount) as Average_Profit , SUM(Amount) as Overall_Profit,  ASIN as Customer FROM sql-analysis-498411.amazon_data.Amazon_SQL 
Where Amount !=0 and Qty>1
Group by ASIN
Order by Average_Profit DESC
LIMIT 1000;

SELECT  ASIN as Product_ID, SUM(Amount) as Overall_Profit,  
ROUND(AVG(CASE WHEN B2B IS TRUE THEN Amount ELSE NULL END), 2) as B2B_Avg_Profit,
ROUND(AVG(CASE WHEN B2B IS FALSE THEN Amount ELSE NULL END), 2) as Regular_Avg_Profit
FROM `sql-analysis-498411.amazon_data.Amazon_SQL` 
WHERE Amount != 0 and Qty > 1
GROUP BY ASIN
HAVING B2B_Avg_Profit > 500 OR Regular_Avg_Profit > 500
ORDER BY B2B_Avg_Profit DESC NULLS LAST
LIMIT 11;

SELECT Fulfilment,COUNT(*) AS total_orders,
SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
ROUND(100.0 * SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*), 2) AS cancellation_rate_percentage
FROM sql-analysis-498411.amazon_data.Amazon_SQL
GROUP BY Fulfilment;

SELECT ship-state AS state, COUNT(*) AS total_orders,
SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
ROUND(100.0 * SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*), 2) AS cancellation_rate_pct,
SUM(Amount) AS successful_revenue
FROM sql-analysis-498411.amazon_data.Amazon_SQL 
WHERE `ship-state` IS NOT NULL
GROUP BY `ship-state`
HAVING total_orders > 100  
ORDER BY cancellation_rate_pct DESC;

SELECT CASE WHEN promotion-ids IS NULL OR promotion-ids = '' THEN 'No Promotion'ELSE 'Used Promotion' END AS promotion_status,
COUNT(*) AS total_orders,
ROUND(AVG(Qty), 2) AS average_items_per_order,
ROUND(AVG(Amount), 2) AS average_order_value
FROM sql-analysis-498411.amazon_data.Amazon_SQL
WHERE Status != 'Cancelled' AND Amount > 0 AND Qty > 0
GROUP BY 1;

SELECT Size,
COUNT(*) AS total_ordered,
SUM(Qty) AS total_items_sold,
SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) AS total_cancellations,
ROUND(100.0 * SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*), 2) AS cancellation_rate_pct,
ROUND(SUM(Amount), 2) AS total_revenue
FROM sql-analysis-498411.amazon_data.Amazon_SQL
WHERE Size IS NOT NULL
GROUP BY Size
ORDER BY total_ordered DESC;