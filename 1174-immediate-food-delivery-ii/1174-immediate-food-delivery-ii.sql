# Write your MySQL query statement below
WITH first_order AS(
    SELECT customer_id , MIN(order_date) as first_order_date
    FROM Delivery
    GROUP BY customer_id
)
SELECT ROUND(SUM(case when fo.first_order_date = d.customer_pref_delivery_date then 1 else 0 end)/ COUNT(*) * 100, 2) AS immediate_percentage
FROM Delivery d
JOIN first_order fo ON d.customer_id = fo.customer_id AND fo.first_order_date = d.order_date;