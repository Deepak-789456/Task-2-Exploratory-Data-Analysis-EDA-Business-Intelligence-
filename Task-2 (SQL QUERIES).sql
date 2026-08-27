--- check the table
SELECT * FROM sales
LIMIT 10;

--- check the column and data types

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'sales'
ORDER BY ordinal_position;

--- order_date(text) to change date formet

ALTER TABLE sales
ALTER COLUMN "Order_Date" TYPE DATE
USING "Order_Date"::DATE;


--- Q1. Last 6 months me Top 5 Products by Revenue.

SELECT
    "Product",
    SUM("Total_Sales") AS revenue
FROM sales
WHERE "Order_Date" >= (
    SELECT MAX("Order_Date") - INTERVAL '6 months'
    FROM sales
)
GROUP BY "Product"
ORDER BY revenue DESC
LIMIT 5;

--- Q2. Category-wise Total Revenue.
SELECT
    "Category",
    SUM("Total_Sales") AS total_revenue
FROM sales
GROUP BY "Category"
ORDER BY total_revenue DESC;

--- Q3. City-wise Revenue — Top 10 Cities

SELECT
    "City",
    SUM("Total_Sales") AS total_revenue
FROM sales
GROUP BY "City"
ORDER BY total_revenue DESC
LIMIT 10;

--- Q4. Monthly Revenue Trend.

SELECT
    "Year",
    "Month",
    SUM("Total_Sales") AS monthly_revenue
FROM sales
GROUP BY "Year", "Month"
ORDER BY
    "Year",
    CASE "Month"
        WHEN 'January' THEN 1
        WHEN 'February' THEN 2
        WHEN 'March' THEN 3
        WHEN 'April' THEN 4
        WHEN 'May' THEN 5
        WHEN 'June' THEN 6
        WHEN 'July' THEN 7
        WHEN 'August' THEN 8
        WHEN 'September' THEN 9
        WHEN 'October' THEN 10
        WHEN 'November' THEN 11
        WHEN 'December' THEN 12
    END;

--- Q5. Customer Gender-wise Revenue.

SELECT
    "Gender",
    COUNT(*) AS total_orders,
    SUM("Total_Sales") AS total_revenue
FROM sales
GROUP BY "Gender"
ORDER BY total_revenue DESC;

--- Q6. Average Order Value

SELECT 
    ROUND(
        (SUM("Total_Sales") / COUNT(DISTINCT "Order_ID"))::numeric,
        2
    ) AS average_order_value
FROM sales;

--- Q7. Product-wise Quantity Sold & Revenue.

SELECT
    "Product",
    SUM("Quantity") AS total_quantity_sold,
    SUM("Total_Sales") AS total_revenue
FROM sales
GROUP BY "Product"
ORDER BY total_revenue DESC;

