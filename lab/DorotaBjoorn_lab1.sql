-- MoonMissions--------------------------------------------------------------------------------------------
SELECT
	Spacecraft, [Launch date], [Carrier rocket], Operator, [Mission type]
INTO
	SuccessfulMissions
FROM
	MoonMissions
WHERE
	Outcome = 'Successful';

GO

UPDATE
	SuccessfulMissions
SET
	Operator = TRIM(Operator);

GO

UPDATE
	SuccessfulMissions
SET
	Spacecraft =
	CASE
		WHEN CHARINDEX('  (', Spacecraft) = 0 THEN Spacecraft
		ELSE LEFT(Spacecraft, CHARINDEX('  (', Spacecraft))
	END;

GO

SELECT
	Operator,
	[Mission type],
	COUNT(Operator) AS 'Mission count'
FROM
	SuccessfulMissions
GROUP BY
	Operator, [Mission type]
HAVING
	COUNT(Operator) > 1;

GO
-- Users ---------------------------------------------------------------------------------------------------
SELECT
	ID,
	CONCAT(FirstName, ' ', LastName) AS Name,
	CASE
		WHEN SUBSTRING(ID, 10, 1) % 2 = 0 THEN 'Female'
		ELSE 'Male'
	END 
		AS 'Gender',
	UserName,
	Password,
	Email,
	Phone
INTO
	NewUsers
FROM
	Users;

GO

SELECT
	UserName,
	COUNT(UserName) AS 'User name count'
FROM
	NewUsers
GROUP BY
	UserName
HAVING
	COUNT(UserName) > 1;

GO

UPDATE NewUsers 
SET UserName = 'felbe1'
WHERE ID = '890701-1480'

UPDATE NewUsers
SET UserName = 'sigpe1'
WHERE ID = '630303-4894'

UPDATE NewUsers
SET UserName = 'sigpe2'
WHERE ID = '811008-5301'

GO

DELETE
FROM
	NewUsers
WHERE
	Gender = 'Female' AND ID < '700101-0000';

GO

INSERT INTO NewUsers
VALUES('680518-2598', 'Gunnar Gunnarsson', 'Male', 'gungun', '195d221c982ekrieLU9545d06ce3180', 'gunnar.gunnarsson@mail.com', '0748-874266');

GO

SELECT
	Gender,
	AVG(DATEDIFF(YEAR, CONVERT(DATE,CONVERT(varchar(10), LEFT(ID, 6)), 111), getdate())) AS 'Avarage age'
FROM
	NewUsers
GROUP BY
	Gender

GO
-- Company ----------------------------------------------------------------------------------------------------------
SELECT
	p.Id,
	p.ProductName AS Product,
	s.CompanyName AS Supplier,
	cat.CategoryName AS Category
FROM
	company.products p
	JOIN company.suppliers s ON p.SupplierId = s.Id
	JOIN company.categories cat ON p.CategoryId = cat.Id

GO

SELECT
	r.RegionDescription AS 'Region',
	COUNT(*) AS 'Number of employees'
FROM
	company.employee_territory et
	JOIN company.territories t ON et.TerritoryId = t.Id
	JOIN company.regions r ON t.RegionId = r.Id
GROUP BY
	r.RegionDescription;

GO

SELECT
	e.Id,
	CONCAT(e.TitleOfCourtesy, ' ', e.FirstName, ' ', e.LastName) AS 'Employee',
	ISNULL(CONCAT(m.TitleOfCourtesy, ' ', m.FirstName, ' ', m.LastName), 'Nobody!') AS 'Reports to'
FROM
	company.employees e
	LEFT JOIN company.employees m ON e.ReportsTo = m.Id
ORDER BY
	[Reports to];

GO

SELECT
	e.Id,
	CONCAT(e.TitleOfCourtesy, ' ', e.FirstName, ' ', e.LastName) AS 'Employee',
	CASE
		WHEN e.ReportsTo IS NULL THEN 'Nobody!'
		ELSE CONCAT(m.TitleOfCourtesy, ' ', m.FirstName, ' ', m.LastName)
	END AS 'Reports to'
FROM
	company.employees e
	LEFT JOIN company.employees m ON e.ReportsTo = m.Id
ORDER BY
	[Reports to];

GO