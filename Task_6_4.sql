SELECT gender, COUNT(gender) AS count_likes FROM users
WHERE (id IN (SELECT user_id FROM likes))
GROUP BY gender
ORDER BY count_likes DESC;