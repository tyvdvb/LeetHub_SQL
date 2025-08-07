# Write your MySQL query statement below
WITH end_time AS (
    SELECT machine_id, process_id, timestamp 
    FROM Activity
    WHERE activity_type = 'end'
),
start_time AS (
    SELECT machine_id, process_id, timestamp 
    FROM Activity
    WHERE activity_type = 'start'
)
SELECT machine_id, ROUND(AVG(end_time.timestamp - start_time.timestamp), 3) AS processing_time
FROM Activity
JOIN end_time USING (machine_id)
JOIN start_time USING (machine_id)
GROUP BY machine_id;
