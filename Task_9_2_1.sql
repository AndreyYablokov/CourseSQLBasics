USE shop;

DROP PROCEDURE IF EXISTS add_users;
DELIMITER //
CREATE PROCEDURE add_users(num_users BIGINT)
BEGIN
	DECLARE num BIGINT;
	
	SET num=1;
	WHILE num <=num_users DO
		INSERT INTO users(name) VALUES(CHAR(FLOOR(RAND()*(90-65+1)+65), FLOOR(RAND()*(90-65+1)+65), FLOOR(RAND()*(90-65+1)+65)));
		SET num = num + 1;
	END WHILE;
END //
DELIMITER ;

CALL add_users(1000000);

SELECT COUNT(*) FROM users;