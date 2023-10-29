--1.  Create a database 

-- CREATE DATABASE SalesDatabase;
-- Connect to the SalesDatabase

-- Create the sales_sample table
CREATE TABLE sales_sample (
    Product_Id INTEGER,
    Region VARCHAR(50),
    Date DATE,
    Sales_Amount NUMERIC
);

--2.  Insert 10 sample records into the "sales_sample" table
INSERT INTO sales_sample (Product_Id, Region, Date, Sales_Amount)
VALUES
    (1, 'East', '2023-01-05', 1000.50),
    (2, 'West', '2023-01-10', 750.25),
    (1, 'North', '2023-01-15', 1250.75),
    (3, 'South', '2023-01-20', 600.00),
    (2, 'East', '2023-02-05', 850.60),
    (3, 'West', '2023-02-10', 1100.25),
    (1, 'North', '2023-02-15', 950.40),
    (2, 'South', '2023-02-20', 1150.75),
    (3, 'East', '2023-03-05', 700.25),
    (1, 'West', '2023-03-10', 1020.90);

-- 3. Perform OLAP operations

-- a. Drill Down - Analyze sales data at a more detailed level (Region to Product).
-- This query will show sales performance for each product within each region.
SELECT Region, Product_Id, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY Region, Product_Id
ORDER BY Region, Product_Id;

-- b. Rollup - Summarize sales data at different levels of granularity (Product to Region).
-- This query will show the total sales for each region, aggregating at the region level.
SELECT Region, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY Region
ORDER BY Region;

-- c. Cube - Analyze sales data from multiple dimensions simultaneously.
-- This query explores sales data from different perspectives: product, region, and date.
SELECT Region, Product_Id, Date, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY CUBE (Region, Product_Id, Date)
ORDER BY Region, Product_Id, Date;

-- d. Slice - Extract a subset of data based on specific criteria (e.g., sales for a particular region or date range).
-- This query slices the data to view sales for the "East" region and a specific date range.
SELECT Region, Date, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
WHERE Region = 'East' AND Date BETWEEN '2023-01-01' AND '2023-03-31'
GROUP BY Region, Date
ORDER BY Date;

-- e. Dice - Extract data based on multiple criteria (specific combinations of product, region, and date).
-- This query views sales for specific combinations of product, region, and date.
SELECT Region, Product_Id, Date, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
WHERE (Region = 'East' OR Region = 'West') AND (Product_Id = 1 OR Product_Id = 2) AND Date = '2023-02-15'
GROUP BY Region, Product_Id, Date
ORDER BY Region, Product_Id, Date;
