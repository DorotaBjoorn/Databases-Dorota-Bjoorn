create table Products
(
	id int primary key identity (100, 5), -- startv�rde och steg f�r automatisk uppr�kning av id
	name nvarchar(50)
);

INSERT INTO Products (Name) values('Product');
SELECT * FROM Products;

-- DELETE FROM Products WHERE id > 120 --deletar rader men nollst�ller inte id r�knaren
-- TRUNCATE table Products --tar bort alla rader och st�ller om id r�knaren

SELECT CAST('45', int); -- byta datatyp nvarchar -> int enligt ISO-SQL
SELECT CONVERT(int, '45') -- byta datatyp T-SQL