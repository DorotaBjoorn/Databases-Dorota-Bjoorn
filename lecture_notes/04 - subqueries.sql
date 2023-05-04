-- exempel f�r illustrera queries
-- obs! egenligen vore b�ttre approach att joina tabellern
-- s� fort inre queary anv�nder data fr�n yttre queary (dvs inre ej frist�ende att k�ra) blir det 1 uppsalg per rad i yttre query s� l�ngsamt
-- i detta fallet k�rs den inre subquerien 3503 g�gner dvs f�r varje yttre eftersom den beh�ver info (t-TrackId i inre finns info i FROM i yttre s� den inre �r inte frist�ende) :(
SELECT
	t.TrackId,
	t.Name,
	(SELECT COUNT(*) FROM music.playlist_track pt WHERE pt.TrackId = t.TrackId) -- subqery (hade varit b�ttre med join
FROM
	music.tracks t

---------------------------------------
-- ex p� en bra subquery d�r den inre g�r att k�ra frist�ende och blir d�rmed 2 queries (1 inre och 1 yttre)
SELECT
	AVG(subquery.[Count unique artists]) -- NameOfSubquery.ColumnName fr�n den tillf�lliga tabellen som skapas inom subquery()
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
		RIGHT JOIN music.playlists p ON p.PlaylistID = pt.PlaylistID -- right join f�r att f� med playlists som inte har n�gon artist (right f�r att playlists kommer till h�ger/sist och det �r den som inte skall kapas)
	GROUP BY
		p.PlaylistId, p.Name
	-- ORDER BY [Count unique artists] DESC -- kan inte ha order by i en subquery utan f�r l�ggas utanf�r
) subquery -- NameOfSubquery - vilket blir namnet p� tillf�lliga tabellen som skapas inom paranterserna f�r subquery()