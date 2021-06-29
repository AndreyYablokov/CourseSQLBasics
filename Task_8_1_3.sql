CREATE OR REPLACE VIEW august_day AS SELECT DISTINCT DAY(created_at) FROM messages WHERE MONTH(created_at)=8;

SET @num=0;

SELECT 
	@num := @num + 1 AS `number`,
	IF(@num IN (SELECT * FROM august_day),1,0) AS presence
FROM messages
WHERE @num < 31;