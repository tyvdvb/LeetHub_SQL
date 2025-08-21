# Write your MySQL query statement below
WITH first_sale AS(
    SELECT product_id, MIN(year) as first_year
    FROM Sales
    GROUP BY product_id
)
SELECT s.product_id, f.first_year, s.quantity, s.price
FROM Sales s
JOIN first_sale f ON f.product_id = s.product_id AND f.first_year = s.year;