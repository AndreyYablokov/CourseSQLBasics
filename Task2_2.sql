SELECT 
	DAYOFWEEK(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday), DAY(birthday)))) AS day_week,
	COUNT(*)
FROM users 
GROUP BY day_week
ORDER BY day_week;