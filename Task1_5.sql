CREATE TABLE IF NOT EXISTS catalogs (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	value BIGINT
);

INSERT INTO catalogs
VALUES (1, 'name_1', 100), (2, 'name_2', 50), (3, 'name_3', 0), (4, 'name_4', 0), (5, 'name_5', 200);

SELECT * FROM catalogs WHERE id IN (5, 1, 2)
ORDER BY FIELD(id, 5, 1, 2);