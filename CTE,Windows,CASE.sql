CREATE DATABASE IF NOT EXISTS SalesDB;
USE SalesDB;


CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Region VARCHAR(50),
    OrderDate DATE,
    Sales DECIMAL(10,2),
    Profit DECIMAL(10,2)
);

INSERT INTO Orders (OrderID, CustomerID, Region, OrderDate, Sales, Profit) VALUES
(1, 101, 'North', '2025-01-05', 5000.00, 1200.00),
(2, 102, 'South', '2025-01-06', 3000.00, -200.00),
(3, 101, 'North', '2025-01-10', 7000.00, 1500.00),
(4, 103, 'East', '2025-01-15', 2000.00, 500.00),
(5, 102, 'South', '2025-01-20', 4000.00, -100.00),
(6, 104, 'West', '2025-01-25', 8000.00, 2000.00),
(7, 101, 'North', '2025-02-01', 6000.00, 1300.00),
(8, 103, 'East', '2025-02-05', 3500.00, 700.00);

SELECT 
    OrderID,CustomerID,Profit,
    CASE 
        WHEN Profit < 0 THEN 'Loss'
        ELSE 'Profit'
    END AS Profit_Flag
FROM Orders;

WITH sales_cte AS (
    SELECT 
        Region, 
        SUM(Sales) AS total_sales
    FROM Orders
    GROUP BY Region
)
SELECT * 
FROM sales_cte
WHERE total_sales > 10000;

SELECT 
    CustomerID,OrderDate,Sales,
    ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY Sales DESC) AS Row_Num,
    RANK() OVER (PARTITION BY CustomerID ORDER BY Sales DESC) AS Sales_Rank,
    LAG(Sales, 1) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS Prev_Sales
FROM Orders
ORDER BY CustomerID, OrderDate;
