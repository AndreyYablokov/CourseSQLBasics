CREATE TABLE table_test (
	id SERIAL PRIMARY KEY,
	value BIGINT
);

INSERT INTO table_test
VALUES (1,2), (2,3), (3,5), (4,5), (5,6);

UPDATE table_test
SET value = -2
WHERE id = 1;

-- Variant 1

/*SET @PRODUCT = 1;
SELECT @PRODUCT := @PRODUCT * value
FROM table_test;*/

-- Variant 2

SELECT
	IF(SUM(IF(value = 0, 0, NULL)) = 0,0,1) * 
	IF(SUM(IF(value <0, 1, 0))%2 = 0,1,-1) *
	EXP(SUM(LN(IF(value > 0, value, -value)))) AS PRODUCT
FROM table_test;