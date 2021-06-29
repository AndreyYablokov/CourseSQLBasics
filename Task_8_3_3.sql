DROP FUNCTION IF EXISTS FIBONACCI;
DELIMITER //
CREATE FUNCTION FIBONACCI(num_count INT)
RETURNS BIGINT DETERMINISTIC
BEGIN
	DECLARE num1, num2, res BIGINT;
	DECLARE idx INT;
	
	SET num1 = 0;
	SET num2 = 1;
	SET idx = 2;
	
	IF num_count = 1 THEN RETURN num1;
	ELSEIF num_count = 2 THEN RETURN num2;
	ELSE
		WHILE idx <= num_count DO
			SET res = num1 + num2;
			SET num1 = num2;
			SET num2 = res;
			SET idx = idx + 1;
		END WHILE;
		RETURN res;
	END IF;
END //
DELIMITER ;

SELECT FIBONACCI(10);