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

