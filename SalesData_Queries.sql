-- ============================================================================
-- SQL Queries for SalesData Analysis
-- ============================================================================

-- Query 1: Find the total sales (sum of PurchaseAmount) for each city
-- This query groups all purchases by city and calculates the total revenue
SELECT 
    City,
    SUM(PurchaseAmount) AS TotalSales,
    COUNT(*) AS NumberOfPurchases,
    AVG(PurchaseAmount) AS AveragePurchaseAmount
FROM SalesData
GROUP BY City
ORDER BY TotalSales DESC;

-- ============================================================================

-- Query 2: Display the top 5 cities with the highest total revenue
-- This query finds the 5 cities with the most revenue
SELECT 
    City,
    SUM(PurchaseAmount) AS TotalRevenue,
    COUNT(*) AS NumberOfTransactions,
    ROUND(AVG(PurchaseAmount), 2) AS AvgTransactionValue
FROM SalesData
GROUP BY City
ORDER BY TotalRevenue DESC
LIMIT 5;

-- ============================================================================

-- Additional Useful Queries for SalesData Analysis
-- ============================================================================

-- Query 3: Revenue by city with percentage contribution to total
SELECT 
    City,
    SUM(PurchaseAmount) AS CityRevenue,
    ROUND((SUM(PurchaseAmount) / (SELECT SUM(PurchaseAmount) FROM SalesData)) * 100, 2) AS PercentageOfTotal
FROM SalesData
GROUP BY City
ORDER BY CityRevenue DESC;

-- ============================================================================

-- Query 4: City-wise sales with min and max purchase amounts
SELECT 
    City,
    SUM(PurchaseAmount) AS TotalSales,
    COUNT(*) AS PurchaseCount,
    MIN(PurchaseAmount) AS MinPurchase,
    MAX(PurchaseAmount) AS MaxPurchase,
    ROUND(AVG(PurchaseAmount), 2) AS AvgPurchase
FROM SalesData
GROUP BY City
ORDER BY TotalSales DESC;

-- ============================================================================

-- Query 5: Top 5 cities with revenue and performance metrics
SELECT 
    City,
    SUM(PurchaseAmount) AS TotalRevenue,
    COUNT(*) AS CustomerTransactions,
    ROUND(AVG(PurchaseAmount), 2) AS AvgRevenue,
    ROUND(STDDEV(PurchaseAmount), 2) AS RevenueStdDev
FROM SalesData
GROUP BY City
ORDER BY TotalRevenue DESC
LIMIT 5;

-- ============================================================================

-- Query 6: Cities ranked by total revenue with rank number
SELECT 
    RANK() OVER (ORDER BY SUM(PurchaseAmount) DESC) AS CityRank,
    City,
    SUM(PurchaseAmount) AS TotalRevenue,
    COUNT(*) AS Transactions
FROM SalesData
GROUP BY City
ORDER BY TotalRevenue DESC;

-- ============================================================================

-- Query 7: Monthly revenue trend by city (Top 5 cities)
SELECT 
    City,
    YEAR(PurchaseDate) AS Year,
    MONTH(PurchaseDate) AS Month,
    SUM(PurchaseAmount) AS MonthlyRevenue
FROM SalesData
WHERE City IN (
    SELECT City
    FROM SalesData
    GROUP BY City
    ORDER BY SUM(PurchaseAmount) DESC
    LIMIT 5
)
GROUP BY City, YEAR(PurchaseDate), MONTH(PurchaseDate)
ORDER BY City, Year, Month;
