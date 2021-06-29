DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()
RETURNS VARCHAR(12) DETERMINISTIC
BEGIN
	DECLARE hour_now INT;
	
	SET hour_now = HOUR(CURRENT_TIME());
	
	CASE
		WHEN hour_now <= 6 THEN RETURN 'Доброй ночи';
		WHEN hour_now <= 12 THEN RETURN 'Доброе утро';
		WHEN hour_now <= 18 THEN RETURN 'Добрый день';
		ELSE RETURN 'Добрый вечер';
	END CASE;
END //
DELIMITER ;

SELECT hello();