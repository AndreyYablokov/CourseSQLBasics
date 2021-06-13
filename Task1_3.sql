CREATE TABLE IF NOT EXISTS storehouses_products (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	value BIGINT
);

INSERT INTO storehouses_products
VALUES (1, 'product_1', 100), (2, 'product_2', 50), (3, 'product_3', 0), (4, 'product_4', 0), (5, 'product_5', 200);

SELECT * FROM storehouses_products
ORDER BY IF(`value` > 0, 0, 1), `value`;