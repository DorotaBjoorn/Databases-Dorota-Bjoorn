-- Aggregering

SELECT * FROM Elements;
SELECT * FROM Elements order by BoilingPoint;

SELECT COUNT(*) FROM Elements; --> 118

SELECT
	COUNT(*) AS '# rows',
	COUNT(Meltingpoint) AS '# non NULL in Meltingpoint',
	COUNT(*) - COUNT(Meltingpoint) AS '[# NULL in Meltingpoint]',
	SUM(Mass) as 'Sum of mass',
	AVG(Boilingpoint) AS 'Average boiling point', -- Null ignoreras
	AVG(isnull(Boilingpoint, 0)) AS '(Average if null not ignored)',
	SUM(Boilingpoint) / COUNT(*) AS '(Average if null rows not ignored)',
	MIN(Boilingpoint) AS 'Min boiling point',
	MAX(Boilingpoint) AS 'Max boiling point',
	string_agg(symbol, ', ') AS 'List of symbols' -- måste vara i agg för att få ut allt på 1 rad
FROM
	Elements;

SELECT COUNT(Period) FROM Elements; -- antal värden
SELECT COUNT(DISTINCT Period) FROM Elements; -- unika värden

------------------------------------------------------------------------------------------------------
-- Gruppering - group by
SELECT * FROM Elements;
SELECT count(Period) FROM Elements WHERE Period = 2;
SELECT count(Period) FROM Elements group by Period;
SELECT
	Period,
	count(Period) AS 'Number of elements',
	string_agg(Symbol, ', ') AS Symbols -- måste vara i agg för att få ut på 1 rad
FROM
	Elements
group by
	Period;

SELECT
	id,
	ShipRegion,
	ShipCountry,
	ShipCity
FROM
	company.orders
order by
	ShipRegion, ShipCountry, ShipCity

SELECT
	ShipRegion,
	ShipCountry,
	ShipCity,
	count(*) AS 'Number of orders'
FROM
	company.orders
group by
	ShipRegion, ShipCountry, ShipCity; -- grupperar rader som har samma input i alla 3 kolumnerna

SELECT
	-- ShipRegion, -- kan inte ha dessa med då dessa inte är med i group by
	-- ShipCountry,
	ShipCity,
	count(*) AS 'Number of orders'
FROM
	company.orders
group by
	ShipCity;

SELECT * FROM company.orders

----------------------------------------------------------------------------------------------------------
-- Having - filtrering på gruppnivå efter group by (WHERE filtrering på radnivå)
SELECT
	Period,
	count(Period) AS 'Number of elements',
	string_agg(Symbol, ', ') AS Symbols -- måste vara i agg för att få ut på 1 rad
FROM
	Elements
group by
	Period
having
	count(Period) >= 18;

SELECT
	Period,
	count(Period) AS 'Number of elements',
	string_agg(Symbol, ', ') AS Symbols -- måste vara i agg för att få ut på 1 rad
FROM
	Elements
WHERE
	Boilingpoint < 1000
group by
	Period
having
	count(Period) <= 3;