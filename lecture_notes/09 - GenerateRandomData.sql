select
	value,
	rand() as '1 random', -- körs bara 1 gång/select så kommer ge en kolumn med samma nummer 0-1
	newID() as 'GUID',
	checksum(newId()) as 'all random', --hashfunktion
	rand(checksum(newId())) as 'all random float range 0 - 1', --checksum(newId()) blir seed för rand()
	rand(checksum(newId())) *10  as 'all random float range 0 - 10',
	rand(checksum(newId())) *10 -5  as 'all random float range -5 - 5',
	abs(checksum(newId())) % 5 as 'all random int range 0 - 4',
	char(65 + abs(checksum(newId())) % 26) as 'random letter A-Z' -- char(65) = 'A'
from generate_series(1,10);
select choose(2, 'Röd', 'Grön', 'Blå'); --väljer 2a i en lista (2a kan komma från en kolumn)

-------------------------------------------------------------------------------
-- crate subquery to be able to generatre random colours
-- Rand3 has to be generated separately and then used in choose()
-- no apparent reason why does not work to do in 1 line (returns NULL some rows)
select 
	value,
	rand(value) as 'Random',
	newid() as 'GUID',
	rand(checksum(newid())) * 10 - 5 as 'Random float',
	abs(checksum(newid())) % 5 as 'Random int 0-4',
	char(65 + abs(checksum(newid())) % 26) as 'Random Letter',
	choose(Rand3, 'Red', 'Green', 'Blue') as 'Random color'
from 
(
	select
		value,
		abs(checksum(newid())) % 3 + 1 as 'Rand 1-3' -- %3 kan bara ge 0, 1, 2
	from generate_series(1, 10)
) subquery
select rand(5)
--------------------------------------------------------------------
-- Skriva ut random namn---------------------------------------

declare @randomName nvarchar(max) = (select top 1 FirstName from users order by newid());
print @randomName;
---

select FirstName from users order by newid() -- sortera i randomiserad ordning
---

-- detta ger samma namn på alla rader då den inre querien är fristående och körs bara 1 gång
select
	value,
	(select top 1 FirstName from users order by newid())
from
	generate_series(1, 10)

-- detta ger olika då inre querien behöver info från yttre och kommer då köras för varje rad
select
	value,
	(select top 1 Symbol from Elements where number = g.value)
from
	generate_series(1, 10) g
---

-- får random förnamn
-- använd g.value = g.value för att den inre skall behöva något från den yttre
select
	value,
	(select top 1 FirstName from users where g.value = g.value order by newid()) AS 'FirstName',
	(select top 1 LastName from users where g.value = g.value order by newid()) AS 'LastName'
from
	generate_series(1, 10) g
---
-- Skapa random anv�ndare
select
	RegistrationDate,
	concat(Firstname, ' ', LastName) as 'Name',
	translate(lower(concat(Firstname, '@', LastName, '.se')), 'åäö', 'aao') as 'Email'
FROM
(
	select
		dateadd(day, abs(checksum(newid())) % 36500, '1900-01-01') as 'RegistrationDate',
		(select top 1 FirstName from users where g.value = g.value order by newid()) AS 'FirstName',
		(select top 1 LastName from users where g.value = g.value order by newid()) AS 'LastName'
	from
		generate_series(1, 10) g
)subquery


-- Skapa random anv�ndare
select
	Id,
	concat(FirstName, ' ', LastName) as 'Name',
	translate(lower(concat(FirstName, '.', LastName, '@gmail.com')), '���', 'aao') as 'Email'
from
(
	select
		concat(format(dateadd(day, abs(checksum(newid())) % 36500,'1900-01-01'), 'yymmdd'), '-', format(abs(checksum(newid())) % 10000, '0000')) as 'Id',
		(select top 1 FirstName from users where g.value = g.value order by newid()) as 'FirstName',
		(select top 1 LastName from users where g.value = g.value order by newid()) as 'LastName'
	from
		generate_series(1, 10000) g
) subquery
