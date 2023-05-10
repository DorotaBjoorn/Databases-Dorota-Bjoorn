-- denna sats returnerar bara �r som har antal missioner > 0. �ren med 0 finns inte med
select
	YEAR([Launch date]) AS Year,
	COUNT(*) AS 'Missions'
from MoonMissions
group by
	YEAR([Launch date])

-- f�r att f� med alla �r �ven de med 0
select * from generate_series(1958, 2019)

select
	y.value,
	COUNT(Spacecraft) AS 'Missions' -- om tar count(*) f�r man 1 �ven d�r NULL
from
	MoonMissions m
	RIGHT JOIN generate_series(1958, 2019) y ON y.value = YEAR(m.[Launch date])
group by
	y.value

------------------
-- f�r alla positionerna
declare @text nvarchar(500) = 'Grammar lessons with exercises and clear explanations, grammar charts, reading and listening tests with transcriptions, writing lessons, instant marking, answer feedback, and much more!';
declare @len int = len(@text);
select * from generate_series(1, len(@text));

-- f�r alla tecknen
declare @text nvarchar(500) = 'Grammar lessons with exercises and clear explanations, grammar charts, reading and listening tests with transcriptions, writing lessons, instant marking, answer feedback, and much more!';
declare @len int = len(@text);
select SUBSTRING(@text, value, 1) from generate_series(1, len(@text));

-- skippar mellanslagen
declare @text nvarchar(500) = 'Grammar lessons with exercises and clear explanations, grammar charts, reading and listening tests with transcriptions, writing lessons, instant marking, answer feedback, and much more!';
select
	SUBSTRING(@text, value, 1) as 'chr'
from
	generate_series(1, len(@text))
where
	SUBSTRING(@text, value, 1) <>  ' ';

-- skippar mellanslag och vissa av vokalerna
declare @text nvarchar(500) = 'Grammar lessons with exercises and clear explanations, grammar charts, reading and listening tests with transcriptions, writing lessons, instant marking, answer feedback, and much more!';
select
	SUBSTRING(@text, value, 1) as 'chr'
from
	generate_series(1, len(@text))
where
	SUBSTRING(@text, value, 1) NOT IN  (' ', 'a', 'i', 'e', 'o');

-- skapar en ny str�ng utan mellanslag och vissa av vokalerna
declare @text nvarchar(500) = 'Grammar lessons with exercises and clear explanations, grammar charts, reading and listening tests with transcriptions, writing lessons, instant marking, answer feedback, and much more!';
declare @newText nvarchar(500) = '';
select
	@newText += SUBSTRING(@text, value, 1)
from
	generate_series(1, len(@text))
where
	SUBSTRING(@text, value, 1) NOT IN  (' ', 'a', 'i', 'e', 'o');

print @newText;

-------------------------------------------------
