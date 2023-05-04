-- exempel för illustrera queries
-- obs! egenligen vore bättre approach att joina tabellern
-- så fort inre queary använder data från yttre queary (dvs inre ej fristående att köra) blir det 1 uppsalg per rad i yttre query så långsamt
-- i detta fallet körs den inre subquerien 3503 gågner dvs för varje yttre eftersom den behöver info (t-TrackId i inre finns info i FROM i yttre så den inre är inte fristående) :(
SELECT
	t.TrackId,
	t.Name,
	(SELECT COUNT(*) FROM music.playlist_track pt WHERE pt.TrackId = t.TrackId) -- subqery (hade varit bättre med join
FROM
	music.tracks t

---------------------------------------
-- ex på en bra subquery där den inre går att köra fristående och blir därmed 2 queries (1 inre och 1 yttre)
SELECT
	AVG(subquery.[Count unique artists]) -- NameOfSubquery.ColumnName från den tillfälliga tabellen som skapas inom subquery()
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
	-- ORDER BY [Count unique artists] DESC -- kan inte ha order by i en subquery utan får läggas utanför
) subquery -- NameOfSubquery - vilket blir namnet på tillfälliga tabellen som skapas inom paranterserna för subquery()