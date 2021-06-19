CREATE TABLE IF NOT EXISTS flights (
	id SERIAL PRIMARY KEY,
	`from` VARCHAR(255),
	`to` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS cities (
	label VARCHAR(255) PRIMARY KEY,
	name VARCHAR(255)
);

INSERT INTO flights VALUES 
(1, 'moskow', 'omsk'),
(2, 'novgorod', 'kazan'),
(3, 'irkutsk', 'moskow'),
(4, 'omsk', 'irkutsk'),
(5, 'moskow', 'kazan');


INSERT INTO cities VALUES 
('moskow', 'Москва'),
('novgorod', 'Нижний Новгород'),
('irkutsk', 'Иркутск'),
('omsk', 'Омск'),
('kazan', 'Казань'); 

SELECT id,
	(SELECT name FROM cities WHERE `from` = label) AS `from`,
	(SELECT name FROM cities WHERE `to` = label) AS `to`
FROM flights;
	