CREATE TABLE IF NOT EXISTS catalogs (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255)
);

INSERT INTO catalogs VALUES 
(1, 'fruits'),
(2, 'sweets'),
(3, 'meet'); 

CREATE TABLE IF NOT EXISTS products (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	catalog_id BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (catalog_id) REFERENCES catalogs(id) 
);

INSERT INTO products VALUES
(1, 'apple', 1), (2, 'banana', 1), (3, 'orange', 1), (4, 'chocolate', 2),
(5, 'caramel', 2), (6, 'pork', 3), (7, 'beef', 3);

SELECT p.name, c.name
FROM
	products AS p
JOIN
	catalogs AS c 
ON
	p.catalog_id = c.id;