-- One to Many eftersom 1 land kan ha flera st�der men varje stad kan bara kopplas till ett land

-- skapa tabeller
DROP TABLE Countries
CREATE TABLE Countries
(
	Id int,
	Name nvarchar(max)
);

INSERT INTO Countries VALUES (1, 'Sweden');
INSERT INTO Countries VALUES (2, 'Denmark');
INSERT INTO Countries VALUES (3, 'Norway');
INSERT INTO Countries VALUES (4, 'Finland');


DROP TABLE Cities;
CREATE TABLE Cities
(
	Id int,
	Name nvarchar(max),
	CountryId int
);

INSERT INTO Cities VALUES (1, 'Stockholm', 1);
INSERT INTO Cities VALUES (2, 'Gothenburg', 1);
INSERT INTO Cities VALUES (3, 'Malm�', 1);
INSERT INTO Cities VALUES (4, 'Copenhagen', 2);
INSERT INTO Cities VALUES (5, 'Oslo', 3);
INSERT INTO Cities VALUES (6, 'Bergen', 3);
INSERT INTO Cities VALUES (7, 'London', 5);

SELECT * FROM Countries;
SELECT * FROM Cities;

-- olika joins
SELECT * FROM Cities JOIN Countries ON Cities.CountryId = Countries.Id; -- samma som INNER JOIN

SELECT
	ci.id,
	ci.name AS 'City',
	co.name AS 'Country'
FROM
	Cities ci -- ci �r alias f�r cities
	JOIN Countries co ON ci.CountryId = co.Id; -- co �r alias f�r countries
	-- yttligare joins fr�n eventuella fler tabeller

SELECT
	ci.id,
	ci.name AS 'City',
	co.name AS 'Country'
FROM
	Cities ci -- ci �r alias f�r cities
	LEFT JOIN Countries co ON ci.CountryId = co.Id; -- eg LEFT OUTER JOIN men outer skrivs ej ut


SELECT
	ci.id,
	ci.name AS 'City',
	co.name AS 'Country'
FROM
	Cities ci -- ci �r alias f�r cities
	RIGHT JOIN Countries co ON ci.CountryId = co.Id;


SELECT
	ci.id,
	ci.name AS 'City',
	co.name AS 'Country'
FROM
	Cities ci -- ci �r alias f�r cities
	FULL JOIN Countries co ON ci.CountryId = co.Id;

SELECT * FROM Countries CROSS JOIN Cities; -- ologiskt h�r
--------------------------------------------------------------------------------------------------------
-- join med gruppering
SELECT
	co.name AS 'Country',
	COUNT(ci.name) AS 'Numbr of citites', -- om tar COUNT(*) skulle f� 1 p� Finland d� 1 rad �ven om NULL
	ISNULL(STRING_AGG(ci.name, ', '), '-') AS 'List of cities' -- ers�tter 'NULL' med -
FROM
	Cities ci
	RIGHT JOIN Countries co ON ci.CountryId = co.Id
GROUP BY
	co.name;

-- join med where
SELECT
	ci.id,
	ci.name AS 'City',
	co.name AS 'Country'
FROM
	Cities ci -- ci �r alias f�r cities
	JOIN Countries co ON ci.CountryId = co.Id
WHERE
	co.name = 'Sweden';
