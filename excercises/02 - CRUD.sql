-- create copy of tables
SELECT * INTO GameOfThrones_copy FROM GameOfThrones;
SELECT * FROM GameOfThrones_copy;
SELECT * INTO Users_copy FROM Users;
SELECT * FROM Users_copy;
SELECT * INTO Airports_copy FROM Airports;
SELECT * FROM Airports_copy;
SELECT * INTO Elements_copy FROM Elements;

-- a)
SELECT
	Title,
	concat('S', format(Season,'00'), 'E', format(EpisodeInSeason, '00')) as 'Episode'
FROM
	GameOfThrones_copy;

-- alternativ
	--'S' + format(Season,'00') + 'E'+ format(EpisodeInSeason, '00') as 'Episode' -- format() returnerar str�ng
	-- concat('S', right('00' + cast(season as varchar), 2), 'E', right('00' + cast(EpisodeInSeason as varchar), 2)) -- cast g�r om datatypen
	--'S' + Season + 'E'+ EpisodeInSeason as 'Episode' -- funkear ej d� g�r ej plussa ihop str�ngar och int
	-- concat('S', Season, 'E', EpisodeInSeason) -- funkar d� concat g�r om allt till str�ngar


-- b)
UPDATE
	Users_copy
SET
	UserName = translate(lower(concat(left(FirstName, 2), left(LastName, 2))),'���', 'aao'); -- translate ers�tta ��� med aao

-- alternativ
-- lower(left(Firstname,2) + left(LastName,2))
-- SET UserName = LOWER(CONCAT(SUBSTRING(FirstName, 1, 2), SUBSTRING(LastName, 1, 2)));


-- c)
-- effektiv kod d� uppdaterar bara rader med NULL
UPDATE Airports_copy
SET Time = '-', DST = '-'
WHERE Time is NULL or DST is NULL; -- m�ste skriva IS NULL och inte = NULL

-- alternativ
-- s�krare kod? men mindre effektiv d� uppdaterar alla rader med sitt v�rde eller - om NULL
UPDATE Airports_copy
SET DST = isnull(DST, '-'), Time = isnull(Time, '-')
FROM Airports_copy;


-- d)
DELETE
FROM Elements_copy
WHERE
	[Name] IN ('Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium') OR 
	[Name] LIKE '[dkmou]%';


-- e)
SELECT
	Symbol,
	[Name],
    CASE
        WHEN Symbol = left(Name,len(symbol)) THEN 'Yes'
        ELSE 'No'
    END
		AS 'Comparison'
INTO
	Elements_copy_2
FROM
    Elements;

SELECT * FROM Elements_copy_2;


-- f)
-- skapa kopia utan Code
SELECT Name, Red, Green, Blue
INTO Colors_copy
FROM Colors;

-- select statement som �terskapar Colors
SELECT
	concat('#',format(Red, 'X2'), format(Green, 'X2'), format(Blue, 'X2')) AS 'Code', -- SELECT FORMAT(255, 'X'); g�r om till hex
	*
FROM Colors_copy;

-- komemntar
select format(14, 'X') --> E
select format(14, 'X2') --> 0E



-- g)
--skapa begr�nsad kopia
SELECT Integer, String
INTO Types_copy
FROM Types;

-- query f�r att �terskapa Types
SELECT
	[Integer],
	[Integer] /100.0 AS 'Float', -- indikerar att det ena v�rdet skall vara float f�r att f� float
	String,
	CAST(DATEADD(DAY, [Integer] - 1, DATEADD(MINUTE, [Integer], '2019-01-01 09:00:00')) AS DATETIME2) AS 'DateTime',
	[Integer] % 2 AS 'Bool'
FROM Types_copy;

select * from Types;