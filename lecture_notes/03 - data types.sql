create table Products
(
	id int primary key identity (100, 5), -- startvärde och steg för automatisk uppräkning av id
	name nvarchar(50)
);

INSERT INTO Products (Name) values('Product');
SELECT * FROM Products;

-- DELETE FROM Products WHERE id > 120 --deletar rader men nollställer inte id räknaren
-- TRUNCATE table Products --tar bort alla rader och ställer om id räknaren

SELECT CAST('45', int); -- byta datatyp nvarchar -> int enligt ISO-SQL
SELECT CONVERT(int, '45') -- byta datatyp T-SQL