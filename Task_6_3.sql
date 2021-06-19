SELECT COUNT(*) as all_like_10_user FROM likes
WHERE user_id IN (
	SELECT id FROM (
		SELECT id, TIMESTAMPDIFF(YEAR, birthday, NOW()) as age FROM users
		ORDER BY age
		LIMIT 10
	) as my_tab)
;