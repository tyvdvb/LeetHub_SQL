# Write your MySQL query statement below

WITH timeout_num AS (
    SELECT user_id, COUNT(*) AS num
    FROM Confirmations
    WHERE action = 'timeout'
    GROUP BY user_id
),
confirmed_num AS(
    SELECT user_id, COUNT(*) AS num
    FROM Confirmations
    WHERE action = 'confirmed'
    GROUP BY user_id
)
SELECT s.user_id,  
 CASE 
    WHEN COALESCE(c.num,0) + COALESCE(t.num,0) = 0 THEN 0
    ELSE ROUND(COALESCE(c.num,0) / (COALESCE(c.num,0) + COALESCE(t.num,0)), 2)
  END AS confirmation_rate
FROM Signups s
LEFT JOIN confirmed_num c ON c.user_id = s.user_id
LEFT JOIN timeout_num t ON t.user_id = s.user_id
ORDER BY s.user_id;
