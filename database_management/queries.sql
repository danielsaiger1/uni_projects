--statistische Werte pro Station
WITH Stoerungsdauer AS (
    SELECT 
        station_id,
		typ,
        EXTRACT(EPOCH FROM (ende - start)) / 60  AS dauer_minuten
    FROM 
        Alarm
    WHERE 
		-- hier wird der Zeitraum angegeben
        start >= '2024-11-01'::timestamp
        AND ende <= '2024-11-30'::timestamp
        AND station_id IN (14, 6, 29) -- Liste der Stationen/Maschinen
)
SELECT
	fs.bezeichnung,
	sd.typ,
    COUNT(dauer_minuten) AS anzahl_stoerungen,
    SUM(dauer_minuten) AS sum_stoerungsdauer,
    AVG(dauer_minuten) AS avg_stoerungsdauer,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY dauer_minuten) AS erstes_quartil,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY dauer_minuten) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY dauer_minuten) AS drittes_quartil
FROM 
    Stoerungsdauer sd
JOIN Fertigungsstationen fs
	ON fs.id = sd.station_id
GROUP BY 
	fs.bezeichnung,
	sd.typ
ORDER BY
	fs.bezeichnung ASC


