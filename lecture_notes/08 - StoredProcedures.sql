-- Procedures körs fristående och inte som del av select, update etc
-- Funktioner är del av select, udate etc satser

CREATE procedure myProcedure AS 
BEGIN
	print 'hej';
END  -- returnerar alltid en int, anger man inget annat retureras 0
exec myProcedure 


ALTER procedure myProcedure AS 
BEGIN
	print 'hej';
	return 5; -- kan bara returnera int
END  -- returnerar 5
exec myProcedure 


ALTER procedure myProcedure @text nvarchar(max) AS 
BEGIN
	print @text;
END
exec myProcedure 'Fredrik'


ALTER procedure myProcedure @text nvarchar(max), @count int AS 
BEGIN
	WHILE @count > 0
	BEGIN
		print @text;
		set @count -= 1;
	END
END
exec myProcedure 'Fredrik', 5 -- skiver ut 5 rader med angivna texten


ALTER procedure myProcedure @text nvarchar(max), @count int AS 
BEGIN
	SELECT @text FROM generate_series(1, @count);
END
exec myProcedure 'Fredrik', 5 -- skriver som ovan fast in en tabell (funkar enkelt eftersom samma sak skall skrivas)


ALTER procedure myProcedure @text nvarchar(max), @count int AS 
BEGIN
	DECLARE @result table -- tabellvariabel
	(
		value nvarchar(max)
	);

	WHILE @count > 0
	BEGIN
		INSERT INTO @result values(@text);
		SET @count -= 1;
	END

	SELECT * FROM @result
END

EXEC myProcedure 'Fredrik', 5 -- skiver ut 5 rader  tabell med angivna texten

-- default värde på @count -> räcker med exec myProcedure 'Fredrik'
-- outputvariabel @outdata anävnds för att returnera annat än int (vilket är begränsningen för return)
ALTER procedure myProcedure @text nvarchar(max), @count int = 3, @outdata nvarchar(max) output AS 
BEGIN
	DECLARE @result table -- tabellvariabel
	(
		value nvarchar(max)
	);

	WHILE @count > 0
	BEGIN
		INSERT INTO @result values(@text);
		SET @count -= 1;
	END

	SELECT @outdata = string_agg(value, ', ') FROM @result; -- concatinerar resultatet från vare loop med ,
END

DECLARE @result nvarchar(max)
EXEC myProcedure 'Fredrik', 5, @outdata = @result output;
print @result

--------------------------------------------------------------------------------------
-- Dynamiska queries
DECLARE @query nvarchar(max) = 'Select * from users where firstname = ''Ulla'';'
print @query;

DECLARE @query nvarchar(max) = 'Select * from users where firstname = ''Ulla'';'
exec sp_executesql @query;