USE shop;
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME,
	table_name VARCHAR(255),
	identificator BIGINT,
	name_field_content VARCHAR(255)
) ENGINE=Archive;

DELIMITER //
DROP TRIGGER IF EXISTS log_products_insert //
CREATE TRIGGER log_products_insert AFTER INSERT ON products
FOR EACH ROW BEGIN
	INSERT INTO shop.logs VALUES(NOW(),'products', NEW.id, NEW.name);
END//

DROP TRIGGER IF EXISTS log_catalogs_insert //
CREATE TRIGGER log_catalogs_insert AFTER INSERT ON catalogs
FOR EACH ROW BEGIN
	INSERT INTO shop.logs VALUES(NOW(),'catalogs', NEW.id, NEW.name);
END//

DROP TRIGGER IF EXISTS log_users_insert //
CREATE TRIGGER log_users_insert AFTER INSERT ON users
FOR EACH ROW BEGIN
	INSERT INTO shop.logs VALUES(NOW(),'users', NEW.id, NEW.name);
END//

DELIMITER ;

INSERT INTO products (id, name, catalog_id) VALUES(10, 'Apricot', 1);
INSERT INTO catalogs (id, name) VALUES(NULL, 'grocery');
INSERT INTO users VALUES(NULL, 'FedorFedotov');

SELECT * FROM logs;