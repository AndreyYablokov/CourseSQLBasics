CREATE VIEW prod_cat AS
	SELECT p.name AS product_name, c.name AS catalog_name
	FROM
		products AS p
	JOIN
		catalogs AS c 
	ON
		p.catalog_id = c.id;

SELECT * FROM prod_cat;