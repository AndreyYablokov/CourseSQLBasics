SELECT firstname, 
		lastname, 
		hometown,
		(SELECT filename FROM media WHERE id = photo_id) AS photo
FROM users
WHERE id = 1001;

SELECT id,
		CASE(gender)
			WHEN 'm' THEN 'male'
			WHEN 'f' THEN 'female'
		END AS gender,
		CONCAT(
		PERIOD_DIFF(EXTRACT(YEAR_MONTH FROM NOW()), EXTRACT(YEAR_MONTH FROM birthday)) DIV 12, ' year(s) ', 
		MOD(PERIOD_DIFF(EXTRACT(YEAR_MONTH FROM NOW()), EXTRACT(YEAR_MONTH FROM birthday)),12), ' month(s)') as age 
FROM users
WHERE id IN (
	SELECT initiator_user_id FROM friend_requests WHERE target_user_id = 1001 AND status = 'approved'
	UNION
	SELECT target_user_id FROM friend_requests WHERE initiator_user_id = 1001 AND status = 'approved'
);