-- a)
SELECT * FROM Elements;
SELECT
	DISTINCT Period,
	MIN(Number) AS 'From',
	MAX(Number) AS 'To',
	FORMAT(AVG(StableIsotopes * 1.0), '#.00')  as 'Average isotopes', --f� till 2 decimaler
	STRING_AGG(Symbol,', ') AS 'Symbols'
FROM
	Elements
GROUP BY
	Period
--==========================================================================================

-- b)
SELECT * FROM company.customers;

SELECT
	Region,
	Country,
	City,
	COUNT(*) AS 'Number of orders' -- se kommentar nedan
FROM
	company.customers
GROUP BY
	Region, Country, City
HAVING
	COUNT(City) >= 2;

-- count(city) �r korrekt men f�rvirrande att l�sa kod
-- om annan kolumna v�ljs och den inneh�ller NULL s� blir det fel
-- s�krast �r count(id) eller count(*)
--==============================================================================================

-- c) ??? can detta apprach vara ett alternativ till +=?????????????????????
SELECT * FROM GameOfThrones;

DECLARE @StartMonth AS nvarchar(10);
DECLARE @EndMonth AS nvarchar(10);
DECLARE @episodes AS int;
DECLARE @AverageViewers AS float


SELECT
	FORMAT(MIN([Original air date]), 'MMMM', 'sv') AS 'Season start',
	FORMAT(MAX([Original air date]), 'MMMM yyyy', 'sv') AS 'Season end',
	COUNT(*) AS 'Number of episodes',
	FORMAT(AVG([U.S. viewers(millions)]), '#.##') AS 'Average viewers'
FROM
	GameOfThrones
GROUP BY
	Season;



-------------
DECLARE @Summary AS NVARCHAR(MAX) = '';

SELECT @Summary += CONCAT(
	'Start: ', FORMAT(MIN([Original air date]), 'MMMM', 'sv'),
	' End: ', FORMAT(MAX([Original air date]), 'MMMM yyyy', 'sv'),
	' Episodes: ', COUNT(*),
	' Viewers: ', FORMAT(AVG([U.S. viewers(millions)]), '#.##'),
	CHAR(13)
	)
FROM
	GameOfThrones
GROUP BY
	Season;

Print @Summary
--====================================================

-- d)
SELECT * FROM Users

SELECT
	CONCAT(FirstName, ' ', LastName) AS 'Namn',
	CONCAT(DATEDIFF(YEAR, SUBSTRING(ID, 1, 6), getdate()), ' �r') AS '�lder',
	CASE													
		WHEN (SUBSTRING(ID, 10, 1) % 2 = 0) THEN 'Kvinna'
		ELSE 'Man'
	END
		AS 'K�n'
FROM
	Users
ORDER BY
	FirstName, LastName;

--Alt
SELECT
	FirstName + ' ' + LastName AS 'Namn',
	CAST(DATEDIFF(YEAR, LEFT(ID, 6), GETDATE()) AS nvarchar) + '�r' AS '�lder',
	IIF(SUBSTRING(ID, 10, 1) % 2 = 0, 'Kvinna', 'Man') AS 'K�n' -- mer kompakt �n CASE - WHEN men l�ngsammare
FROM
	Users
ORDER BY
	FirstName, LastName;
--======================================================================================

-- e)
SELECT * FROM Countries;


SELECT
	Region,
	COUNT(Country) AS '# Countries',
	SUM(CONVERT(BIGINT, Population)) AS 'Tot population',
	SUM([Area (sq# mi#)]) AS 'Tot area',
	CONVERT(FLOAT, SUM(CONVERT(BIGINT, Population))/SUM([Area (sq# mi#)])),
	FORMAT(CONVERT(FLOAT, SUM(CONVERT(BIGINT, Population))/SUM([Area (sq# mi#)])), '#.##') AS 'Pop density'----- ???????? varf�r f�r jag inte 2 decimaler????????
	-- AVG([Infant mortality (per 1000 births)]) AS 'Avg infant mortality'
FROM
	Countries
GROUP BY
	Region;


--================================================================================================

-- f)
SELECT * FROM Airports
SELECT
	CASE
		WHEN CHARINDEX (',', [Location served]) = 0 THEN [Location served]					-- om land = stad (ex Hong-Kong), dvs saknar ',' => CHARINDEX = 0 returnera Location served som den �r
		ELSE TRIM(CHAR(160) FROM RIGHT([Location served] , CHARINDEX (',', REVERSE([Location served]))-2))	-- v�nd, hitta ',', l�ngden blir index -2 ?????????????? men hur ta bort ' ' d�r ',' p� fel st�lle - char(160)
	END																						
		AS Country
FROM
	Airports
GROUP BY -- kan inte group by p� alias som skapades under selct utan m�ste vara en existerande column d�rf�r f�r anv�nda hela koden som skapar alias Countries
	CASE
		WHEN CHARINDEX (',', [Location served]) = 0 THEN [Location served]					-- om land = stad (ex Hong-Kong), dvs saknar ',' => CHARINDEX = 0 returnera Location served som den �r
		ELSE TRIM(CHAR(160) FROM RIGHT([Location served] , CHARINDEX (',', REVERSE([Location served]))-2))	-- v�nd, hitta ',', l�ngden blir index -2 ?????????????? men hur ta bort ' ' d�r ',' p� fel st�lle - char(160)
	END
ORDER BY
	Country





select char(32) AS 'Space', char(160) AS 'No braking space' -- vanligt space och no braking space
select trim(concat(char(160), char(32)) FROM '�Canada') -- om vill ta bort b�de char(32) och char(160)

-- ALT---
SELECT
    CASE
        WHEN [Location served] LIKE '%,%' THEN RIGHT([Location served], CHARINDEX(',', REVERSE([Location served])) - 2)
        ELSE [Location served]
    END AS 'Country',
    COUNT(DISTINCT(IATA)) as 'Airports',
    SUM(CASE WHEN ICAO IS NULL THEN 1 ELSE 0 END) AS 'Missing ICAO',
    FORMAT(SUM(CASE WHEN ICAO IS NULL THEN 1 ELSE 0 END) * 1.0 / COUNT(DISTINCT(IATA)) * 100, '0.##') AS 'Missing ICAO (%)'
FROM
    Airports
GROUP BY
    CASE
        WHEN [Location served] LIKE '%,%' THEN RIGHT([Location served], CHARINDEX(',', REVERSE([Location served])) - 2)
        ELSE [Location served]
    END
ORDER BY
    Country




-- ALT --------------------
select 
Region, 
count(country) as 'Country count', 
sum(convert(numeric,Population)) as 'Total Pop', 
sum(convert(numeric, [Area (sq# mi#)])) as 'Total area',
 format(avg(convert(float, replace([Pop# Density (per sq# mi#)], ',','.'))), '#####.##') as 'Average pop desity',
convert(int,avg(convert(float, replace([Infant mortality (per 1000 births)], ',','.'))) / 100)  as 'Aveage IMDR (per 100 000 births)' 
from 
Countries 
group by 
Region