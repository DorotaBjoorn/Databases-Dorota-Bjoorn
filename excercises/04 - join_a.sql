-- COMPANY---------------------------------------------------------------------------------------

-- 1)
-- relevanta tabeller
SELECT * FROM company.orders;
SELECT * FROM company.order_details;

-- sortera fram ordrar till London och motsvarande produktnummer (kod f�r visualisering av mellansteget)...
SELECT
	o.Id,
	od.ProductId
FROM
	company.orders o
	JOIN company.order_details od ON o.Id = od.OrderId
WHERE
	o.ShipCity = 'London';

-- ... ber�kana antalet unika produktnummer
SELECT
	FORMAT(CAST(COUNT(DISTINCT od.ProductId) AS FLOAT) / (SELECT COUNT(DISTINCT ID) FROM company.products) * 100, '#.00') AS 'Unique products shipped to London' -- ??? hur f�r man ut andel p� ett snyggare s�tt???, TODO: kod ist�llet f�r 0.77
FROM
	company.orders o
	JOIN company.order_details od ON o.Id = od.OrderId
WHERE
	o.ShipCity = 'London';
-- ==================================================================================================

--2)
-- relevanta tabeller
SELECT * FROM company.orders;
SELECT * FROM company.order_details;

-- sortera fram st�der och produktnummer (kod f�r visualisering av mellansteget)...
SELECT
	o.ShipCity,
	od.ProductId
FROM
	company.orders o
	JOIN company.order_details od ON o.Id = od.OrderId
ORDER BY
	o.ShipCity, od.ProductId;

-- ... ber�kana antalet unika produktnummer i varje stad
SELECT
	o.ShipCity,
	COUNT(DISTINCT od.ProductId) AS '# of unique products sent'
FROM
	company.orders o
	JOIN company.order_details od ON o.Id = od.OrderId
GROUP BY
	o.ShipCity;
--============================================================================================

-- 3)
-- relevanta tabeller
SELECT * FROM company.products;
SELECT * FROM company.orders;
SELECT * FROM company.order_details;

-- sortera fram relevant info och ber�kna inkomst f�r varje relevant order (kod f�r visualisering av mellansteget)
SELECT
	od.UnitPrice,
	od.Quantity,
	od.Discount,
	od.UnitPrice * od.Quantity - od.UnitPrice * od.Quantity * od.Discount AS 'OrderPrice'
FROM
	company.order_details od
	JOIN company.products p ON od.ProductId = p.Id
	JOIN company.orders o ON od.OrderId = o.Id
WHERE
	o.ShipCountry = 'Germany' AND p.Discontinued = 1;

-- ber�kna totala inkomster p� utg�ngna produkter s�lda till Tyskland
SELECT
	SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS 'Total order'
FROM
	company.order_details od --?????? vilken ordning skall jag ha tabellerna? od har gem info med p och o, p och o har igen gem
	JOIN company.products p ON od.ProductId = p.Id --???????????? spelar ordningen od=p eller p=od roll?
	JOIN company.orders o ON od.OrderId = o.Id
WHERE
	o.ShipCountry = 'Germany' AND p.Discontinued = 1;
--========================================================================================================================================

-- 4)
-- relevanta tabeller
SELECT * FROM company.categories;
SELECT * FROM company.products;

-- sortera fram relevant info och ber�kna pris f�r varje produkt i lager (kod f�r visualisering av mellansteget)
SELECT
	p.CategoryId,
	c.CategoryName,
	p.UnitPrice,
	p.UnitsInStock,
	p.UnitPrice * p.UnitsInStock AS 'Tot price'
FROM
	company.products p
	JOIN company.categories c ON p.CategoryId = c.Id

-- ber�kna totala v�rdet i lager per produkt kategorio och v�lja raden med h�sta v�rdet
SELECT TOP 1
	p.CategoryId,
	c.CategoryName,
	SUM(p.UnitPrice * p.UnitsInStock) AS 'Tot value'
FROM
	company.products p
	JOIN company.categories c ON p.CategoryId = c.Id
GROUP BY
	p.CategoryId, c.CategoryName
ORDER BY
	[Tot value] DESC;
--====================================================================================================================

-- 5)
-- relevanta tabeller
SELECT * FROM company.orders;
SELECT * FROM company.order_details;
SELECT * FROM company.suppliers;
SELECT * FROM company.products;

SELECT TOP 1
	CompanyName AS 'Supplier',
	SUM(od.Quantity) AS 'Count'
FROM
	company.orders o
	JOIN company.order_details od ON o.Id = od.OrderId
	JOIN company.products p ON od.ProductId = p.Id
	JOIN company.suppliers s ON p.SupplierId = s.Id
WHERE
	o.OrderDate >= '2013-06-01' AND o.OrderDate < '2013-09-01 00:00:00' -- BETWEEN... AND... blir samma som >= och <= vilket kan bli fel. Icke indikerad tid blir 00:00:00
GROUP BY
	s.CompanyName
ORDER BY
	[Count] DESC;
