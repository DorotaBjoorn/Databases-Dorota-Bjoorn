-- denna sats returnerar bara år som har antal missioner > 0. Åren med 0 finns inte med
select
	YEAR([Launch date]) AS Year,
	COUNT(*) AS 'Missions'
from MoonMissions
group by
	YEAR([Launch date])

-- för att få med alla år även de med 0
select * from generate_series(1958, 2019)

select
	y.value,
	COUNT(Spacecraft) AS 'Missions' -- om tar count(*) får man 1 även där NULL
from
	MoonMissions m
	RIGHT JOIN generate_series(1958, 2019) y ON y.value = YEAR(m.[Launch date])
group by
	y.value

