-- Play list
SELECT * FROM music.albums;
SELECT * FROM music.artists;
SELECT * FROM music.genres;
SELECT * FROM music.media_types;
SELECT * FROM music.playlist_track;
SELECT * FROM music.playlists;
SELECT * FROM music.tracks;

DECLARE @playlist as nvarchar(max) = 'Heavy Metal Classic';

SELECT
	g.Name AS 'Genre',
	ar.Name AS 'Artist',
	al.Title AS 'Album',
	t.Name AS 'Track',
	-- t.Milliseconds / 1000 % 60 AS 'Seconds',
	-- t.Milliseconds / 1000 / 60 % 60 AS 'Minutes',
	-- t.Milliseconds / 1000 /60 / 60 AS 'Hours', 
	CONCAT('0', t.Milliseconds / 1000 / 60 % 60, ':', t.Milliseconds / 1000 % 60) AS 'Length',
	-- FORMAT(DATEADD(ms, t.Milliseconds, '00:00'), 'mm:ss') AS 'Length', -- adderar ms till startpunkt 00:00, formaterar om till sträng med format mm:ss, begränsning om låtar som är längre än 59:59
	-- FORMAT(DATEADD(ms, t.Milliseconds, 0), 'mm:ss') as 'Length',  -- alternativ
	CONCAT(FORMAT(ROUND((t.Bytes / POWER(1024.0, 2)), 1), '.0'), ' MiB')  AS 'Size', -- .0 för att få en float som resultat; KiB = 1024 bytes, kB = 1000 eller 1024 beroende på sammanhang
	ISNULL(t.Composer, '-') AS 'Composer' -- CASE WHEN THEN OK oxå
FROM
	music.genres g
	JOIN music.tracks t ON g.GenreId = t.GenreId
	JOIN music.albums al ON t.AlbumId = al.AlbumId
	JOIN music.artists ar ON al.ArtistId = ar.ArtistId
	JOIN music.playlist_track pt ON pt.TrackId = t.TrackId
	JOIN music.playlists p ON pt.PlaylistId = p.PlaylistId
WHERE
	p.Name = @playlist
ORDER BY
	NEWID() -- genererar olika GUID för varje rad för varje kodkörning - order by NEWID() ger då shuffle funktion
--==========================================================================================================

-- 1), 2)
SELECT TOP 1
	ar.Name,
	SUM(t.Milliseconds) AS 'Tot play time'
	AVG(t.Milliseconds) AS 'Average track lenght'
FROM
	music.tracks t
	JOIN music.albums al ON t.AlbumId = al.AlbumId
	JOIN music.artists ar ON al.ArtistId = ar.ArtistId
WHERE
	MediaTypeId != 3
GROUP BY
	ar.Name
ORDER BY
	[Tot play time] DESC

--=============================================================================================================

-- 3)

SELECT TOP 1
	SUM(CAST(Bytes AS Bigint)) / POWER(1024, 3) AS 'Total size (GiB)'
	-- SUM(SUM(t.Milliseconds)) OVER() AS 'Total time for Video genres' -- summerar summerat; bortkommenterat då egentligen inte svar på frågan
FROM
	music.tracks
WHERE
	MediaTypeId = 3
	-- g.Name IN ('Soundtrack', 'Science Fiction', 'TV Shows', 'Sci Fi & Fantasy', 'Drama', 'Comedy') --bortkommenerat då ej sjvar på frågan
--===================================================================================================================

-- 4)
SELECT
	p.Name AS 'Playlist',
	COUNT(DISTINCT ar.ArtistId) AS 'Count unique artists'
FROM
	music.Tracks t
	JOIN music.playlist_track pt ON pt.TrackId = t.TrackId
	JOIN music.albums al ON t.AlbumId = al.AlbumId
	JOIN music.artists ar ON al.ArtistId = ar.ArtistId
	RIGHT JOIN music.playlists p ON p.PlaylistID = pt.PlaylistID -- right join för att få med playlists som inte har någon artist (right för att playlists kommer till höger/sist och det är den som inte skall kapas)
GROUP BY
	p.PlaylistId, p.Name
ORDER BY
	[Count unique artists] DESC;

-- PlayList 1 och 8 verkar vara kopior
--==================================================================================================================

-- 5)
SELECT
	AVG(subquery.[Count unique artists]) -- NameOfSubquery.ColumnName
FROM
(
	SELECT
		p.PlaylistId,
		p.Name AS 'Playlist',
		COUNT(DISTINCT ar.ArtistId) AS 'Count unique artists'
	FROM
		music.Tracks t
		JOIN music.playlist_track pt ON pt.TrackId = t.TrackId
		JOIN music.albums al ON t.AlbumId = al.AlbumId
		JOIN music.artists ar ON al.ArtistId = ar.ArtistId
		RIGHT JOIN music.playlists p ON p.PlaylistID = pt.PlaylistID -- right join för att få med playlists som inte har någon artist (right för att playlists kommer till höger/sist och det är den som inte skall kapas)
	GROUP BY
		p.PlaylistId, p.Name
	-- ORDER BY [Count unique artists] DESC -- kan inte ha order by i en subquery
) subquery -- NameOfSubquery