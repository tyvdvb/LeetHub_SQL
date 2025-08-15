# Write your MySQL query statement below
WITH unique_users AS(
    SELECT contest_id, COUNT( DISTINCT user_id) as users
    FROM Register r
    GROUP BY contest_id
)
SELECT r.contest_id, ROUND((uu.users / (SELECT COUNT(user_id) FROM Users) ) * 100, 2) as percentage
FROM Register r
JOIN unique_users uu USING(contest_id)
GROUP BY r.contest_id
ORDER BY percentage DESC, contest_id ASC;