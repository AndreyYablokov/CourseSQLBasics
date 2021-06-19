CREATE TABLE IF NOT EXISTS orders (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	order_num BIGINT NOT NULL,
	
	FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO orders VALUES 
(1, 1001, 1), 
(2, 1002, 2),
(3, 1003, 3),
(4, 1005, 4),
(5, 1006, 5),
(6, 1026, 6),
(7, 1044, 7),
(8, 1001, 8);

SELECT u.id, firstname, lastname
FROM
	users AS u
JOIN
	orders AS o
ON
	u.id = o.user_id;
	
