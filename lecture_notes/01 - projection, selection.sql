-- Radkommentar

/*
	Blockkommentar
	dvs flera rader
*/


----------------------------------------------------------------------------------------------------------------------
-- Projection (choose which columns and get all rows)
-- SELECT

select * from users;
select FirstName, LastName, FirstName, * from users;
select FirstName, LastName, FirstName, 'Hejsan' from users;
select FirstName, LastName, FirstName, 'Hejsan' as 'Greeting' from users;
select FirstName as 'Förnamn', LastName, FirstName, 'Hejsan' as 'Greeting' from users;
select FirstName as 'Förnamn', LastName, 'Hejsan ' + FirstName as 'Greeting' from users;
select FirstName as 'Förnamn', LastName, 'Hejsan ' + FirstName + ' ' + LastName as 'Greeting' from users;
select FirstName, LastName, 'text input' from users;
select FirstName as 'Förnamn', upper(LastName) as 'Efternamn', 'Hejsan ' + FirstName + ' ' + LastName as 'Greeting' from users;

-- Manuell konotering per kolumn
select
	FirstName as 'Förnamn',
	LastName,
	'Hejsan ' + FirstName + ' ' + LastName as 'Greeting'
from
	users;


----------------------------------------------------------------------------------------------
-- Selection (choose which rows)
-- WHERE

select * -- projection
from
	users
where -- selection
	FirstName = 'my';


select * from users where len(FirstName) <> 4; -- samma som not len(FirstName) = 4 (= för att indikera ==)
select * from user where len(FirstName) <> 4 and len(LastName) <= 6;
select * from users where FirstName < 'c';

-----------------------------------------------------------------------------------------------
select 9 / 2
select 9.0 / 2
select 9 % 2


----------------------------------------------------------------------------------------------
-- LIKE
select * from Airports where IATA = 'got'
select top 10 * from Airports where IATA like 'G%' --% står för flera godtyckliga tecken,
select top 10 * from Airports where IATA like '_G_' --_ står för 1 godtyckligt tecken
select top 10 * from Airports where IATA like 'G[a-c][t-z]' --[] omsluter villkor för 1 tecken
select top 10 * from Airports where IATA like replicate ('[a-b]', 3)

select replicate('Dorota', 5);


------------------------------------------------------------------------------------------------
--Sorting
-- ORDER BY

SELECT top 10 * from users ORDER BY lastname, firstname;
SELECT top 10 * from users where FirstName like 'a%' order by LastName desc, FirstName; --asc är default och behöver inte skrivas ut


-----------------------------------------------------------------------------------------------------
-- Get specific values
-- DISTINCT

select * from GameOfThrones;
select Season from GameOfThrones;
select distinct Season from GameOfThrones; -- gives unique values


-------------------------------------------------------------------------------------------------------------
-- Alias for columns
-- AS

select
	FirstName as 'Förnamn', -- föredraget sätt
	'Efternamn' = LastName, -- samma som as men förvirrande då an blandas ihop med tilldelning av värden till variabler
	'inputvärden' "kolumnnamn" -- en ny kolumn skapas
from
	Users


------------------------------------------------------------------------------------------------------------------
-- Slå ihop fler queries 
-- UNION ALL; UNION

-- måste ta ut lika många kolumner i varje query och dessa skall innahålle samma datatyp
-- lite konstigt exempel då Title är som Förnman och Directed by i Efternamn
-- resultatet blir 123 rader
-- query 1 - ger 50 rader
select
	FirstName as 'Förnamn',
	LastName as 'Efternamn'
from
	Users
union all
-- query 2 - ger 73 rader
select Title, [Directed by] from GameOfThrones order by 'Förnamn'


------------------------------------------------------------------------------------------------------------------
-- If sats
-- CASE - WHEN

select
	*,
	case
		when len(FirstName) <= 4 then 'Kort'
		when len(FirstName) >= 9 then 'Långt'
		else 'Mellan'
	end as 'Längd på förnamn'
from
	users