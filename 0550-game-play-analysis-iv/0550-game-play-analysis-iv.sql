# Write your MySQL query statement below
WITH first_login AS(
    SELECT player_id, MIN(event_date) AS initial_date
    FROM Activity
    GROUP BY player_id
), next_day_logins AS(
    SELECT COUNT(DISTINCT f.player_id) AS num_logins
    FROM first_login f
    JOIN Activity a ON f.player_id = a.player_id AND f.initial_date = DATE_SUB(a.event_date, INTERVAL 1 DAY)
)
SELECT ROUND((SELECT num_logins FROM next_day_logins) / COUNT(*) ,2) AS fraction
FROM first_login;