-- Create initial table with data

CREATE TABLE IF NOT EXISTS users2 AS SELECT id, firstname, lastname, mail, phone, gender, birthday FROM users;

ALTER TABLE users2 
ADD COLUMN created_at VARCHAR(255) AFTER birthday;

ALTER TABLE users2 
ADD COLUMN updated_at VARCHAR(255) AFTER created_at;

UPDATE users2
SET
	created_at = '20.10.2017 8:10',
	updated_at = '01.11.2017 12:05';

-- Change data in the table

UPDATE users2  
SET created_at = STR_TO_DATE(created_at, "%d.%m.%Y %k:%i");

ALTER TABLE users2
MODIFY COLUMN created_at DATETIME;

UPDATE users2
SET updated_at = STR_TO_DATE(updated_at, "%d.%m.%Y %k:%i");

ALTER TABLE users2
MODIFY COLUMN updated_at DATETIME;

SELECT * FROM users2;